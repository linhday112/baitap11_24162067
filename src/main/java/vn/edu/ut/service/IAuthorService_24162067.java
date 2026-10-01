package vn.edu.ut.service;

import vn.edu.ut.entity.Author_24162067;
import java.util.List;

public interface IAuthorService_24162067 {
    Author_24162067 findById(Integer authorId);
    List<Author_24162067> findAll(int page, int pageSize);
    List<Author_24162067> findAll();
    long countAll();
    int getTotalPages(int pageSize);
    void insert(Author_24162067 author);
    void update(Author_24162067 author);
    void delete(Integer authorId);
}
