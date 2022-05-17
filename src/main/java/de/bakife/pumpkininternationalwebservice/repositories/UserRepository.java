package de.bakife.pumpkininternationalwebservice.repositories;

import de.bakife.pumpkininternationalwebservice.entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, Integer> {
    /**
     * Finds a User by the given rfid.
     * @param rfid The rfid to find the User for.
     * @return
     */
    Optional<User> findByRfid(String rfid);
}