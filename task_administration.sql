/*1. —оздайте двух пользователей которые имеют доступ к базе данных shop.
 ѕервому пользователю shop_read должны быть доступны только запросы на чтение данных,
 второму пользователю shop Ч любые операции в пределах базы данных shop.*/

DROP USER IF EXISTS 'shop_read'@'localhost';
CREATE USER 'shop_read'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';

DROP USER IF EXISTS 'shop'@'localhost';
CREATE USER 'shop'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT ALL ON shop.* TO 'shop'@'localhost';
GRANT GRANT OPTION ON shop.* TO 'shop'@'localhost';

/*2. (по желанию) ≈сть таблица (accounts), включающа€ в себ€ три столбца: id, name, password,
 которые содержат первичный ключ, им€ пользовател€ и его пароль. —оздайте представление username таблицы accounts,
 предоставл€ющее доступ к столбцам id и name. —оздайте пользовател€ user_read,
который бы не имел доступа к таблице accounts, однако мог извлекать записи из представлени€ username.*/

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(45),
	password VARCHAR(45)
);

INSERT INTO accounts VALUES
	(NULL, 'mike', '12FFF3'),
	(NULL, 'jack', '45SSS6'),
	(NULL, 'roni', '68DDff7');

CREATE OR REPLACE VIEW username(user_id, user_name) AS 
	SELECT id, name FROM accounts;

SELECT * FROM accounts;
SELECT * FROM username;

DROP USER IF EXISTS 'shop_reader'@'localhost';
CREATE USER 'shop_reader'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT SELECT ON shop.username TO 'shop_reader'@'localhost';
