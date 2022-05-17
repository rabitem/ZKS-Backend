package de.bakife.pumpkininternationalwebservice.services;

import de.bakife.pumpkininternationalwebservice.entities.Location;
import de.bakife.pumpkininternationalwebservice.entities.User;
import org.springframework.stereotype.Service;

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

    public HashMap<String, Integer> login(String rfid, String macAddress) {
        HashMap<String, Integer> result = new HashMap<>();

        // fetch user and location
        User user;
        Location location;
        try {
            user = this.checkUserByRfid(rfid);
            location = this.checkLocationByMacAddress(macAddress);
        } catch (IllegalArgumentException e) {
            result.put("Something went wrong while fetching User or Location!", 400);
            return result;
        }

        // check if user is already in location
        if (user.getLocation().getId() != 1) {
            result.put("User is already checked in!", 400);
            return result;
        }

        // check if user has authorization for location
        if (!this.checkAuthorization(user, location)) {
            result.put("User has no authorization for this location!", 403);
            return result;
        }
        return 1;
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
}
