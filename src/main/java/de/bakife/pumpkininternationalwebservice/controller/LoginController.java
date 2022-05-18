package de.bakife.pumpkininternationalwebservice.controller;

import de.bakife.pumpkininternationalwebservice.entities.User;
import de.bakife.pumpkininternationalwebservice.services.LoginService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

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
     * Constructor. Initializes the services.
     * @param loginService The login service.
     */
    public LoginController(final LoginService loginService) {
        this.loginService = loginService;
    }

    /**
     * Login a user with the given rfid and macAddress.
     * @param payload The payload containing the rfid and macAddress.
     * @return The response entity.
     */
    @PostMapping(value = "/login", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<String> login(@RequestBody Map<String, Object> payload) {
        String rfid = (String) payload.get("rfid");
        String macAddress = (String) payload.get("macAddress");
        log.info("login requested with rfid: {} to {}", rfid, macAddress);
        Map<String, String> result = this.loginService.login(rfid, macAddress);
        return new ResponseEntity<>(result.get("message"), HttpStatus.valueOf(Integer.parseInt(result.get("status"))));
    }

    /**
     * Checks whether user is logged in or not
     * @param payload The payload containing the rfid.
     * @return True if logged in; false if logged out.
     */
    @GetMapping(value = "/isLoggedIn", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<Boolean> isLoggedIn(@RequestBody Map<String, Object> payload){
        String rfid = (String) payload.get("rfid");
        log.info("user is logged in request with rfid: {}", rfid);
        User user = this.loginService.checkUserByRfid(rfid);
        return new ResponseEntity<>(user.getLocation().getId() != 1, HttpStatus.OK);
    }


}
