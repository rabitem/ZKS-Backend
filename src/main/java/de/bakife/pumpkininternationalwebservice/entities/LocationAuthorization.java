package de.bakife.pumpkininternationalwebservice.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity(name = "location_authorization")
@Table(name = "location_authorization")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LocationAuthorization {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "loc_id", referencedColumnName = "id")
    private Location location;
}
