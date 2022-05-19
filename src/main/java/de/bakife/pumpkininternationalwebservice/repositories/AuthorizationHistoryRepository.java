package de.bakife.pumpkininternationalwebservice.repositories;

import de.bakife.pumpkininternationalwebservice.entities.AuthorizationHistory;
import de.bakife.pumpkininternationalwebservice.entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Repository
public interface AuthorizationHistoryRepository extends CrudRepository<AuthorizationHistory, Integer> {
    /**
     * Deletes all authorization history entries for the given user.
     * @param user The user for which the authorization history entries should be deleted.
     */
    @Transactional
    void deleteAllByUser(User user);

    /**
     * Finds the latest authorization history entry for the given user and status.
     * @param user The user for which the authorization history entry should be found.
     * @param status The status of the authorization history entry.
     * @return The authorization history entry.
     */
    Optional<AuthorizationHistory> findFirstByUserAndStatusOrderByTimestampDesc(User user, String status);

}
