package vn.edu.ut.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import vn.edu.ut.entity.Book_24162067;

import java.util.List;

@Repository
public class BookDaoImpl_24162067 implements IBookDao_24162067 {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Book_24162067 findById(Integer bookid) {
        Book_24162067 book = em.find(Book_24162067.class, bookid);
        if (book != null) {
            book.getAuthors().size();
            book.getRatings().size();
        }
        return book;
    }

    @Override
    public List<Book_24162067> findAll(int page, int pageSize) {
        TypedQuery<Book_24162067> query = em.createQuery("SELECT b FROM Book_24162067 b ORDER BY b.bookid DESC", Book_24162067.class);
        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);
        List<Book_24162067> list = query.getResultList();
        for (Book_24162067 b : list) {
            b.getAuthors().size();
            b.getRatings().size();
        }
        return list;
    }

    @Override
    public List<Book_24162067> findAll() {
        TypedQuery<Book_24162067> query = em.createQuery("SELECT b FROM Book_24162067 b ORDER BY b.bookid DESC", Book_24162067.class);
        List<Book_24162067> list = query.getResultList();
        for (Book_24162067 b : list) {
            b.getAuthors().size();
            b.getRatings().size();
        }
        return list;
    }

    @Override
    public long countAll() {
        TypedQuery<Long> query = em.createQuery("SELECT COUNT(b) FROM Book_24162067 b", Long.class);
        return query.getSingleResult();
    }

    @Override
    public void insert(Book_24162067 book) {
        em.persist(book);
    }

    @Override
    public void update(Book_24162067 book) {
        em.merge(book);
    }

    @Override
    public void delete(Integer bookid) {
        Book_24162067 book = em.find(Book_24162067.class, bookid);
        if (book != null) {
            em.remove(book);
        }
    }
}
