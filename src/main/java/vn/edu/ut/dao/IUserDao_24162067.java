package vn.edu.ut.dao;

import vn.edu.ut.entity.User_24162067;
import java.util.List;

public interface IUserDao_24162067 {
    User_24162067 findById(Integer id);
    User_24162067 findByEmail(String email);
    User_24162067 login(String email, String rawPassword);
    void insert(User_24162067 user);
    void update(User_24162067 user);
    void delete(Integer id);
    List<User_24162067> findAll();
}
