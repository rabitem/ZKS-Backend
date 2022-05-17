package de.bakife.pumpkininternationalwebservice.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity(name = "location")
@Table(name = "location")
@Data
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
}
