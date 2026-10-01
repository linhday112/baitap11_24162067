package vn.edu.ut.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import vn.edu.ut.entity.Author_24162067;

import java.util.List;

@Repository
public class AuthorDaoImpl_24162067 implements IAuthorDao_24162067 {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Author_24162067 findById(Integer authorId) {
        return em.find(Author_24162067.class, authorId);
    }

    @Override
    public List<Author_24162067> findAll(int page, int pageSize) {
        TypedQuery<Author_24162067> query = em.createQuery("SELECT a FROM Author_24162067 a ORDER BY a.authorId DESC", Author_24162067.class);
        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }

    @Override
    public List<Author_24162067> findAll() {
        TypedQuery<Author_24162067> query = em.createQuery("SELECT a FROM Author_24162067 a ORDER BY a.authorId DESC", Author_24162067.class);
        return query.getResultList();
    }

    @Override
    public long countAll() {
        TypedQuery<Long> query = em.createQuery("SELECT COUNT(a) FROM Author_24162067 a", Long.class);
        return query.getSingleResult();
    }

    @Override
    public void insert(Author_24162067 author) {
        em.persist(author);
    }

    @Override
    public void update(Author_24162067 author) {
        em.merge(author);
    }

    @Override
    public void delete(Integer authorId) {
        Author_24162067 author = em.find(Author_24162067.class, authorId);
        if (author != null) {
            em.remove(author);
        }
    }
}
