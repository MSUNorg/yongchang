/*
 * 
 */
package com.yongchang.b2b.support;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.yongchang.b2b.cons.Definition;
import com.yongchang.b2b.cons.EnumCollections;
import com.yongchang.b2b.persistence.entity.User;
import com.yongchang.b2b.persistence.service.UserService;

/**
 * @author zxc Apr 28, 2016 10:30:24 AM
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class ApplicationSecurity extends WebSecurityConfigurerAdapter implements Definition {

    @Value("${public.url}")
    private String[] urls;

    @Bean
    protected UsernamePasswordAuthenticationExtendFilter captchaFilter() throws Exception {
        UsernamePasswordAuthenticationExtendFilter filter = new UsernamePasswordAuthenticationExtendFilter();
        filter.setAuthenticationManager(authenticationManager());
        filter.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher("/login", "POST"));
        filter.setAuthenticationSuccessHandler(new SimpleUrlAuthenticationSuccessHandler("/login"));
        filter.setAuthenticationFailureHandler(new SimpleUrlAuthenticationFailureHandler("/login?error"));
        filter.setUsernameParameter("username");
        filter.setPasswordParameter("password");
        return filter;
    }

    @Bean
    public UserDetailsService userDetailsServiceImpl() {
        return new UserDetailsService() {

            @Autowired
            UserService userService;

            @Override
            public UserDetails loadUserByUsername(String name) throws UsernameNotFoundException {
                User user = userService.getUserByEmail(name);
                if (user == null) throw new UsernameNotFoundException("该用户不存在！");
                Collection<GrantedAuthority> auths = new ArrayList<GrantedAuthority>();
                auths.add(new SimpleGrantedAuthority("ROLE_USER"));

                if (user.getType() != null) {
                    auths.add(new SimpleGrantedAuthority(EnumCollections.UserType.get(user.getType()).name()));
                }

                ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
                HttpSession session = requestAttributes.getRequest().getSession(true);
                session.setAttribute(CUR_USER, user);
                return new org.springframework.security.core.userdetails.User(name, user.getPasswd(), auths);
            }
        };
    }

    @Bean
    public AccessDeniedHandler accessDeniedHandlerImpl() {
        return new AccessDeniedHandler() {

            public void handle(HttpServletRequest req, HttpServletResponse res, AccessDeniedException ex)
                                                                                                         throws IOException,
                                                                                                         ServletException {
                boolean isAjax = isAjaxRequest(req);
                if (isAjax) {
                    JsonResult result = JsonResult.fail(exceptionDetail(ex));
                    res.setHeader("Content-Type", "application/json;charset=UTF-8");
                    res.getWriter().print(result.toString());
                } else if (!res.isCommitted()) {
                    req.setAttribute(WebAttributes.ACCESS_DENIED_403, ex);
                    res.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    RequestDispatcher dispatcher = req.getRequestDispatcher("/401.html");
                    dispatcher.forward(req, res);
                }
            }
        };
    }

    public static boolean isAjaxRequest(HttpServletRequest request) {
        String header = request.getHeader("X-Requested-With");
        return header != null && "XMLHttpRequest".equalsIgnoreCase(header);
    }

    public String exceptionDetail(Throwable ex) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        PrintStream pout = new PrintStream(out);
        ex.printStackTrace(pout);
        String ret = out.toString();
        pout.close();
        try {
            out.close();
        } catch (Exception e) {
            _.error("exceptionDetail error!", e);
        }
        return ret;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()//
        .addFilterBefore(captchaFilter(), UsernamePasswordAuthenticationFilter.class)//
        .authorizeRequests()//
        .antMatchers(urls).permitAll()//
        .anyRequest().authenticated()//
        .and().formLogin().defaultSuccessUrl("/profile").loginPage("/login").failureUrl("/login?error").permitAll()//
        .and().logout().deleteCookies("JSESSIONID").permitAll()//
        .and().rememberMe().key("23a63e5e-8cd7-452c-856e-477b08f1223e").tokenValiditySeconds(2592000)//
        .and().exceptionHandling().accessDeniedHandler(accessDeniedHandlerImpl())//
        .and().sessionManagement().maximumSessions(1).expiredUrl("/expired");
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsServiceImpl())//
        .passwordEncoder(passwordEncoder());
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(4);
    }
}
