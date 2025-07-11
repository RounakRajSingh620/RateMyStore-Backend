DROP DATABASE IF EXISTS ratemystore;
CREATE DATABASE ratemystore;
USE ratemystore;
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(255),
  role ENUM('admin', 'user', 'store-owner') DEFAULT 'user',
  address VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE stores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  address TEXT,
  email VARCHAR(100),
  ownerId INT,
  FOREIGN KEY (ownerId) REFERENCES users(id)
);
CREATE TABLE ratings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  storeId INT,
  ratingValue INT CHECK (ratingValue BETWEEN 1 AND 5),
  creatorId INT,
  date DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (storeId) REFERENCES stores(id),
  FOREIGN KEY (creatorId) REFERENCES users(id)
);
INSERT INTO users (name, email, password, role, address) VALUES
('Admin User', 'admin@example.com', 'admin123', 'admin', 'Admin HQ'),
('Alice StoreOwner', 'alice@store.com', 'alice123', 'store-owner', 'Tech Street'),
('John Customer', 'john@user.com', 'john123', 'user', 'Consumer City');
INSERT INTO stores (name, address, email, ownerId) VALUES
('Alice Appliances', '100 Main Street, Tech City', 'alice@store.com', 2),
('Fashion Fiesta', '200 Style Blvd, Mumbai', 'fashion@store.com', 2);
INSERT INTO ratings (storeId, ratingValue, creatorId) VALUES
(1, 5, 3),
(1, 4, 3),
(2, 3, 3);
USE ratemystore;
SELECT * FROM users;
ALTER TABLE users ADD INDEX idx_users_name_email_role (name, email, role);
ALTER TABLE stores ADD INDEX idx_stores_name_email (name, email);
CREATE VIEW store_rating_summary AS
SELECT 
  s.id AS storeId,
  s.name AS storeName,
  s.email AS storeEmail,
  s.address,
  u.name AS ownerName,
  ROUND(AVG(r.ratingValue), 2) AS averageRating,
  COUNT(r.id) AS totalRatings
FROM stores s
LEFT JOIN users u ON s.ownerId = u.id
LEFT JOIN ratings r ON r.storeId = s.id
GROUP BY s.id;
SELECT * FROM store_rating_summary;

