package com.steel.backend.web;

import com.steel.backend.model.*;
import com.steel.backend.repository.*;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/orders")
public class OrderController {
    private final OrderRepository orderRepository;
    private final ClientRepository clientRepository;
    private final ProductRepository productRepository;
    private final OrderItemRepository orderItemRepository;

    public OrderController(OrderRepository orderRepository,
                           ClientRepository clientRepository,
                           ProductRepository productRepository,
                           OrderItemRepository orderItemRepository) {
        this.orderRepository = orderRepository;
        this.clientRepository = clientRepository;
        this.productRepository = productRepository;
        this.orderItemRepository = orderItemRepository;
    }

    @GetMapping
    public List<Order> list() { return orderRepository.findAll(); }

    @GetMapping("/{id}")
    public ResponseEntity<Order> get(@PathVariable Long id) {
        return orderRepository.findById(id).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN') or hasRole('MANAGER') or hasRole('STAFF')")
    @Transactional
    public ResponseEntity<Order> create(@RequestParam Long clientId,
                                        @RequestBody @Valid List<ItemPayload> items) {
        Client client = clientRepository.findById(clientId).orElseThrow();
        Order order = new Order();
        order.setClient(client);
        order.setStatus(OrderStatus.PENDING);
        order.setTotalPrice(BigDecimal.ZERO);
        Order saved = orderRepository.save(order);

        BigDecimal total = BigDecimal.ZERO;
        for (ItemPayload payload : items) {
            Product product = productRepository.findById(payload.productId()).orElseThrow();
            if (product.getQuantityInStock() < payload.quantity()) {
                throw new IllegalArgumentException("Insufficient stock for product " + product.getId());
            }
            product.setQuantityInStock(product.getQuantityInStock() - payload.quantity());
            productRepository.save(product);

            OrderItem item = new OrderItem();
            item.setOrder(saved);
            item.setProduct(product);
            item.setQuantity(payload.quantity());
            item.setPrice(product.getPrice().multiply(BigDecimal.valueOf(payload.quantity())));
            orderItemRepository.save(item);
            saved.getItems().add(item);
            total = total.add(item.getPrice());
        }

        saved.setTotalPrice(total);
        orderRepository.save(saved);
        return ResponseEntity.created(URI.create("/api/orders/" + saved.getId())).body(saved);
    }

    @PutMapping("/{id}/status")
    @PreAuthorize("hasRole('ADMIN') or hasRole('MANAGER')")
    public ResponseEntity<Order> updateStatus(@PathVariable Long id, @RequestParam OrderStatus status) {
        return orderRepository.findById(id)
                .map(order -> { order.setStatus(status); return ResponseEntity.ok(orderRepository.save(order)); })
                .orElse(ResponseEntity.notFound().build());
    }

    public record ItemPayload(Long productId, int quantity) {}
}


