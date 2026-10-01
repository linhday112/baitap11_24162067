package vn.edu.ut.model;

import vn.edu.ut.entity.Book_24162067;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart_24162067 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Map<Integer, CartItem_24162067> items = new LinkedHashMap<>();

    public Collection<CartItem_24162067> getItems() {
        return items.values();
    }

    public Map<Integer, CartItem_24162067> getItemMap() {
        return items;
    }

    /**
     * Adds item to cart with stock validation.
     * Throws IllegalArgumentException if quantity limit is exceeded.
     */
    public void addItem(Book_24162067 book, int qty) {
        if (book == null || book.getBookid() == null) {
            throw new IllegalArgumentException("Sản phẩm không hợp lệ.");
        }
        int maxStock = book.getQuantity() != null ? book.getQuantity() : 0;
        if (maxStock <= 0) {
            throw new IllegalArgumentException("Sản phẩm '" + book.getTitle() + "' hiện đã hết hàng.");
        }

        int currentQty = 0;
        if (items.containsKey(book.getBookid())) {
            currentQty = items.get(book.getBookid()).getQuantity();
        }

        int targetQty = currentQty + qty;
        if (targetQty > maxStock) {
            throw new IllegalArgumentException("Không thể thêm. Số lượng trong giỏ hàng (" + targetQty 
                    + ") vượt quá số lượng tồn kho hiện có (" + maxStock + ").");
        }

        if (targetQty <= 0) {
            items.remove(book.getBookid());
        } else {
            items.put(book.getBookid(), new CartItem_24162067(book, targetQty));
        }
    }

    /**
     * Updates item quantity in cart with stock validation.
     */
    public void updateItem(int bookId, int newQty) {
        if (!items.containsKey(bookId)) {
            return;
        }
        CartItem_24162067 item = items.get(bookId);
        int maxStock = item.getBook().getQuantity() != null ? item.getBook().getQuantity() : 0;

        if (newQty <= 0) {
            items.remove(bookId);
            return;
        }

        if (newQty > maxStock) {
            throw new IllegalArgumentException("Số lượng cho sản phẩm '" + item.getBook().getTitle() 
                    + "' không được vượt quá số lượng tồn kho (tối đa " + maxStock + " sản phẩm).");
        }

        item.setQuantity(newQty);
    }

    public void removeItem(int bookId) {
        items.remove(bookId);
    }

    public void clear() {
        items.clear();
    }

    public BigDecimal getTotalAmount() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem_24162067 item : items.values()) {
            total = total.add(item.getTotalPrice());
        }
        return total;
    }

    public int getTotalItems() {
        int count = 0;
        for (CartItem_24162067 item : items.values()) {
            count += item.getQuantity();
        }
        return count;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public boolean getEmpty() {
        return items.isEmpty();
    }
}
