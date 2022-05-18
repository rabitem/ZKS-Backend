package de.bakife.pumpkininternationalwebservice.controller;

import de.bakife.pumpkininternationalwebservice.entities.Location;
import de.bakife.pumpkininternationalwebservice.entities.Role;
import de.bakife.pumpkininternationalwebservice.entities.User;
import de.bakife.pumpkininternationalwebservice.repositories.LocationRepository;
import de.bakife.pumpkininternationalwebservice.repositories.RoleRepository;
import de.bakife.pumpkininternationalwebservice.repositories.UserRepository;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Positive;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Slf4j
@Controller
public class FrontendController {

    /**
     * the user repository.
     */
    private final UserRepository userRepository;

    /**
     * the location repository.
     */
    private final LocationRepository locationRepository;

    /**
     * the role repository.
     */
    private final RoleRepository roleRepository;

    /**
     * Constructor. Initializes the services.
     * @param userRepository the user repository.
     * @param locationRepository the location repository.
     * @param roleRepository the role repository.
     */
    public FrontendController(final UserRepository userRepository,
                              final LocationRepository locationRepository,
                              final RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.locationRepository = locationRepository;
        this.roleRepository = roleRepository;
    }

    /**
     * The frontend main page.
     * @return The frontend page.
     */
    @GetMapping("/")
    public String getIndex(Model model) {
        List<Role> roles = StreamSupport.stream(this.roleRepository.findAll().spliterator(), true)
                        .collect(Collectors.toList());
        List<User> users = StreamSupport.stream(this.userRepository.findAll().spliterator(), true)
                        .collect(Collectors.toList());
        List<Location> locations = StreamSupport.stream(this.locationRepository.findAll().spliterator(), true)
                .collect(Collectors.toList());
        model.addAttribute("roles", roles);
        model.addAttribute("users", users);
        model.addAttribute("locations", locations);
        return "index";
    }

    /**
     * The user management page.
     * @return The user management page.
     */
    @GetMapping("/manageUsers")
    public String getManageUsers(Model model) {
        List<User> users =
                StreamSupport.stream(this.userRepository.findAll().spliterator(), true)
                        .collect(Collectors.toList());
        model.addAttribute("users", users);
        return "manage_users_view";
    }

    /**
     * Adds a user to the database.
     * @param addUserPayload The payload containing the user data.
     * @return The response entity.
     */
    @PutMapping("/addUser")
    public ResponseEntity<?> putUser(@RequestBody @Valid AddUserPayload addUserPayload) {
        log.info("Adding user request: {}", addUserPayload);

        // create user
        User user = new User();
        user.setRfid(addUserPayload.getRfid());
        user.setName(addUserPayload.getName());
        user.setRole(roleRepository.findByLabel(addUserPayload.getRole()).orElseThrow());
        user.setLocation(locationRepository.findById(1).orElseThrow());

        // save user
        userRepository.save(user);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    /**
     * Removes a user from the database.
     * @param removeUserByIdPayload The payload containing the user id.
     * @return The response entity.
     */
    @DeleteMapping("/removeUserById")
    public ResponseEntity<?> deleteUserById(@RequestBody @Valid FrontendController.RemoveUserByIdPayload removeUserByIdPayload) {
        log.info("Removing user request for id: {}", removeUserByIdPayload.getId());

        // remove user
        userRepository.deleteById(removeUserByIdPayload.getId());

        return new ResponseEntity<>(HttpStatus.OK);
    }

    /**
     * The payload for adding a user.
     */
    @Data
    static class AddUserPayload {
        @NotBlank(message = "Name is required")
        private String name;
        @NotBlank(message = "Role is required")
        private String role;
        @NotBlank(message = "RFID must not be empty")
        private String rfid;
    }

    /**
     * The payload for removing a user.
     */
    @Data
    static class RemoveUserByIdPayload {
        @Positive(message = "id must be positive")
        private int id;
    }
}
