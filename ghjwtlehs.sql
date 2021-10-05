select *from event e ;
select * from users u ;
/* определим скольно мероприятий организовали  мужчины и женщины*/
SELECT (SELECT gender FROM users  WHERE id = event.creator_id ) AS gender,
COUNT(*)total 
FROM event
GROUP BY gender ;
/* определи самых активных пользователейб по лайкам, медиа файлам вылоеные ими, по количеству сообщений и
 по количеству организованых мероприятий
 */
SELECT CONCAT(first_name,'',last_name) AS user,
	(SELECT COUNT(*)FROM likes WHERE likes.user_id = users.id)+
	(SELECT COUNT(*) FROM  media WHERE media.user_id = users.id)+
	(SELECT COUNT(*) FROM event WHERE event.creator_id = users.id)+
	(SELECT COUNT(*)FROM messages WHERE messages.from_user_id = users.id) AS total
	FROM users
	ORDER BY total DESC
	LIMIT 10;
	
SELECT CONCAT(first_name,'',last_name) AS user,
	COUNT(DISTINCT likes.id) +
	COUNT(DISTINCT media.id) +
	COUNT(DISTINCT messages.id) +
	COUNT(DISTINCT event.id) AS activity
  FROM users
	LEFT JOIN likes
		ON users.id = likes.user_id 
	LEFT JOIN media
		ON users.id = media.user_id
	LEFT  JOIN  messages
		ON users.id = messages.from_user_id
	LEFT JOIN event
		ON users.id = event.creator_id
GROUP BY users.id 
ORDER BY activity DESC 
LIMIT 10;

/* сденлаем  представление  которое выводит   в какой стране и городе проживает каждый  пользователь*/

CREATE VIEW loc (name, city, country) AS 
SELECT u.first_name, c.name , co.name 
	FROM users u 
		INNER JOIN profiles p 
			ON u.id = p.user_id 
		INNER JOIN location l 
			ON p.location_id = l.id
		INNER JOIN city c 
			ON l.city_id = c.id 
		INNER JOIN country co 
			ON l.country_id = co.id;
SELECT * FROM loc;
/* представление  которое выводит всех пользователей которые зарегестрровались 2013 году*/

CREATE VIEW dat AS
SELECT first_name, last_name, created_at 
	FROM users u 
		WHERE year (created_at) = 2013;
SELECT * FROM dat;

/* триггер на вставку данных*/
DELIMITER //

CREATE TRIGGER  first_name_last_name  BEFORE INSERT  ON users
FOR EACH  ROW BEGIN 
	IF  NEW.first_name IS NULL AND NEW.last_name IS NULL THEN
	SIGNAL  SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Both name are null';
END IF;
END// 

