package de.bakife.pumpkininternationalwebservice.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Slf4j
@Controller
public class FrontendController {

    /**
     * The frontend main page.
     * @return The frontend page.
     */
    @GetMapping("/")
    public String getIndex() {
        return "index";
    }

    @PostMapping("/manageUsers")
    public String postManageUsers() {
        return "manage_users_view";
    }
}
