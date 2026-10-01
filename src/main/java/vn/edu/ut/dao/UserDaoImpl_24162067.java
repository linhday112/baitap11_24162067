package vn.edu.ut.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import vn.edu.ut.entity.User_24162067;
import vn.edu.ut.utils.PasswordUtils_24162067;

import java.util.List;

@Repository
public class UserDaoImpl_24162067 implements IUserDao_24162067 {

    @PersistenceContext
    private EntityManager em;

    @Override
    public User_24162067 findById(Integer id) {
        return em.find(User_24162067.class, id);
    }

    @Override
    public User_24162067 findByEmail(String email) {
        TypedQuery<User_24162067> query = em.createQuery("SELECT u FROM User_24162067 u WHERE u.email = :email", User_24162067.class);
        query.setParameter("email", email);
        List<User_24162067> list = query.getResultList();
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public User_24162067 login(String email, String rawPassword) {
        String hashedPassword = PasswordUtils_24162067.hashPassword(rawPassword);
        TypedQuery<User_24162067> query = em.createQuery(
            "SELECT u FROM User_24162067 u WHERE u.email = :email AND u.passwd = :passwd",
            User_24162067.class
        );
        query.setParameter("email", email);
        query.setParameter("passwd", hashedPassword);
        List<User_24162067> list = query.getResultList();
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public void insert(User_24162067 user) {
        em.persist(user);
    }

    @Override
    public void update(User_24162067 user) {
        em.merge(user);
    }

    @Override
    public void delete(Integer id) {
        User_24162067 user = em.find(User_24162067.class, id);
        if (user != null) {
            em.remove(user);
        }
    }

    @Override
    public List<User_24162067> findAll() {
        return em.createQuery("SELECT u FROM User_24162067 u", User_24162067.class).getResultList();
    }
}
