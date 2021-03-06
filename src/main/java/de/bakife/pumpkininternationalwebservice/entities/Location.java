package de.bakife.pumpkininternationalwebservice.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity(name = "location")
@Table(name = "location")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Location {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "mac_address", nullable = false)
    private String macAddress;

    @Column(name = "label", nullable = false)
    private String label;

    @Column(name = "color")
    private String color;

    @OneToMany(mappedBy = "location", fetch = FetchType.EAGER)
    private List<LocationTemperature> locationTemperatures;
}
