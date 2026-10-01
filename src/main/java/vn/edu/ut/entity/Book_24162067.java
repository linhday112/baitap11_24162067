package vn.edu.ut.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "books")
public class Book_24162067 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "bookid")
    private Integer bookid;

    @Column(name = "isbn")
    private Integer isbn;

    @Column(name = "title", length = 200)
    private String title;

    @Column(name = "publisher", length = 100)
    private String publisher;

    @Column(name = "price", precision = 12, scale = 2)
    private BigDecimal price;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Temporal(TemporalType.DATE)
    @Column(name = "publish_date")
    private Date publishDate;

    @Column(name = "cover_image", length = 500)
    private String coverImage;

    @Column(name = "quantity")
    private Integer quantity;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "book_author",
        joinColumns = @JoinColumn(name = "bookid"),
        inverseJoinColumns = @JoinColumn(name = "author_id")
    )
    private List<Author_24162067> authors;

    @OneToMany(mappedBy = "book", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Rating_24162067> ratings;

    public Book_24162067() {
    }

    public Integer getBookid() {
        return bookid;
    }

    public void setBookid(Integer bookid) {
        this.bookid = bookid;
    }

    public Integer getIsbn() {
        return isbn;
    }

    public void setIsbn(Integer isbn) {
        this.isbn = isbn;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public List<Author_24162067> getAuthors() {
        return authors;
    }

    public void setAuthors(List<Author_24162067> authors) {
        this.authors = authors;
    }

    public List<Rating_24162067> getRatings() {
        return ratings;
    }

    public void setRatings(List<Rating_24162067> ratings) {
        this.ratings = ratings;
    }
}
