package de.bakife.pumpkininternationalwebservice.repositories;

import de.bakife.pumpkininternationalwebservice.entities.AuthorizationHistory;
import de.bakife.pumpkininternationalwebservice.entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface AuthorizationHistoryRepository extends CrudRepository<AuthorizationHistory, Integer> {
    /**
     * Deletes all authorization history entries for the given user.
     * @param user The user for which the authorization history entries should be deleted.
     */
    @Transactional
    void deleteAllByUser(User user);
}
