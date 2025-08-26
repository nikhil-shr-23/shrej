package com.steel.backend.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.Set;

@Entity
@Table(name = "suppliers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Supplier {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    private String contactInfo;

    @ElementCollection
    @CollectionTable(name = "supplier_products", joinColumns = @JoinColumn(name = "supplier_id"))
    @Column(name = "product_name")
    private Set<String> suppliedProducts;
}











