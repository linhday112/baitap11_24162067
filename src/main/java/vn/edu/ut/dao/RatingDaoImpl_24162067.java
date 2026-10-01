package vn.edu.ut.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import vn.edu.ut.entity.Rating_24162067;
import vn.edu.ut.entity.RatingId_24162067;

import java.util.List;

@Repository
public class RatingDaoImpl_24162067 implements IRatingDao_24162067 {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Rating_24162067 findById(RatingId_24162067 id) {
        return em.find(Rating_24162067.class, id);
    }

    @Override
    public List<Rating_24162067> findByBookId(Integer bookid) {
        TypedQuery<Rating_24162067> query = em.createQuery(
            "SELECT r FROM Rating_24162067 r WHERE r.id.bookid = :bookid",
            Rating_24162067.class
        );
        query.setParameter("bookid", bookid);
        List<Rating_24162067> list = query.getResultList();
        for (Rating_24162067 r : list) {
            if (r.getUser() != null) {
                r.getUser().getEmail();
            }
        }
        return list;
    }

    @Override
    public void insertOrUpdate(Rating_24162067 rating) {
        em.merge(rating);
    }

    @Override
    public long countByBookId(Integer bookid) {
        TypedQuery<Long> query = em.createQuery(
            "SELECT COUNT(r) FROM Rating_24162067 r WHERE r.id.bookid = :bookid",
            Long.class
        );
        query.setParameter("bookid", bookid);
        return query.getSingleResult();
    }
}
