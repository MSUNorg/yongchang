/*
 * 
 */
package com.yongchang.b2b.support;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * @author zxc Feb 22, 2016 8:36:05 PM
 */
@EnableScheduling
@EnableAutoConfiguration
@ComponentScan("com.yongchang")
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebAppConfig extends WebMvcConfigurerAdapter {

    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(WebAppConfig.class);
    }
}
