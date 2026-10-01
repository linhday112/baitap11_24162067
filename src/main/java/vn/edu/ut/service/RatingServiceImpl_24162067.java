package vn.edu.ut.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.ut.dao.IRatingDao_24162067;
import vn.edu.ut.entity.Rating_24162067;
import vn.edu.ut.entity.RatingId_24162067;

import java.util.List;

@Service
@Transactional
public class RatingServiceImpl_24162067 implements IRatingService_24162067 {

    @Autowired
    private IRatingDao_24162067 ratingDao;

    @Override
    @Transactional(readOnly = true)
    public Rating_24162067 findById(RatingId_24162067 id) {
        return ratingDao.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Rating_24162067> findByBookId(Integer bookid) {
        return ratingDao.findByBookId(bookid);
    }

    @Override
    public void insertOrUpdate(Rating_24162067 rating) {
        ratingDao.insertOrUpdate(rating);
    }

    @Override
    @Transactional(readOnly = true)
    public long countByBookId(Integer bookid) {
        return ratingDao.countByBookId(bookid);
    }
}
