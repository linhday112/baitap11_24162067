package vn.edu.ut.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "users")
public class User_24162067 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "email", length = 50, nullable = false, unique = true)
    private String email;

    @Column(name = "fullname", length = 50)
    private String fullname;

    @Column(name = "phone", length = 15)
    private String phone;

    @Column(name = "passwd", length = 64, nullable = false)
    private String passwd;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "signup_date")
    private Date signupDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "last_login")
    private Date lastLogin;

    @Column(name = "is_admin")
    private Boolean isAdmin;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Rating_24162067> ratings;

    public User_24162067() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public Date getSignupDate() {
        return signupDate;
    }

    public void setSignupDate(Date signupDate) {
        this.signupDate = signupDate;
    }

    public Date getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }

    public Boolean getIsAdmin() {
        return isAdmin != null ? isAdmin : false;
    }

    public void setIsAdmin(Boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public List<Rating_24162067> getRatings() {
        return ratings;
    }

    public void setRatings(List<Rating_24162067> ratings) {
        this.ratings = ratings;
    }
}
