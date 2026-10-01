package vn.edu.ut;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import vn.edu.ut.dao.IOrderDao_24162067;
import vn.edu.ut.dao.IUserDao_24162067;
import vn.edu.ut.entity.Order_24162067;
import vn.edu.ut.entity.User_24162067;
import vn.edu.ut.utils.DataInitializer_24162067;
import java.util.List;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class SampleOrderCleanupTest {
    @Mock IOrderDao_24162067 orderDao;
    @Mock IUserDao_24162067 userDao;
    @InjectMocks DataInitializer_24162067 initializer;

    @Test
    void deletesOnlyGeneratedOrdersEvenWhenTheirStatusWasChanged() throws Exception {
        Order_24162067 sample = new Order_24162067();
        sample.setId(1);
        sample.setNote("Đơn hàng thử nghiệm trạng thái: Đơn hàng mới");
        sample.setAddress("123 Đường Võ Văn Ngân, TP. Thủ Đức, TP.HCM");
        sample.setStatus("Đơn hàng hủy");
        Order_24162067 real = new Order_24162067();
        real.setId(9);
        real.setAddress("hcm");
        when(orderDao.findAll()).thenReturn(List.of(sample, real));
        when(userDao.findAll()).thenReturn(List.of(new User_24162067()));
        initializer.run();
        verify(orderDao).delete(1);
        verify(orderDao, never()).delete(9);
        verify(orderDao, never()).insert(any());
    }
}
