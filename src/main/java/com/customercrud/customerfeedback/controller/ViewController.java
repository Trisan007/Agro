package com.customercrud.customerfeedback.controller;

import com.customercrud.customerfeedback.base.UserType;
import com.customercrud.customerfeedback.entity.User;
import com.customercrud.customerfeedback.services.feedback.FeedbackService;
import com.customercrud.customerfeedback.services.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * View  Control
 * Main api '/'
 * only view returning related api*/
@Controller
public class ViewController {
    @Autowired
    private UserService userService;

    @Autowired
    private FeedbackService feedbackService;
    /**
     * default api
     * index page*/
    @RequestMapping(method = RequestMethod.GET)
    public String index(ModelMap model , HttpServletResponse response) {
        // clear cookie data
        Cookie name = new Cookie("username",null);
        Cookie userId = new Cookie("userId",null);
        Cookie userType = new Cookie("userType",null);
        response.addCookie(name);
        response.addCookie(userId);
        response.addCookie(userType);
        return "index";
    }

    /**
     * summary page returning api
     * @param username -name of user
     * @param password -password of user*/
    @PostMapping("/login")
    public String login(@RequestParam String username , @RequestParam String password , ModelMap modelMap, HttpServletResponse response, HttpServletRequest request) {
        // todo find user type and return view according to it
        User user = userService.findByUserName(username);
        if (user == null) {
            modelMap.put("error" , "No user found !!");
            return "index";
        }
        if(!user.getPasword().equals(password)){
            modelMap.put("error" , "Incorrect Password!!");
            return "index";
        }
        modelMap.put("user" , user);
        Cookie name = new Cookie("username",user.getUserName());
        Cookie userId = new Cookie("userId",user.getId().toString());
        Cookie userType = new Cookie("userType",user.getUserType().toString());
        response.addCookie(name);
        response.addCookie(userId);
        response.addCookie(userType);
        return "dashboard";
    }

    /**
     * view page feedback*/
    @GetMapping("/feed-back")
    public String loadFeedback(){
        return "feedback";
    }

    /**
     * rest api market price data page*/
    @GetMapping("/market-price")
    public String loadMarketPriceData(){
        return "market-price";
    }

    @GetMapping("/feedback-list")
    public String loadFeedbackList(ModelMap modelMap){
        List<User> users = userService.findUserByUserType(UserType.USER); // only client user can give feedback
        modelMap.put("users" , users);
        return "feedback-list";
    }
    /**
     * view all feedback*/
    @GetMapping("/feed-back/{id}")
    public String loadFeedbackIndividual(@PathVariable String id, ModelMap modelMap){
        User user = userService.findById(Integer.valueOf(id));
        modelMap.put("user" , user);
        return "individual-feedback";
    }
    @GetMapping("/summary")
    public String loadFeedbackList(){
        return "summary";
    }

    /**
     * index - logout*/
    @GetMapping("/logout")
    public String logout(HttpServletResponse response) {
        // clear cookie data
        Cookie name = new Cookie("username",null);
        Cookie userId = new Cookie("userId",null);
        Cookie userType = new Cookie("userType",null);
        response.addCookie(name);
        response.addCookie(userId);
        response.addCookie(userType);
        return "index";
    }


    /**
     * home page*/
    @GetMapping("/home")
    public String home(HttpServletRequest httpServletRequest , ModelMap modelMap) {
        Map<String, Cookie> cookieMap = new HashMap<>();
        for (Cookie cookie : httpServletRequest.getCookies()) {
            if (!ObjectUtils.isEmpty(cookie.getValue())) {
                cookieMap.put(cookie.getName(), cookie);
            }
        }
        if (!cookieMap.containsKey("userId")) { // check if the user has been logged in and cookie is being stored
            return "index";
        }
        return "dashboard";
    }
}
