DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) COMMENT '�������� �������',
  UNIQUE unique_name(name(10))
) COMMENT = '������� ��������-��������';

INSERT INTO catalogs VALUES
  (NULL, '����������'),
  (NULL, '����������� �����'),
  (NULL, '����������'),
  (NULL, '������� �����'),
  (NULL, '����������� ������');
  
 
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ����������',
  birthday_at DATE COMMENT '���� ��������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '����������';

INSERT INTO users (name, birthday_at) VALUES
  ('��������', '1990-10-05'),
  ('�������', '1984-11-12'),
  ('���������', '1985-05-20'),
  ('������', '1988-02-14'),
  ('����', '1998-01-12'),
  ('�����', '1992-08-29');
  
 DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) COMMENT '��������',
  price DECIMAL (11,2) COMMENT '����',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '�������� �������';

INSERT INTO products
  (name, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 7890.00, 1),
  ('Intel Core i5-7400', 12700.00, 1),
  ('AMD FX-8320E', 4780.00, 1),
  ('AMD FX-8320', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 19310.00, 2),
  ('Gigabyte H310M S2H', 4790.00, 2),
  ('MSI B250M GAMING PRO', 5060.00, 2);
  
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '������';
INSERT INTO orders(user_id)
VALUES (1), (2), (3), (4), 
	   (1), (2), (5), (5);
	   
	  
DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT '���������� ���������� �������� �������',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '������ ������';

INSERT INTO orders_products(order_id, product_id, total)
VALUES (1, 1, 1), (1, 2, 2), (1, 3, 3), (1, 4, 4), 
	   (2, 1, 1), (3, 2, 2), (4, 3, 3), (5, 4, 4);
	   
ALTER TABLE orders 
	ADD CONSTRAINT orders_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON DELETE CASCADE;

ALTER TABLE products 
	ADD CONSTRAINT products_catalog_id_fk
	FOREIGN KEY (catalog_id) REFERENCES catalogs(id)
	ON DELETE CASCADE;

ALTER TABLE orders_products 
	ADD CONSTRAINT orders_products_order_id_fk
	FOREIGN KEY (order_id) REFERENCES orders(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT orders_products_product_id_fk
	FOREIGN KEY (product_id) REFERENCES products(id)
	ON DELETE CASCADE;