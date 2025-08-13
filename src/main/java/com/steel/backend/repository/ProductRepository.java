package com.steel.backend.repository;

import com.steel.backend.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    java.util.List<Product> findByQuantityInStockLessThanEqual(Integer threshold);
}


