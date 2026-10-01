package vn.edu.ut.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "rating")
public class Rating_24162067 implements Serializable {
    private static final long serialVersionUID = 1L;

    @EmbeddedId
    private RatingId_24162067 id;

    @ManyToOne(fetch = FetchType.EAGER)
    @MapsId("userid")
    @JoinColumn(name = "userid")
    private User_24162067 user;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("bookid")
    @JoinColumn(name = "bookid")
    private Book_24162067 book;

    @Column(name = "rating")
    private Integer rating;

    @Column(name = "review_text", columnDefinition = "TEXT")
    private String reviewText;

    public Rating_24162067() {
    }

    public RatingId_24162067 getId() {
        return id;
    }

    public void setId(RatingId_24162067 id) {
        this.id = id;
    }

    public User_24162067 getUser() {
        return user;
    }

    public void setUser(User_24162067 user) {
        this.user = user;
    }

    public Book_24162067 getBook() {
        return book;
    }

    public void setBook(Book_24162067 book) {
        this.book = book;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }
}
