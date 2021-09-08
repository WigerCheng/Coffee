package com.drink.coffee.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class GlobalCorsConfig {
    @Bean
    public CorsFilter corsFilter() {
        CorsConfiguration corsConfiguration=new CorsConfiguration();
        /*开放哪些ip，端口，域名的访问权限，*号代表所有开放域*/
        corsConfiguration.addAllowedOrigin("*");
        /*是否发送Cookie信息*/
        corsConfiguration.setAllowCredentials(true);
        /*开放哪些HTTP方法,允许跨域访问*/
        corsConfiguration.addAllowedMethod("GET");
        corsConfiguration.addAllowedMethod("POST");
        corsConfiguration.addAllowedMethod("PUT");
        corsConfiguration.addAllowedMethod("DELETE");
        /*允许HTTP请求中携带哪些Header信息*/
        corsConfiguration.addAllowedHeader("*");

        /*添加映射路径，“/**”表示对所有的路径实行全局跨域访问权限的设置*/
        UrlBasedCorsConfigurationSource configSource = new UrlBasedCorsConfigurationSource();
        configSource.registerCorsConfiguration("/**", corsConfiguration);

        return new CorsFilter(configSource);
    }
}
