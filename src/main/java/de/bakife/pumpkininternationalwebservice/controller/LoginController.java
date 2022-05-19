package de.bakife.pumpkininternationalwebservice.controller;

import com.fasterxml.jackson.annotation.JsonFormat;
import de.bakife.pumpkininternationalwebservice.Constants;
import de.bakife.pumpkininternationalwebservice.entities.User;
import de.bakife.pumpkininternationalwebservice.repositories.AuthorizationHistoryRepository;
import de.bakife.pumpkininternationalwebservice.services.LoginService;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import java.util.Date;
import java.util.Map;
import java.util.NoSuchElementException;

/**
 * @author rabitem
 * @author senseiB2
 */
@Controller
@Slf4j
public class LoginController {


    /**
     * The Login service.
     */
    private final LoginService loginService;

    /**
     * The Authorization history repository.
     */
    private final AuthorizationHistoryRepository authorizationHistoryRepository;

    /**
     * Constructor. Initializes the services.
     * @param loginService The login service.
     * @param authorizationHistoryRepository The authorization history repository.
     */
    public LoginController(final LoginService loginService, AuthorizationHistoryRepository authorizationHistoryRepository) {
        this.loginService = loginService;
        this.authorizationHistoryRepository = authorizationHistoryRepository;
    }

    /**
     * Login a user with the given rfid and macAddress.
     * @param payload The payload containing the rfid and macAddress.
     * @return The response entity.
     */
    @PostMapping(value = "/login", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<LoginResponse> login(@RequestBody Map<String, Object> payload) {
        String rfid = (String) payload.get("rfid");
        String macAddress = (String) payload.get("macAddress");
        log.info("login requested with rfid: {} to {}", rfid, macAddress);
        Map<String, String> result = this.loginService.login(rfid, macAddress);

        LoginResponse response = new LoginResponse();
        response.setMessage(result.get("message"));
        response.setUser(result.get("user"));
        return new ResponseEntity<>(response, HttpStatus.valueOf(Integer.parseInt(result.get("status"))));
    }

    /**
     * Determine if the given user is logged in.
     * @param request The request containing the rfid.
     * @return The response entity.
     */
    @GetMapping(value = "/isLoggedIn", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> isLoggedIn(@RequestBody @Valid IsLoggedInRequest request) {
        log.info("isLoggedIn requested with rfid: {}", request.getRfid());
        try {
            User user = this.loginService.checkUserByRfid(request.getRfid());
            IsLoggedInResponse response = new IsLoggedInResponse();
            response.setLoggedIn(this.loginService.isLoggedIn(user));

            if (response.isLoggedIn()) {
                response.setLastLogin(this.authorizationHistoryRepository.findFirstByUserAndStatusOrderByTimestampDesc(
                        user, Constants.SUCCESSFULLY_LOGGED_IN).orElseThrow().getTimestamp());
                log.info(response.getLastLogin().toString());
            } else {
                response.setLastLogin(null);
            }
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (IllegalArgumentException | NoSuchElementException e) {
            log.error("Error while checking if user is logged in: {}", e.getMessage());
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    /**
     * The payload for the isLoggedIn request.
     */
    @Data
    static class IsLoggedInRequest {
        @NotBlank(message = "RFID must be given!")
        private String rfid;
    }

    @Data
    static class IsLoggedInResponse {
        private boolean loggedIn;
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Europe/Berlin")
        private Date lastLogin;
    }

    /**
     * Response entity for login.
     */
    @Data
    static class LoginResponse {
        private String message;
        private String user;
    }
}
