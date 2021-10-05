/*1.Проанализировать, какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.*/

CREATE INDEX users_first_name_last_name_idx ON users(first_name,last_name);

CREATE INDEX profiles_bithday_idx ON profiles(birthday);

CREATE INDEX messages_from_user_id_to_user_id_created_at_idx ON messages (from_user_id, to_user_id, created_at);
CREATE INDEX messages_to_user_id_from_user_id_created_at_idx ON messages (to_user_id, from_user_id, created_at);

CREATE INDEX friendship_user_id_friend_id_idx ON friendship (user_id, friend_id);
CREATE INDEX friendship_friend_id_user_id_idx ON friendship (friend_id, user_id);


/*2 Задание на оконные функции
Построить запрос, который будет выводить следующие столбцы:
* имя группы
* среднее количество пользователей в группах
* самый молодой пользователь в группе
* самый старший пользователь в группе
* общее количество пользователей в группе
* всего пользователей в системе
* отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100*/

SELECT DISTINCT communities.id, communities.name,
  (SELECT count(*) FROM communities) as averag_users,
  FIRST_VALUE(communities_users.user_id) OVER w1 as min_old,
  FIRST_VALUE(communities_users.user_id) OVER w2 as max_old,
  COUNT(communities_users.user_id) OVER w3 as in_communities,
  (SELECT count(*) FROM users) as users_total,  
  (COUNT(communities_users.user_id) OVER w3 / (SELECT count(*) FROM users)*100) as '%%'
FROM communities_users
	JOIN communities ON (communities.id = communities_users.community_id)
	JOIN users ON (users.id = communities_users.user_id)
	JOIN profiles ON (communities_users.user_id=profiles.user_id)
WINDOW w1 AS (PARTITION BY communities_users.community_id ORDER BY profiles.birthday DESC),
       w2 AS (PARTITION BY communities_users.community_id ORDER BY profiles.birthday),
       w3 AS (PARTITION BY communities_users.community_id)
ORDER by id
;