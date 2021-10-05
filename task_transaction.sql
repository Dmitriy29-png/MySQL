/* 1.� ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������.
  ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.*/


START TRANSACTION;

INSERT INTO sample.users (SELECT * FROM shop.users WHERE shop.users.id = 1);
COMMIT;

/* 2.�������� �������������, ������� ������� �������� name �������� �������
 �� ������� products � ��������������� �������� �������� name �� ������� catalogs.*/


CREATE VIEW prd AS 
  SELECT products.name AS p_name, catalogs.name AS c_name 
    FROM products,catalogs 
      WHERE products.catalog_id = catalogs.id;
      
SELECT * FROM prd;

CREATE VIEW prod AS SELECT products.name AS product, catalogs.name AS catalog FROM products
LEFT JOIN catalogs ON products.catalog_id = catalogs.id;

SELECT * FROM prod;

/* 3.�� �������) ����� ������� ������� � ����������� ����� created_at.
  � ��� ��������� ���������� ����������� ������ �� ������ 2018 ����'2018-08-01', '2016-08-04', '2018-08-16'
   � 2018-08-17. ��������� ������, ������� ������� ������ ������ ��� �� ������,
   ��������� � �������� ���� �������� 1, ���� ���� ������������ � �������� ������� � 0, ���� ��� �����������.*/

DROP TABLE IF EXISTS task3;
create table task3 (
  id SERIAL PRIMARY KEY,
  created_at date);
INSERT INTO task3 VALUES
  (NULL, '2018-08-01'), (NULL, '2018-08-04'), (NULL, '2018-08-16'), (NULL, '2018-08-17');



                            


/* 4. (�� �������) ����� ������� ����� ������� � ����������� ����� created_at. 
 �������� ������, ������� ������� ���������� ������ �� �������, �������� ������ 5 ����� ������ �������.*/


PREPARE del_prod FROM "DELETE FROM products ORDER BY created_at LIMIT ?";
SET @rowse = (SELECT COUNT(*)-5 FROM products);
EXECUTE del_prod USING @rowse;

SELECT * FROM products;