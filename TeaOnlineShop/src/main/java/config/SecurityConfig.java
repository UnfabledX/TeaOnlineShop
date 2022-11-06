package config;

import org.springframework.context.annotation.Bean;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.FormLoginConfigurer;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;


@EnableWebSecurity
public class SecurityConfig {


    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/admin/**")
                .hasRole("ADMIN")
                /*
                .antMatchers("/**")
                .hasRole("USER") */
                .and()
                .formLogin()
                // redirect from standard login of spring to custom /loginPage (login.jsp presentation)
                .loginPage("/loginPage")
                .defaultSuccessUrl("/admin/showProducts", true)
                .permitAll()
                .and()
                .logout().logoutUrl("/admin/logout").logoutSuccessUrl("/loginPage");
        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        UserDetails user = User
                .withUsername("user")
                .passwordEncoder(s -> getPasswordEncoder().encode("password"))
                .roles("USER")
                .build();
        UserDetails admin = User
                .withUsername("admin")
                .passwordEncoder(s -> getPasswordEncoder().encode("password"))
                .roles("ADMIN", "USER")
                .build();
        return new InMemoryUserDetailsManager(user, admin);
    }

    @Bean
    public PasswordEncoder getPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

}
