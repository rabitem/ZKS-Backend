package de.bakife.pumpkininternationalwebservice.services;


import de.bakife.pumpkininternationalwebservice.entities.Location;
import de.bakife.pumpkininternationalwebservice.entities.LocationTemperature;
import de.bakife.pumpkininternationalwebservice.repositories.LocationRepository;
import de.bakife.pumpkininternationalwebservice.repositories.LocationTemperatureRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;

@Service
@Slf4j
public class TemperatureService {

    private final LocationTemperatureRepository locationTemperatureRepository;


    private final LocationRepository locationRepository;

    public TemperatureService(final LocationTemperatureRepository locationTemperatureRepository,
                              final LocationRepository locationRepository) {
        this.locationTemperatureRepository = locationTemperatureRepository;
        this.locationRepository = locationRepository;
    }


    public void saveLocationTemperature(final String macAddress, final float temperature) throws IllegalArgumentException {
        Location location;
        try {
            location = this.checkLocationByMacAddress(macAddress);
        } catch (IllegalArgumentException e) {
            log.error("Could not fetch location by macAddress: {}", macAddress);
            throw new IllegalArgumentException("Location not found");
        }
        LocationTemperature locationTemperature = new LocationTemperature();
        locationTemperature.setLocation(location);
        locationTemperature.setTemperature(temperature);
        locationTemperature.setTimestamp(new Date());
        this.locationTemperatureRepository.save(locationTemperature);
    }

    /**
     * Checks if Location exists by mac address.
     *
     * @param macAddress Mac address of the location.
     * @return Location object.
     * @throws IllegalArgumentException If Location does not exist.
     */
    private Location checkLocationByMacAddress(String macAddress) throws IllegalArgumentException {
        Optional<Location> location = this.locationRepository.findByMacAddress(macAddress);
        if (location.isEmpty()) {
            throw new IllegalArgumentException("Location not found");
        }
        return location.get();

    }

}
