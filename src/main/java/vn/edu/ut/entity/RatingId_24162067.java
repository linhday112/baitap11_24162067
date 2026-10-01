package vn.edu.ut.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class RatingId_24162067 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Column(name = "userid")
    private Integer userid;

    @Column(name = "bookid")
    private Integer bookid;

    public RatingId_24162067() {
    }

    public RatingId_24162067(Integer userid, Integer bookid) {
        this.userid = userid;
        this.bookid = bookid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getBookid() {
        return bookid;
    }

    public void setBookid(Integer bookid) {
        this.bookid = bookid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RatingId_24162067 ratingId = (RatingId_24162067) o;
        return Objects.equals(userid, ratingId.userid) && Objects.equals(bookid, ratingId.bookid);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userid, bookid);
    }
}
