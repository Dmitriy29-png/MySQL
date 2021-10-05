/* 1.¬ базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
  ѕереместите запись id = 1 из таблицы shop.users в таблицу sample.users. »спользуйте транзакции.*/


START TRANSACTION;

INSERT INTO sample.users (SELECT * FROM shop.users WHERE shop.users.id = 1);
COMMIT;

/* 2.—оздайте представление, которое выводит название name товарной позиции
 из таблицы products и соответствующее название каталога name из таблицы catalogs.*/


CREATE VIEW prd AS 
  SELECT products.name AS p_name, catalogs.name AS c_name 
    FROM products,catalogs 
      WHERE products.catalog_id = catalogs.id;
      
SELECT * FROM prd;

CREATE VIEW prod AS SELECT products.name AS product, catalogs.name AS catalog FROM products
LEFT JOIN catalogs ON products.catalog_id = catalogs.id;

SELECT * FROM prod;

/* 3.по желанию) ѕусть имеетс€ таблица с календарным полем created_at.
  ¬ ней размещены разр€женые календарные записи за август 2018 года'2018-08-01', '2016-08-04', '2018-08-16'
   и 2018-08-17. —оставьте запрос, который выводит полный список дат за август,
   выставл€€ в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.*/

DROP TABLE IF EXISTS task3;
create table task3 (
  id SERIAL PRIMARY KEY,
  created_at date);
INSERT INTO task3 VALUES
  (NULL, '2018-08-01'), (NULL, '2018-08-04'), (NULL, '2018-08-16'), (NULL, '2018-08-17');



                            


/* 4. (по желанию) ѕусть имеетс€ люба€ таблица с календарным полем created_at. 
 —оздайте запрос, который удал€ет устаревшие записи из таблицы, оставл€€ только 5 самых свежих записей.*/


PREPARE del_prod FROM "DELETE FROM products ORDER BY created_at LIMIT ?";
SET @rowse = (SELECT COUNT(*)-5 FROM products);
EXECUTE del_prod USING @rowse;

SELECT * FROM products;