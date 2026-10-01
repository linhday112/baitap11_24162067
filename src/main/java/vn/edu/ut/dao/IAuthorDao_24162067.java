package vn.edu.ut.dao;

import vn.edu.ut.entity.Author_24162067;
import java.util.List;

public interface IAuthorDao_24162067 {
    Author_24162067 findById(Integer authorId);
    List<Author_24162067> findAll(int page, int pageSize);
    List<Author_24162067> findAll();
    long countAll();
    void insert(Author_24162067 author);
    void update(Author_24162067 author);
    void delete(Integer authorId);
}
