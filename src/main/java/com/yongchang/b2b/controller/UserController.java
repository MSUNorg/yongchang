package com.yongchang.b2b.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.boot.context.embedded.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.google.common.collect.HashBasedTable;
import com.google.common.collect.Table;
import com.yongchang.b2b.cons.EnumCollections;
import com.yongchang.b2b.cons.EnumCollections.UserState;
import com.yongchang.b2b.cons.EnumCollections.UserType;
import com.yongchang.b2b.persistence.entity.User;
import com.yongchang.b2b.support.JsonResult;
import com.yongchang.b2b.support.ValidateCodeServlet;

/**
 * @author zxc Apr 27, 2016 3:51:36 PM
 */
@Controller
public class UserController extends BaseController {

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login() {
        if (request.getRemoteUser() != null) return new ModelAndView(new RedirectView("/profile", true, false));
        return new ModelAndView("user/login");
    }

    @RequestMapping(value = "/register/{userType}", method = RequestMethod.GET)
    public ModelAndView register(@RequestParam(value = "userType", defaultValue = "buyer") @PathVariable("userType") String userType) {
        if (request.getRemoteUser() != null) return new ModelAndView(new RedirectView("/profile", true, false));
        return new ModelAndView("user/register")//
        .addObject("userType", userType);
    }

    @RequestMapping(value = "/register/{userType}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult register(@RequestParam(value = "userType", defaultValue = "buyer") @PathVariable("userType") String userType,
                               String code, User user, HttpSession session) {
        if (user == null) return fail("参数错误");
        String passwd = StringUtils.trim(user.getPasswd());
        String email = StringUtils.trim(user.getEmail());
        if (StringUtils.isEmpty(email) || StringUtils.isEmpty(passwd)) return fail("参数错误");
        User _user = userService.getUserByEmail(email);
        if (_user != null) return fail("用户已存在");
        user.setType(EnumCollections.UserType.get(userType).getValue());
        if (StringUtils.isEmpty(code)) user.setState(UserState.NONE.getValue());
        if (!StringUtils.isEmpty(code)) {
            com.yongchang.b2b.persistence.entity.Code _code = userService.getCode(code, UserType.get(userType));
            if (_code == null) return fail("邀请码已过期");
            user.setState(UserState.NORMAL.getValue());
            user.setLevel(_code.getLevel());
        }
        user.setPasswd(bCryptPasswordEncoder.encode(passwd));
        userService.save(user);
        return ok("注册成功");
    }

    @RequestMapping(value = "/resetpwd", method = RequestMethod.GET)
    public String resetPasswoed() {
        return "user/resetpwd";
    }

    @RequestMapping(value = "/resetpwd", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult resetpwd(String email, HttpSession session) throws IOException {
        User user = userService.getUserByEmail(email);
        if (user == null) return fail("用户不存在");
        String code = "123456";
        Table<String, String, Long> table = HashBasedTable.create();
        table.put(user.getPhone(), code, System.currentTimeMillis());
        session.setAttribute(SESSION_RESET_PWD_CODE, table);
        return ok("重置成功");
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public ModelAndView profile() {
        User user = userService.getUserByEmail(request.getRemoteUser());
        return new ModelAndView("user/profile")//
        .addObject("user", user)//
        .addObject("user_type", user.getTypeStr());
    }

    @RequestMapping(value = "/profile", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult profileSave(User user) {
        User _user = user();
        if (!StringUtils.equals(_user.getEmail(), user.getEmail())) {
            if (userService.getUserByEmail(user.getEmail()) != null) return fail("邮箱已被注册");
        }
        _user.setName(user.getName());
        _user.setRealname(user.getRealname());
        _user.setPhone(user.getPhone());
        _user.setEmail(user.getEmail());
        userService.save(_user);
        return ok("成功");
    }

    @RequestMapping(value = "/avatar", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult avatar(String avatar) {
        User _user = user();
        _user.setAvatar(avatar);
        userService.save(_user);
        return ok("成功");
    }

    @RequestMapping(value = "/company", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult company(User user) {
        User _user = user();
        _user.setCompany(user.getCompany());
        _user.setProvince(user.getProvince());
        _user.setCity(user.getCity());
        _user.setCounty(user.getCounty());
        _user.setAddress(user.getAddress());
        _user.setQq(user.getQq());
        _user.setMobile(user.getMobile());
        _user.setAboutus(user.getAboutus());
        _user.setLogo(user.getLogo());
        userService.save(_user);
        return ok("成功");
    }

    @RequestMapping(value = "/passwd", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult passwd(String passwd, String newpasswd, String confirpasswd) {
        passwd = StringUtils.trim(passwd);
        newpasswd = StringUtils.trim(newpasswd);
        confirpasswd = StringUtils.trim(confirpasswd);
        if (StringUtils.isEmpty(passwd) || StringUtils.isEmpty(newpasswd) || StringUtils.isEmpty(confirpasswd)) return fail("密码错误");
        if (!StringUtils.equals(newpasswd, confirpasswd)) return fail("新密码错误");
        User user = user();
        if (!bCryptPasswordEncoder.matches(passwd, user.getPasswd())) return fail("旧密码错误");
        user.setPasswd(bCryptPasswordEncoder.encode(newpasswd));
        userService.save(user);
        return ok("成功");
    }

    @Bean
    public ServletRegistrationBean validateCodeServletRegistration() {
        return new ServletRegistrationBean(new ValidateCodeServlet(), "/verify/code");
    }
}
