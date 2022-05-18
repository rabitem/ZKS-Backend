package de.bakife.pumpkininternationalwebservice.controller;

import de.bakife.pumpkininternationalwebservice.entities.Role;
import de.bakife.pumpkininternationalwebservice.entities.User;
import de.bakife.pumpkininternationalwebservice.repositories.LocationRepository;
import de.bakife.pumpkininternationalwebservice.repositories.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

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
        List<User> users =
                StreamSupport.stream(userRepository.findAll().spliterator(), true)
                        .collect(Collectors.toList());
        model.addAttribute("users", users);
        return "manage_users_view";
    }
}
