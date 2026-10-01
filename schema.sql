-- SQL Schema & Initial Data Script for MSSV: 24162067

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(50) NOT NULL UNIQUE,
    fullname NVARCHAR(50),
    phone VARCHAR(15),
    passwd VARCHAR(64) NOT NULL,
    signup_date DATETIME DEFAULT GETDATE(),
    last_login DATETIME,
    is_admin BIT DEFAULT 0
);

CREATE TABLE books (
    bookid INT IDENTITY(1,1) PRIMARY KEY,
    isbn INT,
    title VARCHAR(200),
    publisher VARCHAR(100),
    price DECIMAL(6,2),
    description TEXT,
    publish_date DATE,
    cover_image VARCHAR(100),
    quantity INT
);

CREATE TABLE author (
    author_id INT IDENTITY(1,1) PRIMARY KEY,
    author_name VARCHAR(100),
    date_of_birth DATE
);

CREATE TABLE book_author (
    bookid INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (bookid, author_id),
    FOREIGN KEY (bookid) REFERENCES books(bookid) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author(author_id) ON DELETE CASCADE
);

CREATE TABLE rating (
    userid INT NOT NULL,
    bookid INT NOT NULL,
    rating TINYINT,
    review_text TEXT,
    PRIMARY KEY (userid, bookid),
    FOREIGN KEY (userid) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (bookid) REFERENCES books(bookid) ON DELETE CASCADE
);

-- Insert Sample Users (Default Admin & Standard User)
-- Password for admin: admin123 (hashed SHA-256: 8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918)
-- Password for user: user123 (hashed SHA-256: 04f8996da763b7a969b1028ee3007569eaf3a635486ddab211d512c85b9df8fb)
INSERT INTO users (email, fullname, phone, passwd, signup_date, is_admin) VALUES
('admin@example.com', N'Quản Trị Viên', '0901234567', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', GETDATE(), 1),
('user@example.com', N'Nguyễn Văn A', '0912345678', '04f8996da763b7a969b1028ee3007569eaf3a635486ddab211d512c85b9df8fb', GETDATE(), 0);

-- Insert Sample Authors
INSERT INTO author (author_name, date_of_birth) VALUES
('J.K. Rowling', '1965-07-31'),
('George R.R. Martin', '1948-09-20'),
('J.R.R. Tolkien', '1892-01-03'),
('Dan Brown', '1964-06-22'),
('Nam Cao', '1915-10-29'),
('Tô Hoài', '1920-09-27');

-- Insert Sample Books (At least 7 books to test 6 items/page pagination)
INSERT INTO books (isbn, title, publisher, price, description, publish_date, cover_image, quantity) VALUES
(1001, 'Harry Potter and the Sorcerer Stone', 'Bloomsbury', 19.99, 'A young wizard discovers his magical heritage.', '1997-06-26', 'harry_potter.jpg', 50),
(1002, 'A Game of Thrones', 'Bantam Spectra', 25.50, 'Trouble is brewing in the Seven Kingdoms of Westeros.', '1996-08-01', 'got.jpg', 35),
(1003, 'The Lord of the Rings', 'Allen & Unwin', 30.00, 'An epic high-fantasy novel by J. R. R. Tolkien.', '1954-07-29', 'lotr.jpg', 40),
(1004, 'The Da Vinci Code', 'Doubleday', 15.00, 'A mystery thriller novel by Dan Brown.', '2003-03-18', 'davinci.jpg', 60),
(1005, 'Chí Phèo', 'NXB Văn Học', 8.50, 'Tác phẩm văn học kinh điển của nhà văn Nam Cao.', '1941-02-15', 'chipheo.jpg', 100),
(1006, 'Dế Mèn Phiêu Lưu Ký', 'NXB Kim Đồng', 9.00, 'Truyện thiếu nhi nổi tiếng của nhà văn Tô Hoài.', '1941-09-10', 'demen.jpg', 80),
(1007, 'Lão Hạc', 'NXB Văn Học', 7.50, 'Truyện ngắn xuất sắc của nhà văn Nam Cao.', '1943-05-12', 'laohac.jpg', 45),
(1008, 'Angels & Demons', 'Pocket Books', 14.50, 'Robert Langdon investigates a murder at CERN.', '2000-05-01', 'angels.jpg', 30);

-- Insert Book Authors
INSERT INTO book_author (bookid, author_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 5),
(8, 4);

-- Insert Sample Ratings
INSERT INTO rating (userid, bookid, rating, review_text) VALUES
(2, 1, 5, 'Sách rất hay và kịch tính!'),
(2, 2, 4, 'Cốt truyện lôi cuốn nhưng hơi dài.'),
(2, 5, 5, 'Truyện vô cùng xúc động.');

-- CREATE Orders and Order_Items Tables
CREATE TABLE orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userid INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    recipient_name NVARCHAR(100),
    recipient_phone VARCHAR(20),
    address NVARCHAR(255),
    note NVARCHAR(500),
    total_amount DECIMAL(12,2),
    payment_method NVARCHAR(50),
    status NVARCHAR(50),
    FOREIGN KEY (userid) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    bookid INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (bookid) REFERENCES books(bookid) ON DELETE CASCADE
);

