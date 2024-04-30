package com.udemy.springgraphql.datasource;

import net.datafaker.Faker;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataSourceConfiguration {

    @Bean
    Faker faker() {
        return new Faker();
    }
}
