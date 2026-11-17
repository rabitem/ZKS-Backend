package de.bakife.pumpkininternationalwebservice;

import de.bakife.pumpkininternationalwebservice.entities.*;
import de.bakife.pumpkininternationalwebservice.repositories.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

import static org.junit.jupiter.api.Assertions.*;

/** Real HTTP, MVC templates, validation and persistence against an isolated in-memory database. */
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
class HttpContractTests {
    private static final String MAC = "02:00:00:00:00:01";
    private static final String OTHER_MAC = "02:00:00:00:00:02";
    private final HttpClient client = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(5)).build();
    @Value("${local.server.port}") private int port;
    @Autowired private RoleRepository roles;
    @Autowired private UserRepository users;
    @Autowired private LocationRepository locations;
    @Autowired private LocationAuthorizationRepository authorizations;
    @Autowired private AuthorizationHistoryRepository history;
    @Autowired private LocationTemperatureRepository temperatures;

    @BeforeEach
    void reset() {
        history.deleteAll();
        authorizations.deleteAll();
        temperatures.deleteAll();
        users.deleteAll();
        locations.deleteAll();
        roles.deleteAll();
    }

    private HttpResponse<String> request(String method, String path, String body) throws Exception {
        var builder = HttpRequest.newBuilder(URI.create("http://127.0.0.1:" + port + path))
                .timeout(Duration.ofSeconds(15));
        builder.method(method, body == null ? HttpRequest.BodyPublishers.noBody() : HttpRequest.BodyPublishers.ofString(body));
        if (body != null) builder.header("Content-Type", "application/json");
        return client.send(builder.build(), HttpResponse.BodyHandlers.ofString());
    }

    private User seed(String name, boolean grant) {
        Role role = new Role();
        role.setLabel("Operator");
        roles.save(role);
        Location location = new Location();
        location.setLabel("Test room");
        location.setMacAddress(MAC);
        location.setColor("rgba(63,81,181,1)");
        locations.save(location);
        Location other = new Location();
        other.setLabel("Other room");
        other.setMacAddress(OTHER_MAC);
        locations.save(other);
        User user = new User();
        user.setName(name);
        user.setRfid("fixture-rfid");
        user.setRole(role);
        users.save(user);
        if (grant) {
            LocationAuthorization authorization = new LocationAuthorization();
            authorization.setUser(user);
            authorization.setLocation(location);
            authorizations.save(authorization);
        }
        return user;
    }

    @Test
    void everyViewRendersOnAnEmptyDatabase() throws Exception {
        for (String route : new String[]{"/", "/index", "/home", "/manageUsers", "/manageLocations", "/manageAuthorizations", "/viewLogs", "/viewTemperature"}) {
            var response = request("GET", route, null);
            assertEquals(200, response.statusCode(), route + ": " + response.body());
            assertTrue(response.headers().firstValue("content-type").orElse("").contains("text/html"));
            assertFalse(response.body().contains("<jsp:"), route);
            assertFalse(response.body().contains("<c:"), route);
            assertFalse(response.body().contains("[[${"), route);
        }
    }

    @Test
    void packagedStaticAssetsAreServed() throws Exception {
        for (String asset : new String[]{"/css/main_css.css", "/js/forms_ajax.js", "/js/navigation_ajax.js", "/fonts/Poppins-Regular.ttf", "/sfx/minecraft_eating_sound_effect.mp3"}) {
            var response = request("GET", asset, null);
            assertEquals(200, response.statusCode(), asset);
            assertFalse(response.body().isEmpty(), asset);
        }
    }

    @Test
    void authorizedLoginStatusConflictAndLogoutKeepTheirContracts() throws Exception {
        User user = seed("Fixture operator", true);
        String login = "{\"rfid\":\"fixture-rfid\",\"macAddress\":\"" + MAC + "\"}";
        var response = request("POST", "/login", login);
        assertEquals(200, response.statusCode(), response.body());
        assertTrue(response.body().contains(Constants.SUCCESSFULLY_LOGGED_IN));
        assertTrue(response.body().contains("Fixture operator"));
        assertNotNull(users.findById(user.getId()).orElseThrow().getLocation());
        var state = request("GET", "/isLoggedIn", "{\"rfid\":\"fixture-rfid\"}");
        assertEquals(200, state.statusCode(), state.body());
        assertTrue(state.body().contains("\"loggedIn\":true"));
        assertFalse(state.body().contains("\"lastLogin\":null"));
        var conflict = request("POST", "/login", "{\"rfid\":\"fixture-rfid\",\"macAddress\":\"" + OTHER_MAC + "\"}");
        assertEquals(409, conflict.statusCode(), conflict.body());
        assertEquals(MAC, users.findById(user.getId()).orElseThrow().getLocation().getMacAddress());
        var logout = request("POST", "/login", login);
        assertEquals(200, logout.statusCode(), logout.body());
        assertTrue(logout.body().contains(Constants.SUCCESSFULLY_LOGGED_OUT));
        assertNull(users.findById(user.getId()).orElseThrow().getLocation());
        var loggedOut = request("GET", "/isLoggedIn", "{\"rfid\":\"fixture-rfid\"}");
        assertTrue(loggedOut.body().contains("\"loggedIn\":false"));
        assertTrue(loggedOut.body().contains("\"lastLogin\":null"));
        assertEquals(3, history.count());
    }

    @Test
    void deniedAndUnknownCardsDoNotSetALocation() throws Exception {
        User user = seed("Denied operator", false);
        var denied = request("POST", "/login", "{\"rfid\":\"fixture-rfid\",\"macAddress\":\"" + MAC + "\"}");
        assertEquals(403, denied.statusCode(), denied.body());
        assertNull(users.findById(user.getId()).orElseThrow().getLocation());
        assertEquals(1, history.count());
        var unknown = request("POST", "/login", "{\"rfid\":\"unknown\",\"macAddress\":\"" + MAC + "\"}");
        assertEquals(400, unknown.statusCode(), unknown.body());
        assertEquals(1, history.count());
    }

    @Test
    void temperaturesPersistAndRejectMissingOutOfRangeOrInvalidInput() throws Exception {
        seed("Sensor fixture", true);
        for (int value : new int[]{0, 100}) {
            assertEquals(200, request("PUT", "/putTemperature", "{\"macAddress\":\"" + MAC + "\",\"temperature\":" + value + "}").statusCode());
        }
        for (String body : new String[]{
                "{\"macAddress\":\"" + MAC + "\",\"temperature\":101}",
                "{\"macAddress\":\"" + MAC + "\",\"temperature\":-1}",
                "{\"macAddress\":\"" + MAC + "\"}",
                "{\"temperature\":20}",
                "{\"macAddress\":\"invalid\",\"temperature\":20}"}) {
            var invalid = request("PUT", "/putTemperature", body);
            assertEquals(400, invalid.statusCode(), body + ": " + invalid.body());
            assertTrue(invalid.body().contains("\"message\""));
        }
        assertEquals(2, temperatures.count());
        var chart = request("GET", "/viewTemperature", null);
        assertEquals(200, chart.statusCode(), chart.body());
        assertTrue(chart.body().contains("Test room"));
        assertFalse(chart.body().contains("[[${"));
    }

    @Test
    void managementViewsEscapeUserContentAndHandleUnseatedUsers() throws Exception {
        seed("<script>alert('fixture')</script>", true);
        var response = request("GET", "/manageUsers", null);
        assertEquals(200, response.statusCode(), response.body());
        assertTrue(response.body().contains("&lt;script&gt;"), response.body());
        assertFalse(response.body().contains("<script>alert"));
        assertTrue(response.body().contains("Operator"));
        var authorizationsPage = request("GET", "/manageAuthorizations", null);
        assertEquals(200, authorizationsPage.statusCode(), authorizationsPage.body());
        assertTrue(authorizationsPage.body().contains("Test room"));
    }
}
