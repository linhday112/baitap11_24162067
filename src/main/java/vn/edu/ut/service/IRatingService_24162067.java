package vn.edu.ut.service;

import vn.edu.ut.entity.Rating_24162067;
import vn.edu.ut.entity.RatingId_24162067;
import java.util.List;

public interface IRatingService_24162067 {
    Rating_24162067 findById(RatingId_24162067 id);
    List<Rating_24162067> findByBookId(Integer bookid);
    void insertOrUpdate(Rating_24162067 rating);
    long countByBookId(Integer bookid);
}
