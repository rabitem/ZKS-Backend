package de.bakife.pumpkininternationalwebservice.services;

import de.bakife.pumpkininternationalwebservice.Constants;
import de.bakife.pumpkininternationalwebservice.entities.AuthorizationHistory;
import de.bakife.pumpkininternationalwebservice.entities.Location;
import de.bakife.pumpkininternationalwebservice.entities.User;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
public class LoginService {

    private final UserRepository userRepository;

    private final LocationRepository locationRepository;

    private final LocationAuthorizationRepository locationAuthorizationRepository;

    private final AuthorizationHistoryRepository authorizationHistoryRepository;

    public LoginService(final UserRepository userRepository,
                        final LocationRepository locationRepository,
                        final LocationAuthorizationRepository locationAuthorizationRepository,
                        final AuthorizationHistoryRepository authorizationHistoryRepository) {
        this.userRepository = userRepository;
        this.locationRepository = locationRepository;
        this.locationAuthorizationRepository = locationAuthorizationRepository;
        this.authorizationHistoryRepository = authorizationHistoryRepository;
    }

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
            return result;
        }

        // check if user is already in location
        if (user.getLocation().getId() != 1) {
            this.createAuthorizationHistory(user, location, Constants.USER_ALREADY_LOGGED_IN);
            result.put("status", "400");
            result.put("message", "User already logged in!");
            return result;
        }

        // check if user has authorization for location
        if (!this.checkAuthorization(user, location)) {
            this.createAuthorizationHistory(user, location, Constants.USER_NOT_AUTHORIZED);
            result.put("status", "403");
            result.put("message", "User has no authorization for this location!");
            return result;
        }

        // set user to location
        user.setLocation(location);
        this.userRepository.save(user);

        // create authorization history
        this.createAuthorizationHistory(user, location, Constants.SUCCESSFULLY_LOGGED_IN);

        // return result
        result.put("status", "200");
        result.put("message", user.getName());
        return result;
    }

    private boolean checkAuthorization(User user, Location location) {
        return this.locationAuthorizationRepository.findByUserAndLocation(user, location).isPresent();
    }

    private User checkUserByRfid(String rfid) throws IllegalArgumentException {
        Optional<User> user = this.userRepository.findByRfid(rfid);
        if (user.isEmpty()) {
            throw new IllegalArgumentException("User not found");
        }
        return user.get();
    }

    private Location checkLocationByMacAddress(String macAddress) throws IllegalArgumentException {
        Optional<Location> location = this.locationRepository.findByMacAddress(macAddress);
        if (location.isEmpty()) {
            throw new IllegalArgumentException("Location not found");
        }
        return location.get();
    }

    private void createAuthorizationHistory(User user, Location location, String status) {
        AuthorizationHistory authorizationHistory = new AuthorizationHistory();
        authorizationHistory.setUser(user);
        authorizationHistory.setLocation(location);
        authorizationHistory.setStatus(status);
        authorizationHistory.setTimestamp(new Date());
        this.authorizationHistoryRepository.save(authorizationHistory);
    }
}
