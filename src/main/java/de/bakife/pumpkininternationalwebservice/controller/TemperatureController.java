package de.bakife.pumpkininternationalwebservice.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;

@Controller
@Slf4j
public class TemperatureController {

    public TemperatureController() {
        log.info("TemperatureController created");
    }

    public String getTemperature() {
        return "temperature";
    }
}
