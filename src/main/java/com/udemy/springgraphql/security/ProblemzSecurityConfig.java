package com.udemy.springgraphql.security;

import com.udemy.springgraphql.datasource.problemz.repository.UserzRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class ProblemzSecurityConfig {

  private final UserzRepository userzRepository;

  public ProblemzSecurityConfig(final UserzRepository userzRepository) {
    this.userzRepository = userzRepository;
  }

  @Bean
  public SecurityFilterChain filterChain(final HttpSecurity http) throws Exception {
    http.authorizeHttpRequests((requests) -> requests
            .requestMatchers("/graphql").permitAll())
        .csrf(AbstractHttpConfigurer::disable)
        .addFilterBefore(new ProblemzSecurityFilter(), BasicAuthenticationFilter.class);
    return http.build();
  }

}