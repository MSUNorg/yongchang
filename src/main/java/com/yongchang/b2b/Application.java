/*
 * 
 */
package com.yongchang.b2b;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.context.embedded.ErrorPage;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;

import com.yongchang.b2b.support.WebAppConfig;

/**
 * @author zxc Aug 28, 2015 11:46:11 AM
 */
@SpringBootApplication
public class Application extends SpringBootServletInitializer {

    public static void main(String[] args) throws Exception {
        new SpringApplication(WebAppConfig.class).run(args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
    }

    @Bean
    public EmbeddedServletContainerCustomizer containerCustomizer() {

        return new EmbeddedServletContainerCustomizer() {

            @Override
            public void customize(ConfigurableEmbeddedServletContainer container) {

                ErrorPage page401 = new ErrorPage(HttpStatus.UNAUTHORIZED, "/401.html");
                ErrorPage page404 = new ErrorPage(HttpStatus.NOT_FOUND, "/404.html");
                ErrorPage page500 = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/500.html");
                container.addErrorPages(page401, page404, page500);
            }
        };
    }
}
