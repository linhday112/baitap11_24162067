package vn.edu.ut.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import vn.edu.ut.entity.Order_24162067;

import java.util.List;

@Repository
public class OrderDaoImpl_24162067 implements IOrderDao_24162067 {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Order_24162067 findById(Integer id) {
        TypedQuery<Order_24162067> query = em.createQuery(
            "SELECT DISTINCT o FROM Order_24162067 o LEFT JOIN FETCH o.items i LEFT JOIN FETCH i.book WHERE o.id = :id",
            Order_24162067.class
        );
        query.setParameter("id", id);
        List<Order_24162067> list = query.getResultList();
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<Order_24162067> findByUserId(Integer userId) {
        TypedQuery<Order_24162067> query = em.createQuery(
            "SELECT DISTINCT o FROM Order_24162067 o LEFT JOIN FETCH o.items i LEFT JOIN FETCH i.book WHERE o.user.id = :userId ORDER BY o.orderDate DESC, o.id DESC",
            Order_24162067.class
        );
        query.setParameter("userId", userId);
        return query.getResultList();
    }

    @Override
    public List<Order_24162067> findByUserIdAndStatus(Integer userId, String status) {
        TypedQuery<Order_24162067> query = em.createQuery(
            "SELECT DISTINCT o FROM Order_24162067 o LEFT JOIN FETCH o.items i LEFT JOIN FETCH i.book WHERE o.user.id = :userId AND o.status = :status ORDER BY o.orderDate DESC, o.id DESC",
            Order_24162067.class
        );
        query.setParameter("userId", userId);
        query.setParameter("status", status);
        return query.getResultList();
    }

    @Override
    public List<Order_24162067> findAll() {
        TypedQuery<Order_24162067> query = em.createQuery(
            "SELECT DISTINCT o FROM Order_24162067 o LEFT JOIN FETCH o.items i LEFT JOIN FETCH i.book ORDER BY o.orderDate DESC, o.id DESC",
            Order_24162067.class
        );
        return query.getResultList();
    }

    @Override
    public List<Order_24162067> findAllByStatus(String status) {
        TypedQuery<Order_24162067> query = em.createQuery(
            "SELECT DISTINCT o FROM Order_24162067 o LEFT JOIN FETCH o.items i LEFT JOIN FETCH i.book WHERE o.status = :status ORDER BY o.orderDate DESC, o.id DESC",
            Order_24162067.class
        );
        query.setParameter("status", status);
        return query.getResultList();
    }

    @Override
    public void insert(Order_24162067 order) {
        em.persist(order);
    }

    @Override
    public void update(Order_24162067 order) {
        em.merge(order);
    }

    @Override
    public void delete(Integer id) {
        Order_24162067 order = em.find(Order_24162067.class, id);
        if (order != null) {
            em.remove(order);
        }
    }
}
