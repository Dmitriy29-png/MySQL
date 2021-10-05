/* 3. Определить кто больше поставил лайков (всего) - мужчины или женщины? */
SELECT  COUNT(*) AS likes, gender FROM likes, profiles
WHERE likes.user_id = profiles.user_id 
GROUP BY gender;

/* 4. Подсчитать количество лайков которые получили 10 самых молодых пользователей.*/
SELECT  SUM(likes)
	FROM(SELECT COUNT(*) AS likes
			FROM likes, profiles
			WHERE likes.user_id = profiles.user_id
			ORDER BY profiles.birthday DESC 
			LIMIT 10) AS countlikes;


/*5. Найти 10 пользователей, которые проявляют наименьшую активность в
 использовании социальной сети
(критерии активности необходимо определить самостоятельно).*/
SELECT (SELECT first_name FROM users where id = user_id) name, sum(T.rnk) as rnk
FROM(
	SELECT from_user_id as user_id, COUNT(*) as rnk FROM messages -- Неактивные пользователи мало отправляют сообщения
	GROUP BY from_user_id
	UNION ALL
	SELECT user_id, COUNT(*)  FROM likes -- Неактивные пользователи мало лайкуют
	GROUP BY user_id
	UNION ALL
	SELECT user_id, COUNT(*)  FROM friendship -- И друзей у таких пользователей мало
	GROUP BY user_id
	UNION ALL
	SELECT friend_id, COUNT(*)  FROM friendship 
	GROUP BY friend_id
	UNION ALL
	SELECT user_id, COUNT(*)  FROM communities_users
	GROUP BY user_id
) AS T
GROUP BY name 
ORDER BY rnk
LIMIT 10;