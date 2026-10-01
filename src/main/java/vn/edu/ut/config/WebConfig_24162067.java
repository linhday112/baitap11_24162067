package vn.edu.ut.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import vn.edu.ut.filter.AuthFilter_24162067;
import vn.edu.ut.filter.SiteMeshFilter_24162067;

@Configuration
public class WebConfig_24162067 {

    @Bean
    public FilterRegistrationBean<SiteMeshFilter_24162067> siteMeshFilter() {
        FilterRegistrationBean<SiteMeshFilter_24162067> filterRegistrationBean = new FilterRegistrationBean<>();
        filterRegistrationBean.setFilter(new SiteMeshFilter_24162067());
        filterRegistrationBean.addUrlPatterns("/*");
        filterRegistrationBean.setOrder(1);
        return filterRegistrationBean;
    }

    @Bean
    public FilterRegistrationBean<AuthFilter_24162067> authFilter() {
        FilterRegistrationBean<AuthFilter_24162067> filterRegistrationBean = new FilterRegistrationBean<>();
        filterRegistrationBean.setFilter(new AuthFilter_24162067());
        filterRegistrationBean.addUrlPatterns("/admin/*");
        filterRegistrationBean.setOrder(2);
        return filterRegistrationBean;
    }
}
