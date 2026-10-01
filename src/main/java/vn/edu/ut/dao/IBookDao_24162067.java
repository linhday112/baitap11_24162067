package vn.edu.ut.dao;

import vn.edu.ut.entity.Book_24162067;
import java.util.List;

public interface IBookDao_24162067 {
    Book_24162067 findById(Integer bookid);
    List<Book_24162067> findAll(int page, int pageSize);
    List<Book_24162067> findAll();
    long countAll();
    void insert(Book_24162067 book);
    void update(Book_24162067 book);
    void delete(Integer bookid);
}
