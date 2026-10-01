package vn.edu.ut.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.ut.dao.IAuthorDao_24162067;
import vn.edu.ut.entity.Author_24162067;

import java.util.List;

@Service
@Transactional
public class AuthorServiceImpl_24162067 implements IAuthorService_24162067 {

    @Autowired
    private IAuthorDao_24162067 authorDao;

    @Override
    @Transactional(readOnly = true)
    public Author_24162067 findById(Integer authorId) {
        return authorDao.findById(authorId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Author_24162067> findAll(int page, int pageSize) {
        return authorDao.findAll(page, pageSize);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Author_24162067> findAll() {
        return authorDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public long countAll() {
        return authorDao.countAll();
    }

    @Override
    @Transactional(readOnly = true)
    public int getTotalPages(int pageSize) {
        long count = countAll();
        return (int) Math.ceil((double) count / pageSize);
    }

    @Override
    public void insert(Author_24162067 author) {
        authorDao.insert(author);
    }

    @Override
    public void update(Author_24162067 author) {
        authorDao.update(author);
    }

    @Override
    public void delete(Integer authorId) {
        authorDao.delete(authorId);
    }
}
