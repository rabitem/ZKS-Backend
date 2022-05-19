package de.bakife.pumpkininternationalwebservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.TimeZone;

/**
 * The main class of the application.
 */
@SpringBootApplication
public class PumpkinInternationalWebserviceApplication {

	/**
	 * Main entry point for the application.
	 * @param args Command line arguments.
	 */
	public static void main(String[] args) {
		TimeZone.setDefault(TimeZone.getTimeZone("UTC+2"));
		SpringApplication.run(PumpkinInternationalWebserviceApplication.class, args);
	}

}
