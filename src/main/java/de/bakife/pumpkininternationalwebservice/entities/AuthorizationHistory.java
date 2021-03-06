package de.bakife.pumpkininternationalwebservice.entities;

import de.bakife.pumpkininternationalwebservice.Constants;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Entity(name = "authorization_history")
@Table(name = "authorization_history")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AuthorizationHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "loc_id", referencedColumnName = "id")
    private Location location;

    @Column(name = "timestamp")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timestamp;

    @Column(name = "status")
    private String status;

    @Transient
    @Setter
    private boolean wasSuccessful = false;

    /**
     * Returns if the authorization was successful.
     * @return True if the authorization was successful, false otherwise.
     */
    public boolean getWasSuccessful() {
        return this.status.equals(Constants.SUCCESSFULLY_LOGGED_IN) ||
                this.status.equals(Constants.SUCCESSFULLY_LOGGED_OUT);
    }
}
