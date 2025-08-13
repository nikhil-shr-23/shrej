package com.steel.backend.config;

import com.steel.backend.model.*;
import com.steel.backend.repository.*;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.math.BigDecimal;
import java.util.Set;

@Configuration
public class DataSeeder {

    @Bean
    CommandLineRunner seedData(UserRepository userRepository,
                               SupplierRepository supplierRepository,
                               ClientRepository clientRepository,
                               ProductRepository productRepository,
                               PasswordEncoder encoder) {
        return args -> {
            if (userRepository.count() == 0) {
                userRepository.save(User.builder()
                        .username("admin")
                        .password(encoder.encode("admin123"))
                        .roles(Set.of(RoleType.ADMIN, RoleType.MANAGER))
                        .build());
                userRepository.save(User.builder()
                        .username("manager")
                        .password(encoder.encode("manager123"))
                        .roles(Set.of(RoleType.MANAGER))
                        .build());
                userRepository.save(User.builder()
                        .username("staff")
                        .password(encoder.encode("staff123"))
                        .roles(Set.of(RoleType.STAFF))
                        .build());
            }

            if (supplierRepository.count() == 0) {
                Supplier sup1 = supplierRepository.save(Supplier.builder()
                        .name("Global Steel Supplies")
                        .contactInfo("contact@globalsteel.com")
                        .suppliedProducts(Set.of("Plates", "Bowls"))
                        .build());

                Supplier sup2 = supplierRepository.save(Supplier.builder()
                        .name("Premium Utensils Inc.")
                        .contactInfo("info@premiumutensils.com")
                        .suppliedProducts(Set.of("Spoons", "Forks", "Knives"))
                        .build());

                productRepository.save(Product.builder()
                        .name("Stainless Steel Plate")
                        .category("Plates")
                        .description("Durable SS plate")
                        .price(new BigDecimal("2.50"))
                        .quantityInStock(500)
                        .supplier(sup1)
                        .build());

                productRepository.save(Product.builder()
                        .name("Cutlery Set")
                        .category("Cutlery")
                        .description("Knife, fork, spoon set")
                        .price(new BigDecimal("5.00"))
                        .quantityInStock(300)
                        .supplier(sup2)
                        .build());
            }

            if (clientRepository.count() == 0) {
                clientRepository.save(Client.builder()
                        .name("Ocean Imports")
                        .contactInfo("sales@oceanimports.com")
                        .country("India")
                        .businessType("Importer")
                        .build());
                clientRepository.save(Client.builder()
                        .name("Euro Trade GmbH")
                        .contactInfo("contact@eurotrade.de")
                        .country("Germany")
                        .businessType("Distributor")
                        .build());
            }
        };
    }
}







