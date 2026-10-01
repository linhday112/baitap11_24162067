package vn.edu.ut.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.io.FileWriter;
import java.io.PrintWriter;

@ControllerAdvice
public class GlobalExceptionHandler_24162067 {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler_24162067.class);

    @ExceptionHandler(Throwable.class)
    public void handleAllExceptions(Throwable ex) throws Throwable {
        logger.error("GLOBAL EXCEPTION CAPTURED:", ex);
        try (PrintWriter writer = new PrintWriter(new FileWriter("C:/24162067_01/24162067_01/app_error.log", true))) {
            writer.println("=== ERROR AT " + new java.util.Date() + " ===");
            ex.printStackTrace(writer);
            writer.println("=========================================");
        } catch (Exception e) {
            e.printStackTrace();
        }
        throw ex;
    }
}
