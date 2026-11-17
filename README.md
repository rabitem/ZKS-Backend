# ZKS-Backend

RFID access control, temperature collection and the administration UI. Spring Boot
4.1 runs on Java 17 or newer; native builds require GraalVM 25 or newer.
The former experimental Spring Native plugin and JSP engine are replaced by
Spring Boot AOT and Thymeleaf. The existing routes and page controls are retained
in both the executable JAR and the native application.

## Configuration and startup

Set `ZKS_DATABASE_URL`, `ZKS_DATABASE_USER` and `ZKS_DATABASE_PASSWORD` for your
MariaDB instance. The defaults point to `jdbc:mariadb://127.0.0.1:3306/zks` and user
`zks`; no remote credentials are embedded in the application configuration.
Alternatively, standard `SPRING_DATASOURCE_*` environment variables work.

Create the schema in an empty database with [sql/tables.sql](sql/tables.sql).
Existing installations retain their data: startup uses `ddl-auto=validate` and
does not alter tables. The nullable `location.color` column is required by the
existing location model; add it when upgrading a schema created from the older
SQL file. Local `application-dev.properties` files remain outside Git.

```sh
mvn -B verify
java -jar target/pumpkin-international-webservice-22.0.0.1.jar
```

The default port is 8080. `SERVER_PORT` changes it. The UI is served at `/`;
health is available at `/actuator/health`. Administration routes retain the
existing access model and belong behind the deployment's access controls.

## Native build

```sh
mvn -B -Pnative -DskipTests native:compile
./target/pumpkin-international-webservice
```

The native profile uses Spring Boot's supported AOT integration, including the
HTML templates, static assets and reflection metadata for template models. The
build is bounded to two compiler threads and a 3 GiB compiler heap. The optional
[Docker toolchain](scripts/Dockerfile.native-build) supplies GraalVM and Maven;
build it with `docker build -f scripts/Dockerfile.native-build -t zks-native-toolchain scripts`.

## Verification

`mvn verify` exercises real HTTP routing, RFID permissions, login state,
temperature validation, rendered pages, escaping and static assets against H2
under the isolated `test` profile. It does not use the application database.

CI checks Java 17 and 25, builds the native image and runs
[scripts/smoke-http.py](scripts/smoke-http.py) against each packaged artifact and
a disposable MariaDB 11.8 fixture. This also validates the supplied SQL schema;
it never relies on automatic production schema updates. The smoke script
requires a container configured with database/user `zks_smoke` and the synthetic
password `zks_synthetic_password`. It resets that fixture database, launches the
app command passed after `--`, exercises the UI/API and stops its own process.
Pass `--database-port` for a published local database port and `--log` for the
application log. No service is deployed automatically by this repository.
