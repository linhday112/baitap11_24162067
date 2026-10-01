package vn.edu.ut.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.ut.dao.IBookDao_24162067;
import vn.edu.ut.entity.Book_24162067;

import java.util.List;

@Service
@Transactional
public class BookServiceImpl_24162067 implements IBookService_24162067 {

    @Autowired
    private IBookDao_24162067 bookDao;

    @Override
    @Transactional(readOnly = true)
    public Book_24162067 findById(Integer bookid) {
        return bookDao.findById(bookid);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Book_24162067> findAll(int page, int pageSize) {
        return bookDao.findAll(page, pageSize);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Book_24162067> findAll() {
        return bookDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public long countAll() {
        return bookDao.countAll();
    }

    @Override
    @Transactional(readOnly = true)
    public int getTotalPages(int pageSize) {
        long count = countAll();
        return (int) Math.ceil((double) count / pageSize);
    }

    @Override
    public void insert(Book_24162067 book) {
        bookDao.insert(book);
    }

    @Override
    public void update(Book_24162067 book) {
        bookDao.update(book);
    }

    @Override
    public void delete(Integer bookid) {
        bookDao.delete(bookid);
    }
}
