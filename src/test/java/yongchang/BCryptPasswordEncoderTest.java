/*
 * Copyright 2015-2020 unifox.com.cn All right reserved.
 */
package yongchang;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * @author zxc Aug 31, 2016 10:11:37 AM
 */
public class BCryptPasswordEncoderTest {

    static BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(4);

    public static void main(String[] args) {
        System.out.println(encoder.encode("jiayin"));
    }
}
