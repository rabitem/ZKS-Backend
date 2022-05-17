package de.bakife.pumpkininternationalwebservice.repositories;

import de.bakife.pumpkininternationalwebservice.entities.Location;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LocationRepository extends CrudRepository<Location, Integer> {
    /**
     * Finds a Location by the mac address.
     * @param macAddress mac address to find the Location for.
     * @return The Location if it exists, otherwise empty.
     */
    Optional<Location> findByMacAddress(String macAddress);
}