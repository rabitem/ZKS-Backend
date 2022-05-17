package de.bakife.pumpkininternationalwebservice.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity(name = "user")
@Table()
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "password", nullable = true)
    @JsonProperty( value = "password", access = JsonProperty.Access.WRITE_ONLY)
    private String password;

    @Column(name = "rfid", nullable = false)
    private String rfid;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "current_loc", referencedColumnName = "id")
    private Location location;

    @Column(name = "role", nullable = true)
    @Enumerated(EnumType.ORDINAL)
    private Role role;

    @OneToMany(mappedBy = "user")
    @Column(nullable = true)
    private List<LocationAuthorization> locationAuthorizations;
}
