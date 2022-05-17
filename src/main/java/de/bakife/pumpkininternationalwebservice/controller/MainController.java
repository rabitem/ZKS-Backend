package de.bakife.pumpkininternationalwebservice.controller;

import de.bakife.pumpkininternationalwebservice.entities.Location;
import de.bakife.pumpkininternationalwebservice.entities.User;
import de.bakife.pumpkininternationalwebservice.services.LoginService;
import de.bakife.pumpkininternationalwebservice.services.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@Controller
@Slf4j
public class MainController {

    private final UserRepository userRepository;

    private final LoginService loginService;

    public MainController(final UserRepository userRepository,
                          final LoginService loginService) {
        this.userRepository = userRepository;
        this.loginService = loginService;
    }

    @GetMapping("/getUserById/{id}")
    @ResponseBody
    public Optional<User> getUserById(@PathVariable("id") String id) {
        log.info("getUserById requested for Id: {}", id);
        return this.userRepository.findById(Integer.valueOf(id));
    }

    @PostMapping(value = "/login", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<String> login(@RequestBody Map<String, Object> payload) {
        String rfid = (String) payload.get("rfid");
        String macAddress = (String) payload.get("macAddress");
        log.info("login requested with rfid: {} to {}", rfid, macAddress);
        Map<String, String> result = this.loginService.login(rfid, macAddress);
        return new ResponseEntity<>(result.get("message"), HttpStatus.valueOf(Integer.parseInt(result.get("status"))));
    }
}
