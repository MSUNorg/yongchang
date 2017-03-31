/*
 * 
 */
package com.yongchang.b2b.support;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * @author zxc Apr 27, 2016 9:07:22 PM
 */
public class UsernamePasswordAuthenticationExtendFilter extends UsernamePasswordAuthenticationFilter {

    private String  validateCodeParameter = "code";
    private boolean openValidateCode      = true;

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
                                                                                                         throws AuthenticationException {
        if (!"POST".equals(request.getMethod())) throw new BadCredentialsException("不支持非POST方式的请求!");
        if (isOpenValidateCode()) checkValidateCode(request);
        String username = obtainUsername(request);
        String password = obtainPassword(request);
        UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(username, password);
        setDetails(request, authRequest);
        return this.getAuthenticationManager().authenticate(authRequest);
    }

    public void checkValidateCode(HttpServletRequest request) {
        String validateCode = obtainValidateCodeParameter(request);
        if (null == validateCode) throw new BadCredentialsException("验证码超时,请重新获取!");
        boolean b = ValidateCodeServlet.validate(request, validateCode);
        if (!b) throw new BadCredentialsException("验证码不正确,请重新输入!");
    }

    public String obtainValidateCodeParameter(HttpServletRequest request) {
        Object obj = request.getParameter(getValidateCodeParameter());
        return null == obj ? "" : obj.toString().trim();
    }

    @Override
    protected String obtainUsername(HttpServletRequest request) {
        Object obj = request.getParameter(getUsernameParameter());
        return null == obj ? "" : obj.toString().trim();
    }

    @Override
    protected String obtainPassword(HttpServletRequest request) {
        Object obj = request.getParameter(getPasswordParameter());
        return null == obj ? "" : obj.toString().trim();
    }

    public String getValidateCodeParameter() {
        return validateCodeParameter;
    }

    public void setValidateCodeParameter(String validateCodeParameter) {
        this.validateCodeParameter = validateCodeParameter;
    }

    public boolean isOpenValidateCode() {
        return openValidateCode;
    }

    public void setOpenValidateCode(boolean openValidateCode) {
        this.openValidateCode = openValidateCode;
    }
}
