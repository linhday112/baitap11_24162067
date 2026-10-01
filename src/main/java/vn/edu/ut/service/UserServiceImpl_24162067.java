package vn.edu.ut.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.ut.dao.IUserDao_24162067;
import vn.edu.ut.entity.User_24162067;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl_24162067 implements IUserService_24162067 {

    @Autowired
    private IUserDao_24162067 userDao;

    @Override
    @Transactional(readOnly = true)
    public User_24162067 findById(Integer id) {
        return userDao.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public User_24162067 findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    @Transactional(readOnly = true)
    public User_24162067 login(String email, String rawPassword) {
        return userDao.login(email, rawPassword);
    }

    @Override
    public void register(User_24162067 user) {
        userDao.insert(user);
    }

    @Override
    public void update(User_24162067 user) {
        userDao.update(user);
    }

    @Override
    public void delete(Integer id) {
        userDao.delete(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<User_24162067> findAll() {
        return userDao.findAll();
    }
}
