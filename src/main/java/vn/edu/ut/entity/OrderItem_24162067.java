package vn.edu.ut.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

@Entity
@Table(name = "order_items")
public class OrderItem_24162067 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Order_24162067 order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bookid", nullable = false)
    private Book_24162067 book;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @Column(name = "price", precision = 12, scale = 2, nullable = false)
    private BigDecimal price;

    public OrderItem_24162067() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Order_24162067 getOrder() {
        return order;
    }

    public void setOrder(Order_24162067 order) {
        this.order = order;
    }

    public Book_24162067 getBook() {
        return book;
    }

    public void setBook(Book_24162067 book) {
        this.book = book;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getTotalPrice() {
        if (price != null && quantity != null) {
            return price.multiply(new BigDecimal(quantity));
        }
        return BigDecimal.ZERO;
    }
}
