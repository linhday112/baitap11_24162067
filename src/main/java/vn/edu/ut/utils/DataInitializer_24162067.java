package vn.edu.ut.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.ut.dao.IAuthorDao_24162067;
import vn.edu.ut.dao.IBookDao_24162067;
import vn.edu.ut.dao.IOrderDao_24162067;
import vn.edu.ut.dao.IRatingDao_24162067;
import vn.edu.ut.dao.IUserDao_24162067;
import vn.edu.ut.entity.Author_24162067;
import vn.edu.ut.entity.Book_24162067;
import vn.edu.ut.entity.Order_24162067;
import vn.edu.ut.entity.RatingId_24162067;
import vn.edu.ut.entity.Rating_24162067;
import vn.edu.ut.entity.User_24162067;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Component
public class DataInitializer_24162067 implements CommandLineRunner {

    @Autowired
    private IUserDao_24162067 userDao;

    @Autowired
    private IAuthorDao_24162067 authorDao;

    @Autowired
    private IBookDao_24162067 bookDao;

    @Autowired
    private IRatingDao_24162067 ratingDao;

    @Autowired
    private IOrderDao_24162067 orderDao;

    @Override
    @Transactional
    public void run(String... args) throws Exception {
        // Remove only the old generated fixtures; keep orders placed through checkout.
        for (Order_24162067 order : orderDao.findAll()) {
            if (order.getNote() != null
                    && order.getNote().matches("Đơn hàng thử nghiệm trạng thái: (Đơn hàng mới|Đã xác nhận|Chuẩn bị hàng|Vận chuyển|Giao hàng|Đã giao|Đơn hàng hủy|Đơn hàng hoàn)")
                    && order.getAddress() != null
                    && order.getAddress().matches("12[3-9] Đường Võ Văn Ngân, TP\\. Thủ Đức, TP\\.HCM|130 Đường Võ Văn Ngân, TP\\. Thủ Đức, TP\\.HCM")) {
                orderDao.delete(order.getId());
            }
        }

        if (userDao.findAll().isEmpty()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            // Sample Users
            User_24162067 admin = new User_24162067();
            admin.setEmail("admin@example.com");
            admin.setFullname("Nguyễn Đình Lĩnh (Admin)");
            admin.setPhone("0901234567");
            admin.setPasswd(PasswordUtils_24162067.hashPassword("admin123"));
            admin.setSignupDate(new Date());
            admin.setIsAdmin(true);
            userDao.insert(admin);

            User_24162067 user = new User_24162067();
            user.setEmail("user@example.com");
            user.setFullname("Nguyễn Đình Lĩnh");
            user.setPhone("0912345678");
            user.setPasswd(PasswordUtils_24162067.hashPassword("user123"));
            user.setSignupDate(new Date());
            user.setIsAdmin(false);
            userDao.insert(user);

            // Sample Authors
            Author_24162067 a1 = new Author_24162067();
            a1.setAuthorName("J.K. Rowling");
            a1.setDateOfBirth(sdf.parse("1965-07-31"));
            authorDao.insert(a1);

            Author_24162067 a2 = new Author_24162067();
            a2.setAuthorName("George R.R. Martin");
            a2.setDateOfBirth(sdf.parse("1948-09-20"));
            authorDao.insert(a2);

            Author_24162067 a3 = new Author_24162067();
            a3.setAuthorName("J.R.R. Tolkien");
            a3.setDateOfBirth(sdf.parse("1892-01-03"));
            authorDao.insert(a3);

            Author_24162067 a4 = new Author_24162067();
            a4.setAuthorName("Dan Brown");
            a4.setDateOfBirth(sdf.parse("1964-06-22"));
            authorDao.insert(a4);

            Author_24162067 a5 = new Author_24162067();
            a5.setAuthorName("Nam Cao");
            a5.setDateOfBirth(sdf.parse("1915-10-29"));
            authorDao.insert(a5);

            Author_24162067 a6 = new Author_24162067();
            a6.setAuthorName("Tô Hoài");
            a6.setDateOfBirth(sdf.parse("1920-09-27"));
            authorDao.insert(a6);

            // Sample Books with accurate images and VNĐ pricing
            Book_24162067 b1 = createBook(1001, "Harry Potter and the Sorcerer Stone", "Bloomsbury", new BigDecimal("199000"), "Hành trình kì diệu của cậu bé phù thủy Harry Potter tại trường Hogwarts.", sdf.parse("1997-06-26"), "https://upload.wikimedia.org/wikipedia/en/6/6b/Harry_Potter_and_the_Philosopher%27s_Stone_Book_Cover.jpg", 50, List.of(a1));
            Book_24162067 b2 = createBook(1002, "A Game of Thrones", "Bantam Spectra", new BigDecimal("250000"), "Cuộc chiến vương quyền khốc liệt tại vùng đất Westeros.", sdf.parse("1996-08-01"), "https://covers.openlibrary.org/b/isbn/9780553103540-L.jpg", 35, List.of(a2));
            Book_24162067 b3 = createBook(1003, "The Lord of the Rings", "Allen & Unwin", new BigDecimal("300000"), "Tiểu thuyết sử thi huyền thoại về chiếc nhẫn quyền lực của J.R.R. Tolkien.", sdf.parse("1954-07-29"), "https://upload.wikimedia.org/wikipedia/en/e/e9/First_Single_Volume_Edition_of_The_Lord_of_the_Rings.gif", 40, List.of(a3));
            Book_24162067 b4 = createBook(1004, "The Da Vinci Code", "Doubleday", new BigDecimal("150000"), "Tác phẩm trinh thám li kỳ giải mã các bí ẩn nghìn năm.", sdf.parse("2003-03-18"), "https://upload.wikimedia.org/wikipedia/en/6/6b/DaVinciCode.jpg", 60, List.of(a4));
            Book_24162067 b5 = createBook(1005, "Chí Phèo", "NXB Văn Học", new BigDecimal("85000"), "Tác phẩm văn học kinh điển phản ánh xã hội Việt Nam thời kì phong kiến.", sdf.parse("1941-02-15"), "https://upload.wikimedia.org/wikipedia/vi/9/96/B%C3%ACa_s%C3%A1ch_Ch%C3%AD_Ph%C3%A8o.jpg", 100, List.of(a5));
            Book_24162067 b6 = createBook(1006, "Dế Mèn Phiêu Lưu Ký", "NXB Kim Đồng", new BigDecimal("90000"), "Truyện thiếu nhi kinh điển về những chuyến hành trình phiêu lưu của Dế Mèn.", sdf.parse("1941-09-10"), "https://upload.wikimedia.org/wikipedia/vi/9/9c/Demenphieuluuky.jpg", 80, List.of(a6));
            Book_24162067 b7 = createBook(1007, "Lão Hạc", "NXB Văn Học", new BigDecimal("75000"), "Truyện ngắn đầy xúc động về tình cha con và người nông dân nghèo.", sdf.parse("1943-05-12"), "https://upload.wikimedia.org/wikipedia/vi/4/4b/L%C3%A3o_H%E1%BA%A1c.jpg", 45, List.of(a5));
            Book_24162067 b8 = createBook(1008, "Angels & Demons", "Pocket Books", new BigDecimal("145000"), "Robert Langdon điều tra vụ án bí ẩn liên quan đến hội Illuminati.", sdf.parse("2000-05-01"), "https://covers.openlibrary.org/b/isbn/9780743486224-L.jpg", 30, List.of(a4));

            bookDao.insert(b1);
            bookDao.insert(b2);
            bookDao.insert(b3);
            bookDao.insert(b4);
            bookDao.insert(b5);
            bookDao.insert(b6);
            bookDao.insert(b7);
            bookDao.insert(b8);

            // Sample Ratings
            Rating_24162067 r1 = new Rating_24162067();
            r1.setId(new RatingId_24162067(user.getId(), b1.getBookid()));
            r1.setUser(user);
            r1.setBook(b1);
            r1.setRating(5);
            r1.setReviewText("Sách rất hay và kịch tính!");
            ratingDao.insertOrUpdate(r1);

            Rating_24162067 r2 = new Rating_24162067();
            r2.setId(new RatingId_24162067(user.getId(), b2.getBookid()));
            r2.setUser(user);
            r2.setBook(b2);
            r2.setRating(4);
            r2.setReviewText("Cốt truyện lôi cuốn nhưng hơi dài.");
            ratingDao.insertOrUpdate(r2);


        }
    }

    private Book_24162067 createBook(Integer isbn, String title, String publisher, BigDecimal price, String desc, Date pDate, String img, Integer qty, List<Author_24162067> authors) {
        Book_24162067 book = new Book_24162067();
        book.setIsbn(isbn);
        book.setTitle(title);
        book.setPublisher(publisher);
        book.setPrice(price);
        book.setDescription(desc);
        book.setPublishDate(pDate);
        book.setCoverImage(img);
        book.setQuantity(qty);
        book.setAuthors(authors);
        return book;
    }
}
