package de.bakife.pumpkininternationalwebservice.controller;

import de.bakife.pumpkininternationalwebservice.entities.Location;
import de.bakife.pumpkininternationalwebservice.entities.LocationAuthorization;
import de.bakife.pumpkininternationalwebservice.entities.Role;
import de.bakife.pumpkininternationalwebservice.entities.User;
import de.bakife.pumpkininternationalwebservice.repositories.LocationAuthorizationRepository;
import de.bakife.pumpkininternationalwebservice.repositories.LocationRepository;
import de.bakife.pumpkininternationalwebservice.repositories.RoleRepository;
import de.bakife.pumpkininternationalwebservice.repositories.UserRepository;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
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
     * the location authorization repository.
     */
    private final LocationAuthorizationRepository locationAuthorizationRepository;

    /**
     * Constructor. Initializes the services.
     * @param userRepository the user repository.
     * @param locationRepository the location repository.
     * @param roleRepository the role repository.
     */
    public FrontendController(final UserRepository userRepository,
                              final LocationRepository locationRepository,
                              final RoleRepository roleRepository,
                              final LocationAuthorizationRepository locationAuthorizationRepository) {
        this.userRepository = userRepository;
        this.locationRepository = locationRepository;
        this.roleRepository = roleRepository;
        this.locationAuthorizationRepository = locationAuthorizationRepository;
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
     * The location management page.
     * @param model The model.
     * @return The location management page.
     */
    @GetMapping("manageLocations")
    public String getManageLocations(Model model) {
        List<Location> locations =
                StreamSupport.stream(this.locationRepository.findAll().spliterator(), true)
                        .collect(Collectors.toList());
        model.addAttribute("locations", locations);
        return "manage_locations_view";
    }

    @GetMapping("/manageAuthorizations")
    public String getManageAuthorizations(Model model) {
        List<LocationAuthorization> authorizations =
                StreamSupport.stream(this.locationAuthorizationRepository.findAll().spliterator(), true)
                        .collect(Collectors.toList());
        model.addAttribute("authorizations", authorizations);
        return "manage_authorizations_view";
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
        user.setLocation(null);

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
        try {
            userRepository.deleteById(removeUserByIdPayload.getId());
        } catch (EmptyResultDataAccessException e) {
            log.error("User with id {} not found", removeUserByIdPayload.getId());
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(HttpStatus.OK);
    }

    /**
     * Adds a location to the database.
     * @param addLocationPayload The payload containing the location data.
     * @return The response entity.
     */
    @PutMapping("/addLocation")
    public ResponseEntity<?> putLocation(@RequestBody @Valid AddLocationPayload addLocationPayload) {
        log.info("Adding location request: {}", addLocationPayload);

        // create location
        Location location = new Location();
        location.setLabel(addLocationPayload.getLabel());
        location.setMacAddress(addLocationPayload.getMacAddress());

        // save location
        locationRepository.save(location);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    /**
     * Removes a location from the database.
     * @param removeLocationByIdPayload The payload containing the location id.
     * @return The response entity.
     */
    @DeleteMapping("/removeLocationById")
    public ResponseEntity<?> deleteLocationById(@RequestBody @Valid  RemoveLocationByIdPayload removeLocationByIdPayload) {
        log.info("Removing location request for id: {}", removeLocationByIdPayload.getId());

        // remove location
        try {
            locationRepository.deleteById(removeLocationByIdPayload.getId());
        } catch (EmptyResultDataAccessException e) {
            log.error("Location with id {} not found", removeLocationByIdPayload.getId());
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(HttpStatus.OK);
    }

    /**
     * Adds a location authorization to the database.
     * @param addAuthorizationPayload The payload containing the location authorization data.
     * @return The response entity.
     */
    @PutMapping("/addAuthorization")
    public ResponseEntity<?> putAuthorization(@RequestBody @Valid AddAuthorizationPayload addAuthorizationPayload) {
        log.info("Adding authorization request: {}", addAuthorizationPayload);

        if (locationAuthorizationRepository.findByUserAndLocation(this.userRepository.findById(addAuthorizationPayload.getUserId()).orElseThrow(),
                this.locationRepository.findById(addAuthorizationPayload.getLocationId()).orElseThrow()).isPresent()) {
            // throw error, already exists
            log.info("Authorization from userId {} to locationId {} already exists",
                    addAuthorizationPayload.getUserId(), addAuthorizationPayload.getLocationId());
            return new ResponseEntity<>("Authorization already exists!", HttpStatus.BAD_REQUEST);
        }

        // create location authorization
        LocationAuthorization locationAuthorization = new LocationAuthorization();
        locationAuthorization.setUser(this.userRepository.findById(addAuthorizationPayload.getUserId()).orElseThrow());
        locationAuthorization.setLocation(this.locationRepository.findById(addAuthorizationPayload.getLocationId()).orElseThrow());

        // save location authorization
        locationAuthorizationRepository.save(locationAuthorization);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    /**
     * Removes a location authorization from the database.
     * @param removeAuthorizationPayload The payload containing the location authorization id.
     * @return The response entity.
     */
    @DeleteMapping("/removeAuthorization")
    public ResponseEntity<?> deleteAuthorization(@RequestBody @Valid RemoveAuthorizationPayload removeAuthorizationPayload) {
        log.info("Removing authorization request for id: {}", removeAuthorizationPayload.getId());

        // remove location authorization
        try {
            locationAuthorizationRepository.deleteById(removeAuthorizationPayload.getId());
        } catch (EmptyResultDataAccessException e) {
            log.info("Authorization with id {} does not exist", removeAuthorizationPayload.getId());
            return new ResponseEntity<>("Authorization does not exist!", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(HttpStatus.OK);
    }

    /**
     * The payload for removing authorization by id.
     */
    @Data
    static class RemoveAuthorizationPayload {
        @Positive(message = "Authorization id must be positive")
        private int id;
    }

    /**
     * Add authorization payload.
     */
    @Data
    static class AddAuthorizationPayload {
        @Positive(message = "User id must be positive")
        private int userId;
        @Positive(message = "Location id must be positive")
        private int locationId;
    }

    /**
     * Removes a location from the database.
     */
    @Data
    static class RemoveLocationByIdPayload {
        @Positive
        private int id;
    }

    /**
     * The payload for the add location endpoint.
     */
    @Data
     static class AddLocationPayload {
        @Pattern(regexp = "^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$", message = "Invalid MAC address")
        private String macAddress;
        @NotBlank(message = "Label is required")
        private String label;
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
