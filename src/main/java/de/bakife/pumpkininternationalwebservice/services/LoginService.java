package de.bakife.pumpkininternationalwebservice.services;

import de.bakife.pumpkininternationalwebservice.Constants;
import de.bakife.pumpkininternationalwebservice.entities.AuthorizationHistory;
import de.bakife.pumpkininternationalwebservice.entities.Location;
import de.bakife.pumpkininternationalwebservice.entities.User;
import de.bakife.pumpkininternationalwebservice.repositories.AuthorizationHistoryRepository;
import de.bakife.pumpkininternationalwebservice.repositories.LocationAuthorizationRepository;
import de.bakife.pumpkininternationalwebservice.repositories.LocationRepository;
import de.bakife.pumpkininternationalwebservice.repositories.UserRepository;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * @author rabitem
 */
@Service
public class LoginService {

    /**
     * The User repository.
     */
    private final UserRepository userRepository;

    /**
     * The Location repository.
     */
    private final LocationRepository locationRepository;

    /**
     * The Local Authorization repository.
     */
    private final LocationAuthorizationRepository locationAuthorizationRepository;

    /**
     * The Authorization history repository.
     */
    private final AuthorizationHistoryRepository authorizationHistoryRepository;

    /**
     * Constructor. Initializes the repositories.
     * @param userRepository The user repository.
     * @param locationRepository The location repository.
     * @param locationAuthorizationRepository The location authorization repository.
     * @param authorizationHistoryRepository The authorization history repository.
     */
    public LoginService(final UserRepository userRepository,
                        final LocationRepository locationRepository,
                        final LocationAuthorizationRepository locationAuthorizationRepository,
                        final AuthorizationHistoryRepository authorizationHistoryRepository) {
        this.userRepository = userRepository;
        this.locationRepository = locationRepository;
        this.locationAuthorizationRepository = locationAuthorizationRepository;
        this.authorizationHistoryRepository = authorizationHistoryRepository;
    }

    /**
     * Login a user with the given rfid and macAddress.
     * @param rfid The rfid of the user.
     * @param macAddress The macAddress of the user.
     * @return A map with the status and the message.
     */
    public Map<String, String> login(String rfid, String macAddress) {
        HashMap<String, String> result = new HashMap<>();

        // fetch user and location
        User user;
        Location location;
        try {
            user = this.checkUserByRfid(rfid);
            location = this.checkLocationByMacAddress(macAddress);
        } catch (IllegalArgumentException e) {
            result.put("status", "400");
            result.put("message", "Something went wrong while fetching User or Location!");
            result.put("user", null);
            return result;
        }

        // add user to result
        result.put("user", user.getName());

        // if user is logged in
        if (Objects.nonNull(user.getLocation())) {
            // log out user
            if (location.getId() == user.getLocation().getId()) {
                user.setLocation(null);
                this.userRepository.save(user);

                this.createAuthorizationHistory(user, location, Constants.SUCCESSFULLY_LOGGED_OUT);

                result.put("status", "200");
                result.put("message", Constants.SUCCESSFULLY_LOGGED_OUT);
            }
            // user logged in elsewhere, throw error
            else {
                this.createAuthorizationHistory(user, location, Constants.USER_ALREADY_LOGGED_IN_ELSEWHERE);
                result.put("status", "409");
                result.put("message", Constants.USER_ALREADY_LOGGED_IN_ELSEWHERE);
            }
            return result;
        }

        // check if user is authorized to enter location
        if (this.checkAuthorization(user, location)) {
            user.setLocation(location);
            this.userRepository.save(user);

            this.createAuthorizationHistory(user, location, Constants.SUCCESSFULLY_LOGGED_IN);

            result.put("status", "200");
            result.put("message", Constants.SUCCESSFULLY_LOGGED_IN);
            return result;
        }
        // user not authorized, throw error
        else {
            this.createAuthorizationHistory(user, location, Constants.USER_NOT_AUTHORIZED);
            result.put("status", "403");
            result.put("message", Constants.USER_NOT_AUTHORIZED);
            return result;
        }
    }

    /**
     * Checks if user has enough authorization for location.
     * @param user User to check.
     * @param location Location to check.
     * @return True if user has authorization for location, false otherwise.
     */
    private boolean checkAuthorization(User user, Location location) {
        return this.locationAuthorizationRepository.findByUserAndLocation(user, location).isPresent();
    }

    /**
     * Checks if user exists by rfid.
     * @param rfid rfid of user
     * @return user
     * @throws IllegalArgumentException if user does not exist
     */
    public User checkUserByRfid(String rfid) throws IllegalArgumentException {
        Optional<User> user = this.userRepository.findByRfid(rfid);
        if (user.isEmpty()) {
            throw new IllegalArgumentException("User not found");
        }
        return user.get();
    }

    /**
     * Checks if Location exists by mac address.
     * @param macAddress Mac address of the location.
     * @return Location object.
     * @throws IllegalArgumentException If Location does not exist.
     */
    private Location checkLocationByMacAddress(String macAddress) throws IllegalArgumentException {
        Optional<Location> location = this.locationRepository.findByMacAddress(macAddress);
        if (location.isEmpty()) {
            throw new IllegalArgumentException("Location not found");
        }
        return location.get();
    }

    /**
     * Create and persist authorization history
     * @param user User
     * @param location Location
     * @param status Status
     */
    private void createAuthorizationHistory(User user, Location location, String status) {
        AuthorizationHistory authorizationHistory = new AuthorizationHistory();
        authorizationHistory.setUser(user);
        authorizationHistory.setLocation(location);
        authorizationHistory.setStatus(status);
        authorizationHistory.setTimestamp(new Date());
        this.authorizationHistoryRepository.save(authorizationHistory);
    }
}
