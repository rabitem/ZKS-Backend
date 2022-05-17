package de.bakife.pumpkininternationalwebservice.entities;

import lombok.*;

import javax.persistence.*;
import java.util.Date;

@Entity(name = "location_temperature")
@Table(name = "location_temperature")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class LocationTemperature {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "loc_id", referencedColumnName = "id")
    private Location location;

    @Column(name = "temperature")
    private float temperature;

    @Column(name = "timestamp")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateCreated;
}
