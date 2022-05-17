package de.bakife.pumpkininternationalwebservice.services;

import de.bakife.pumpkininternationalwebservice.entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, Integer> {
    Optional<User> findByRfid(String rfid);
}