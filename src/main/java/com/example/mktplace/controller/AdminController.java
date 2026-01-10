package com.example.mktplace.controller;

import com.example.mktplace.models.User;
import com.example.mktplace.models.enums.Role;
import com.example.mktplace.services.ProductService;
import com.example.mktplace.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.Map;
import org.springframework.security.access.AccessDeniedException;

@Controller
@RequiredArgsConstructor
public class AdminController {
    private final UserService userService;
    private final ProductService productService;

    @GetMapping("/admin")
    public String admin(Model model, Principal principal) {
        User currentUser = userService.getUserByPrincipal(principal);
        if (currentUser == null || !currentUser.getRoles().contains(Role.ROLE_ADMIN)) {
            throw new AccessDeniedException("Access denied. Admin role required.");
        }

        model.addAttribute("users", userService.list());
        model.addAttribute("user", currentUser);

        return "admin";
    }

    @PostMapping("/admin/user/ban/{id}")
    public String userBan(@PathVariable("id") Long id, Principal principal) {
        User currentUser = userService.getUserByPrincipal(principal);
        if (currentUser == null || !currentUser.getRoles().contains(Role.ROLE_ADMIN)) {
            throw new AccessDeniedException("Access denied. Admin role required.");
        }

        userService.banUser(id);
        return "redirect:/admin";
    }

    @GetMapping("/admin/user/edit/{user}")
    public String userEdit(@PathVariable("user") User user, Model model, Principal principal) {
        User currentUser = userService.getUserByPrincipal(principal);
        if (currentUser == null || !currentUser.getRoles().contains(Role.ROLE_ADMIN)) {
            throw new AccessDeniedException("Access denied. Admin role required.");
        }

        model.addAttribute("user", user);
        model.addAttribute("user", currentUser);
        model.addAttribute("roles", Role.values());
        return "user-edit";
    }

    @PostMapping("/admin/user/edit")
    public String userEdit(@RequestParam("userId") User user, @RequestParam Map<String, String> form, Principal principal) {
        User currentUser = userService.getUserByPrincipal(principal);
        if (currentUser == null || !currentUser.getRoles().contains(Role.ROLE_ADMIN)) {
            throw new AccessDeniedException("Access denied. Admin role required.");
        }

        userService.changeUserRoles(user, form);
        return "redirect:/admin";
    }

    @PostMapping("/admin/create-dummy-data")
    public String createDummyData(Principal principal) {
        User currentUser = userService.getUserByPrincipal(principal);
        if (currentUser == null || !currentUser.getRoles().contains(Role.ROLE_ADMIN)) {
            throw new AccessDeniedException("Access denied. Admin role required.");
        }

        productService.createDummyData();
        return "redirect:/admin";
    }

    @PostMapping("/admin/become-admin")
    public String becomeAdmin(Principal principal) {
        User user = userService.getUserByPrincipal(principal);
        if (user != null && !user.getRoles().contains(Role.ROLE_ADMIN)) {
            user.getRoles().add(Role.ROLE_ADMIN);
            userService.save(user);
        }
        return "redirect:/admin";
    }
}
