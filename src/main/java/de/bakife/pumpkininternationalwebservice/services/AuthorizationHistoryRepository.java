package de.bakife.pumpkininternationalwebservice.services;

import de.bakife.pumpkininternationalwebservice.entities.AuthorizationHistory;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AuthorizationHistoryRepository extends CrudRepository<AuthorizationHistory, Integer> {
}
