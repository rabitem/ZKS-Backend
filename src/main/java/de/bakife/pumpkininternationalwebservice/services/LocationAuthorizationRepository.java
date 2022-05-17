package de.bakife.pumpkininternationalwebservice.services;

import de.bakife.pumpkininternationalwebservice.entities.LocationAuthorization;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LocationAuthorizationRepository extends CrudRepository<LocationAuthorization, Integer> {
}
