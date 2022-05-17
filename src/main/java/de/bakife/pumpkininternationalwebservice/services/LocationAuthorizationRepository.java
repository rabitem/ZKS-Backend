package de.bakife.pumpkininternationalwebservice.services;

import de.bakife.pumpkininternationalwebservice.entities.Location;
import de.bakife.pumpkininternationalwebservice.entities.LocationAuthorization;
import de.bakife.pumpkininternationalwebservice.entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LocationAuthorizationRepository extends CrudRepository<LocationAuthorization, Integer> {
    /**
     * Finds a LocationAuthorization by the given Location and User.
     * @param user The User to find the LocationAuthorization for.
     * @param location The Location to find the LocationAuthorization for.
     * @return The LocationAuthorization if it exists, otherwise empty.
     */
    Optional<LocationAuthorization> findByUserAndLocation(User user, Location location);
}
