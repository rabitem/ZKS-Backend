"""Exercise a packaged JVM/native app against the named disposable MariaDB fixture.

Pass the app command after --. Docker command tokens may contain {port}; no shell is used.
"""
import argparse
import json
import os
from pathlib import Path
import re
import socket
import subprocess
import time
import urllib.error
import urllib.request

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--database-container', required=True)
parser.add_argument('--database-port', type=int, default=3306)
parser.add_argument('--database-host', default='127.0.0.1')
parser.add_argument('--app-container')
parser.add_argument('--log', type=Path, required=True)
parser.add_argument('command', nargs=argparse.REMAINDER)
args = parser.parse_args()
command = args.command[1:] if args.command[:1] == ['--'] else args.command
assert command, 'Supply the packaged application command after --'
metadata = json.loads(subprocess.check_output(['docker', 'inspect', args.database_container]))[0]
assert 'MARIADB_DATABASE=zks_smoke' in metadata['Config']['Env'], 'Use the disposable zks_smoke database only'
with socket.socket() as probe:
    probe.bind(('127.0.0.1', 0))
    port = probe.getsockname()[1]
env = dict(os.environ, SERVER_PORT=str(port), SERVER_ADDRESS='0.0.0.0' if args.app_container else '127.0.0.1',
           SPRING_DATASOURCE_URL=f'jdbc:mariadb://{args.database_host}:{args.database_port}/zks_smoke',
           SPRING_DATASOURCE_USERNAME='zks_smoke', SPRING_DATASOURCE_PASSWORD='zks_synthetic_password',
           SPRING_JPA_HIBERNATE_DDL_AUTO='create-drop')
args.log.parent.mkdir(parents=True, exist_ok=True)
checks = []

def request(method, path, payload=None, expected=200):
    body = json.dumps(payload).encode() if payload is not None else None
    req = urllib.request.Request(f'http://127.0.0.1:{port}{path}', data=body, method=method)
    if body is not None:
        req.add_header('Content-Type', 'application/json')
    try:
        response = urllib.request.urlopen(req, timeout=15)
    except urllib.error.HTTPError as error:
        response = error
    data = response.read()
    assert response.status == expected, f'{method} {path}: expected {expected}, got {response.status}: {data[:1000]!r}'
    checks.append({'method': method, 'path': path, 'status': response.status})
    return data

seed = """
INSERT INTO role(id,label) VALUES (101,'Operator');
INSERT INTO location(id,mac_address,label,color) VALUES
 (101,'02:00:00:00:00:01','Test room','rgba(63,81,181,1)'),
 (102,'02:00:00:00:00:02','Other room','rgba(63,81,181,1)');
INSERT INTO `user`(id,name,rfid,role) VALUES
 (101,'Fixture <operator>','fixture-rfid',101),(102,'Denied fixture','denied-rfid',101);
INSERT INTO location_authorization(id,user_id,loc_id) VALUES (101,101,101);
INSERT INTO authorization_history(id,user_id,loc_id,timestamp,status) VALUES (101,101,101,'2026-01-01 12:34:56','Login');
"""
with args.log.open('wb') as log:
    child = subprocess.Popen([token.replace('{port}', str(port)) for token in command], env=env, stdout=log, stderr=subprocess.STDOUT)
    try:
        deadline = time.monotonic() + 120
        while True:
            assert child.poll() is None, f'Application exited early; inspect {args.log}'
            try:
                with urllib.request.urlopen(f'http://127.0.0.1:{port}/actuator/health', timeout=2) as response:
                    if response.status == 200:
                        break
            except (urllib.error.URLError, TimeoutError):
                pass
            assert time.monotonic() < deadline, f'Application did not become healthy; inspect {args.log}'
            time.sleep(0.5)
        subprocess.run(['docker', 'exec', '-i', args.database_container, 'mariadb', '-uzks_smoke', '-pzks_synthetic_password', 'zks_smoke'], input=seed.encode(), check=True, capture_output=True)
        for route in ('/', '/index', '/home', '/manageUsers', '/manageLocations', '/manageAuthorizations', '/viewLogs', '/viewTemperature'):
            html = request('GET', route).decode()
            assert not any(marker in html for marker in ('<jsp:', '<c:', '[[${')), route
            if route == '/manageUsers':
                assert 'Fixture &lt;operator&gt;' in html and '<operator>' not in html
            if route == '/viewLogs':
                assert '01.01.2026' in html and 'colorGreenText' in html
            if route == '/viewTemperature':
                assert 'Test room' in html and 'new Chart' in html
        for path in ('/css/main_css.css', '/js/forms_ajax.js', '/js/navigation_ajax.js', '/fonts/Poppins-Regular.ttf', '/sfx/minecraft_eating_sound_effect.mp3'):
            assert request('GET', path), path
        mac = '02:00:00:00:00:01'
        request('POST', '/login', {'rfid': 'unknown', 'macAddress': mac}, 400)
        request('POST', '/login', {'rfid': 'denied-rfid', 'macAddress': mac}, 403)
        login = json.loads(request('POST', '/login', {'rfid': 'fixture-rfid', 'macAddress': mac}))
        assert login == {'message': 'Login', 'user': 'Fixture <operator>'}
        status = json.loads(request('GET', '/isLoggedIn', {'rfid': 'fixture-rfid'}))
        assert status['loggedIn'] is True and re.fullmatch(r'\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}', status['lastLogin'])
        request('POST', '/login', {'rfid': 'fixture-rfid', 'macAddress': '02:00:00:00:00:02'}, 409)
        assert json.loads(request('POST', '/login', {'rfid': 'fixture-rfid', 'macAddress': mac}))['message'] == 'Logout'
        assert json.loads(request('GET', '/isLoggedIn', {'rfid': 'fixture-rfid'})) == {'loggedIn': False, 'lastLogin': None}
        for value in (0, 100):
            request('PUT', '/putTemperature', {'macAddress': mac, 'temperature': value})
        for payload in ({'macAddress': mac, 'temperature': -1}, {'macAddress': mac, 'temperature': 101}, {'macAddress': mac}, {'temperature': 20}, {'macAddress': 'invalid', 'temperature': 20}):
            error = json.loads(request('PUT', '/putTemperature', payload, 400))
            assert error['message']
        assert 'Test room' in request('GET', '/viewTemperature').decode()
        print(json.dumps({'status': 'passed', 'requests': len(checks), 'database': 'isolated MariaDB', 'checks': checks}, indent=2))
    finally:
        if args.app_container:
            subprocess.run(['docker', 'stop', '--time', '10', args.app_container], capture_output=True, timeout=30)
        if child.poll() is None:
            child.terminate()
            try:
                child.wait(timeout=15)
            except subprocess.TimeoutExpired:
                child.kill()
                child.wait(timeout=5)
