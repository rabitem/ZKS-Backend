package de.bakife.pumpkininternationalwebservice.entities;

import lombok.*;

import javax.persistence.*;

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
}
