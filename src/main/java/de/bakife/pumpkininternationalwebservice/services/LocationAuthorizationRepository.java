package de.bakife.pumpkininternationalwebservice.services;

import de.bakife.pumpkininternationalwebservice.entities.Location;
import de.bakife.pumpkininternationalwebservice.entities.LocationAuthorization;
import de.bakife.pumpkininternationalwebservice.entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LocationAuthorizationRepository extends CrudRepository<LocationAuthorization, Integer> {
    Optional<LocationAuthorization> findByUserAndLocation(User user, Location location);
}
