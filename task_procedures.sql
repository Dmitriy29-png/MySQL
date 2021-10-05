/* 1. �������� �������� ������� hello(), ������� ����� ���������� �����������, 
� ����������� �� �������� ������� �����. 
� 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", 
� 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", 
� 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����". */

DROP PROCEDURE IF EXISTS hello;
delimiter //
CREATE PROCEDURE hello()
BEGIN
	CASE 
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			SELECT '������ ����';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			SELECT '������ ����';
		WHEN CURTIME() BETWEEN '18:00:00' AND '00:00:00' THEN
			SELECT '������ �����';
		ELSE
			SELECT '������ ����';
	END CASE;
END //
delimiter ;

CALL hello();

/* 2. � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. 
��������� ����������� ����� ����� ��� ���� �� ���. ��������, ����� ��� ���� ��������� �������������� �������� NULL 
�����������. ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. 
��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.*/

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

/* 3. (�� �������) �������� �������� ������� ��� ���������� ������������� ����� ���������. 
������� ��������� ���������� ������������������ � ������� ����� ����� ����� ���� ���������� �����. 
����� ������� FIBONACCI(10) ������ ���������� ����� 55. */

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