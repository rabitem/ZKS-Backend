package de.bakife.pumpkininternationalwebservice.controller;

import de.bakife.pumpkininternationalwebservice.services.TemperatureService;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import javax.validation.Valid;
import javax.validation.constraints.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
public class TemperatureController {

    /**
     * The temperature service.
     */
    private final TemperatureService temperatureService;

    /**
     * Constructor. Initializes the services.
     * @param temperatureService The temperature service.
     */
    public TemperatureController(TemperatureService temperatureService) {
        this.temperatureService = temperatureService;
    }


    /**
     * Put temperature to database
     * @param payload The payload containing the rfid and temperature.
     * @return The response entity.
     */
    @PutMapping(value = "/putTemperature", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> putTemperature(@RequestBody @Valid TemperaturePayload payload) {
        // call service
        this.temperatureService.saveLocationTemperature(payload.getMacAddress(), payload.getTemperature());

        return new ResponseEntity<>(HttpStatus.OK);
    }

    /**
     * Validation class for temperature payload.
     */
    @Data
    static class TemperaturePayload {
        @Pattern(regexp = "^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$", message = "Invalid MAC address")
        private String macAddress;

        @Min(value = 0, message = "Temperature must be between 0 and 100")
        @Max(value = 100, message = "Temperature must be between 0 and 100")
        private float temperature;
    }
}
