package de.bakife.pumpkininternationalwebservice.repositories;

import de.bakife.pumpkininternationalwebservice.entities.Role;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoleRepository extends CrudRepository<Role, Integer> {
    Optional<Role> findByLabel(String label);
}
