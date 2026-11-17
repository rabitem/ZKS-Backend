package de.bakife.pumpkininternationalwebservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.aot.hint.annotation.RegisterReflectionForBinding;
import de.bakife.pumpkininternationalwebservice.entities.*;

import java.util.TimeZone;

/**
 * The main class of the application.
 */
@SpringBootApplication
@RegisterReflectionForBinding({User.class, Role.class, Location.class,
        LocationAuthorization.class, LocationTemperature.class, AuthorizationHistory.class})
public class PumpkinInternationalWebserviceApplication {

	/**
	 * Main entry point for the application.
	 * @param args Command line arguments.
	 */
	public static void main(String[] args) {
		SpringApplication.run(PumpkinInternationalWebserviceApplication.class, args);
	}

}
