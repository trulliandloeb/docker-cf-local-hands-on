package com.sap.bulletinboard.ads.config;

import static org.springframework.http.HttpMethod.*;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;

import com.sap.xs2.security.commons.SAPOfflineTokenServicesCloud;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Configuration
@EnableWebSecurity
@EnableResourceServer
public class WebSecurityConfig extends ResourceServerConfigurerAdapter {
    
    private static final String DISPLAY_SCOPE_LOCAL = "Display";
    private static final String UPDATE_SCOPE_LOCAL = "Update";
    public static final String REGEX_TENANT_INDEX = "(!t\\d+)?.";
    private static final String XSAPPNAME = "bulletinboard-i333244";
    public static final String DISPLAY_SCOPE = XSAPPNAME + "." + DISPLAY_SCOPE_LOCAL;
    public static final String UPDATE_SCOPE = XSAPPNAME + "." + UPDATE_SCOPE_LOCAL;
    
    private static final Logger logger = LoggerFactory.getLogger(WebSecurityConfig.class);

    // configure Spring Security, demand authentication and specific scopes
    @Override
    public void configure(HttpSecurity http) throws Exception {
        // http://docs.spring.io/spring-security/oauth/apidocs/org/springframework/security/oauth2/provider/expression/OAuth2SecurityExpressionMethods.html
        String hasScopeUpdate = "#oauth2.hasScopeMatching('" + XSAPPNAME + REGEX_TENANT_INDEX + UPDATE_SCOPE_LOCAL
                + "')";
        String hasScopeDisplay = "#oauth2.hasScopeMatching('" + XSAPPNAME + REGEX_TENANT_INDEX + DISPLAY_SCOPE_LOCAL
                + "')";

        logger.warn("hasScopeUpdate: {}", hasScopeUpdate);
        logger.warn("hasScopeDisplay: {}", hasScopeDisplay);
        
        // @formatter:off
        http
            .sessionManagement()
                // session is created by approuter
                .sessionCreationPolicy(SessionCreationPolicy.NEVER)
                .and()
            // demand specific scopes depending on intended request
            .authorizeRequests()
                // enable OAuth2 checks
                .antMatchers(GET, "/health", "/").permitAll() //used as health check on CF: must be accessible by "anybody"
                .antMatchers(GET, "/env**", "/").permitAll()
                .antMatchers(POST, "/api/v1/ads/**").access(hasScopeUpdate)
                .antMatchers(PUT, "/api/v1/ads/**").access(hasScopeUpdate)
                .antMatchers(DELETE, "/api/v1/ads/**").access(hasScopeUpdate)
                .antMatchers(GET, "/api/v1/ads/**").access(hasScopeDisplay)
                .anyRequest().denyAll(); // deny anything not configured above
        // @formatter:on
    }
    
    // configure offline verification which checks if any provided JWT was properly signed
    @Bean
    protected SAPOfflineTokenServicesCloud offlineTokenServices() {
        return new SAPOfflineTokenServicesCloud();
    }
}