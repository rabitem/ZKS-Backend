package de.bakife.pumpkininternationalwebservice.services;

import de.bakife.pumpkininternationalwebservice.entities.Location;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LocationRepository extends CrudRepository<Location, Integer> {
    Optional<Location> findByMacAddress(String rfid);
}