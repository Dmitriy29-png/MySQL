/* 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи". */

DROP PROCEDURE IF EXISTS hello;
delimiter //
CREATE PROCEDURE hello()
BEGIN
	CASE 
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			SELECT 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			SELECT 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '00:00:00' THEN
			SELECT 'Добрый вечер';
		ELSE
			SELECT 'Доброй ночи';
	END CASE;
END //
delimiter ;

CALL hello();

/* 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL 
неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию.*/

SELECT * FROM products;

DELIMITER //
DROP TRIGGER IF EXISTS name_descr_control_insert//

CREATE TRIGGER name_descr_control_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Both name and descr cannot be NULL';
	END IF;
END//

INSERT INTO products (name, description) VALUES (NULL, NULL)//

DROP TRIGGER IF EXISTS name_descr_control_update//
CREATE TRIGGER name_descr_control_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Both name and descr cannot be NULL';
	END IF;
END//

/* 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
Вызов функции FIBONACCI(10) должен возвращать число 55. */

DELIMITER //

DROP FUNCTION IF EXISTS FIBONACCI//

CREATE FUNCTION FIBONACCI(value INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE Xminus2 INT DEFAULT 0;
    DECLARE Xminus1 INT DEFAULT 1;
    DECLARE X INT DEFAULT 0;
	DECLARE i INT DEFAULT 1;
    
	IF (value = 1) THEN
		RETURN 1;
	ELSE
		WHILE i < value DO
			SET X = Xminus1 + Xminus2;
			SET i = i + 1;
			SET Xminus2 = Xminus1;
			SET Xminus1 = X;
		END WHILE;
        
        RETURN X;
	END IF;

END//

SELECT FIBONACCI(10)//