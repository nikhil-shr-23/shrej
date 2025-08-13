package com.steel.backend.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {
    @Bean
    public OpenAPI openAPI() {
        final String bearerKey = "bearerAuth";
        return new OpenAPI()
                .info(new Info()
                        .title("Steel Utensils Import/Export API")
                        .version("v1")
                        .description("Backend API for managing products, inventory, orders, clients, and suppliers."))
                .components(new Components()
                        .addSecuritySchemes(bearerKey, new SecurityScheme()
                                .type(SecurityScheme.Type.HTTP)
                                .scheme("bearer")
                                .bearerFormat("JWT")))
                .addSecurityItem(new SecurityRequirement().addList(bearerKey));
    }
}


