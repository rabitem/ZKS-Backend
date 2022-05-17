package de.bakife.pumpkininternationalwebservice.controller;

import de.bakife.pumpkininternationalwebservice.entities.User;
import de.bakife.pumpkininternationalwebservice.services.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@Slf4j
public class MainController {

    private final UserRepository userRepository;

    public MainController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/getUserById/{id}")
    @ResponseBody
    public Optional<User> getUserById(@PathVariable("id") String id) {
        log.info("getUserById requested for Id: {}", id);
        return this.userRepository.findById(Integer.valueOf(id));
    }

    @PostMapping(value = "/login", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public User login(String rfid, String macAddress) {
        log.info("login requested with rfid: {} to {}", rfid, macAddress);
        return this.userRepository.findByUsernameAndPassword(username, password);
    }
}
