package com.hiral.belt.controllers;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hiral.belt.models.Pack;
import com.hiral.belt.models.User;
import com.hiral.belt.services.PackageService;
import com.hiral.belt.services.RoleService;
import com.hiral.belt.services.UserService;
import com.hiral.belt.validator.UserValidator;

@Controller
@RequestMapping("/")
public class BeltExam {
	private UserService userService;
	private RoleService roleService;
	private UserValidator userValidator;
	private PackageService packageService;

	public BeltExam(UserService userService, RoleService roleService, UserValidator userValidator,
			PackageService packageService) {
		this.packageService = packageService;
		this.userService = userService;
		this.roleService = roleService;
		this.userValidator = userValidator;
	}

	@PostMapping("/registration")
	public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model,
			HttpSession session, RedirectAttributes flash) {
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return "login_register";
		}

		if (userService.findByUsername(user.getUsername()) != null
				|| userService.findByEmail(user.getEmail()) != null) {
			flash.addFlashAttribute("userExists", "User already exists");
			return "redirect:/registration";
		}
		if (roleService.findByName("ROLE_ADMIN").getUsers().size() < 1) {
			userService.saveUserWithAdminRole(user);
		} else {
			userService.saveWithUserRole(user);
		}

		return "redirect:/registration";
	}

	@RequestMapping({ "/registration", "/login" })
	public String login(@ModelAttribute("user") User user,
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, Model model) {
		if (error != null) {
			model.addAttribute("errorMessage", "* Invalid Email or Password");
		}
		if (logout != null) {
			model.addAttribute("logoutMessage", "Logout Successfull!");
		}
		return "login_register";
	}

	@RequestMapping(value = { "/", "/home" })
	public String dashboard(Principal principal, Model model, @ModelAttribute("package") Pack p) {
		User user = userService.findByUsername(principal.getName());
		model.addAttribute("currentUser", user);
		model.addAttribute("allUsers", userService.findAll());
		model.addAttribute("packages", packageService.findAll());
		if (user.isAdmin()) {
			model.addAttribute("allUsers", userService.findAll());
			model.addAttribute("packages", packageService.findAll());
			return "admin";
		}
		if (user.getPackages() == null) {
			return "choosePackage";
		}
		return "profile";
	}

	@PostMapping("/package/add")
	public String addPackage(@Valid @ModelAttribute("package") Pack p, BindingResult result) {
		if (result.hasErrors()) {
			return "redirect:/";
		}
		p.setAvailability(true);
		packageService.addPackage(p);
		return "redirect:/";
	}

	@RequestMapping("/package/update/{id}")
	public String editPackage(@PathVariable("id") Long id, Model model) {
		Pack pack = packageService.findOne(id);
		if (pack.isAvailability() == true) {
			pack.setAvailability(false);
			packageService.update(pack);
			return "redirect:/";
		}
		pack.setAvailability(true);
		packageService.update(pack);
		return "redirect:/";
	}

	@RequestMapping("/package/delete/{id}")
	public String delete(@PathVariable("id") Long id) {
		packageService.deleteById(id);
		return "redirect:/";
	}

	@RequestMapping("/user/pack/add/{id}")
	public String addPackToUser(@PathVariable("id") Long id, @RequestParam(value = "id") Long packId,
			@RequestParam(value = "dueDate") int dueDate) {
		User user = userService.findById(id);
		user.setPackages(packageService.findOne(packId));
		userService.update(user);
		return "redirect:/";
	}

	@RequestMapping("/user/edit/{id}")
	public String editUser(@PathVariable("id") Long id, Model model, @ModelAttribute("users") User user) {
		model.addAttribute("user", userService.findById(id));
		model.addAttribute("packages", packageService.findAll());
		return "editUser";
	}

	@PostMapping("/user/edit/{id}")
	public String editUsers(@PathVariable("id") Long id, Model model, @Valid @ModelAttribute("users") User user,
			BindingResult result) {

		if (result.hasErrors()) {
			System.out.println(result.getAllErrors());
			return "redirect:/user/edit/" + id;

		}
		userService.update(user);
		return "redirect:/";
	}

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
	}

	@RequestMapping("/editMe/{id}")
	public String editMe(@PathVariable("id") Long id, Model model, @ModelAttribute("user") User user) {
		model.addAttribute("user", userService.findById(id));
		model.addAttribute("packages", packageService.findAll());
		return "editMe";
	}

	@PostMapping("/editMe/{id}")
	public String editMe(@PathVariable("id") Long id, Model model, @Valid @ModelAttribute("user") User user,
			BindingResult result) {
		if (user.getPassword() == null) {
			model.addAttribute("error", "Enter your password to proceed!");
		}
		if (result.hasErrors()) {
			return "redirect:/editMe/" + id;

		}
		userService.update(user);
		return "redirect:/";
	}
}
