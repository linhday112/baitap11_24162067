package vn.edu.ut.model;

import vn.edu.ut.entity.Book_24162067;

import java.io.Serializable;
import java.math.BigDecimal;

public class CartItem_24162067 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Book_24162067 book;
    private int quantity;

    public CartItem_24162067() {
    }

    public CartItem_24162067(Book_24162067 book, int quantity) {
        this.book = book;
        this.quantity = quantity;
    }

    public Book_24162067 getBook() {
        return book;
    }

    public void setBook(Book_24162067 book) {
        this.book = book;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getTotalPrice() {
        if (book != null && book.getPrice() != null) {
            return book.getPrice().multiply(new BigDecimal(quantity));
        }
        return BigDecimal.ZERO;
    }
}
