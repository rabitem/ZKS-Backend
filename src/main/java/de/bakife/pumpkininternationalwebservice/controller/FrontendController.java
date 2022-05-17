package de.bakife.pumpkininternationalwebservice.controller;

import de.bakife.pumpkininternationalwebservice.entities.Role;
import de.bakife.pumpkininternationalwebservice.repositories.LocationRepository;
import de.bakife.pumpkininternationalwebservice.repositories.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Slf4j
@Controller
public class FrontendController {

    private final UserRepository userRepository;

    private final LocationRepository locationRepository;

    public FrontendController(final UserRepository userRepository,
                              final LocationRepository locationRepository) {
        this.userRepository = userRepository;
        this.locationRepository = locationRepository;
    }

    /**
     * The frontend main page.
     * @return The frontend page.
     */
    @GetMapping("/")
    public String getIndex() {
        return "index";
    }

    /**
     * The user management page.
     * @return The user management page.
     */
    @PostMapping("/manageUsers")
    public String postManageUsers(Model model) {
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("locations", locationRepository.findAll());
        return "manage_users_view";
    }
}
