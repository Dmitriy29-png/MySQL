/* ������ �1. ����� � ������� users ���� created_at � updated_at ��������� ��������������.
 *  ��������� �� �������� ����� � ��������. */
DROP DATABASE IF EXISTS test_shop;
CREATE DATABASE IF NOT EXISTS test_shop;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME,
  updated_at DATETIME
);

INSERT INTO users (name, birthday_at) VALUES
  ('��������', '1990-10-05'),
  ('�������', '1984-11-12'),
  ('���������', '1985-05-20'),
  ('������', '1988-02-14'),
  ('����', '1998-01-12'),
  ('�����', '1992-08-29');

SELECT * FROM users;
UPDATE users SET created_at = NOW(), updated_at = NOW();

/* ������ �2. ������� users ���� �������� ��������������.
   ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10".
   ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
*/

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL,
  name VARCHAR(255),
  birthday_at DATE,
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
);

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('��������', '1990-10-05', '07.01.2019 13:10', '07.01.2019 13:10'),
  ('�������', '1984-11-12', '20.05.2018 17:35', '20.05.2018 17:35'),
  ('���������', '1985-05-20', '14.08.2019 20:05', '14.08.2019 20:05'),
  ('������', '1988-02-14', '21.10.2017 10:20', '21.10.2017 10:20'),
  ('����', '1998-01-12', '15.12.2016 13:45', '15.12.2016 13:45'),
  ('�����', '1992-08-29', '12.01.2017 8:35', '12.01.2017 8:35');
 
SELECT * FROM users;
 
UPDATE users
SET
created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users
CHANGE
created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE users
CHANGE
updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


/* ������ �3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����:
   0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������.
   ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value.
   ������, ������� ������ ������ ���������� � �����, ����� ���� �������.
*/
DROP TABLE IF EXISTS storehouses_products; 
CREATE TABLE storehouses_products (
  id SERIAL,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
  (1, 540, 0),
  (1, 790, 2500),
  (1, 3430, 0),
  (1, 820, 30),
  (1, 720, 500),
  (1, 640, 1);

SELECT * FROM storehouses_products;
SELECT * FROM storehouses_products ORDER BY IF(value > 0, 0, 1), value;

/* ������ �4. �� ������� users ���������� ������� �������������, ���������� � ������� � ���. 
������ ������ � ���� ������ ���������� �������� ('may', 'august'). */

SELECT name, birthday_at FROM users WHERE MONTHNAME(birthday_at) IN ('may', 'august');

/* ������ �5. �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
 * ������������ ������ � �������, �������� � ������ IN. */

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO catalogs (id, name) VALUES
  (1, '����������'),
  (2, '����������� �����'),
  (3, '����������'),
  (4, '������� ����'),
  (5, '����������� ������')
  ;

SELECT * FROM catalogs;
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
