USE test_shop;
/* ������ �1. ����������� ������� ������� ������������� � ������� users. */
SELECT * FROM users;

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age FROM users;

/* ������ �2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������.
   ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������. */

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;

/* ������ �3. ����������� ������������ ����� � ������� �������. */
SELECT ROUND(EXP(SUM(LN(id)))) FROM users WHERE id < 6;