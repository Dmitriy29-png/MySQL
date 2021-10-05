DESC profiles;
SELECT * FROM profiles LIMIT 10;
UPDATE profiles SET status = NULL;
SELECT * FROM user_statuses;
INSERT INTO user_statuses (name) VALUES ('single'),('married');
ALTER TABLE profiles RENAME COLUMN status TO status_id;
ALTER TABLE profiles   MODIFY COLUMN status_id INT unsigned;

CREATE TABLE user_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

SELECT * FROM users;
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at ;

DESC profiles;
SELECT * FROM profiles;
UPDATE  profiles SET photo_id = 1+FLOOR(RAND()*100);
UPDATE profiles SET city = NULL;
ALTER TABLE profiles RENAME COLUMN city TO city_id;
ALTER TABLE profiles MODIFY COLUMN city_id INT unsigned;
UPDATE profiles  SET city_id =  1+FLOOR(RAND()*100);

UPDATE profiles SET country = NULL;
ALTER TABLE profiles RENAME COLUMN country TO country_id;
ALTER TABLE profiles MODIFY COLUMN country_id INT unsigned;
UPDATE profiles  SET country_id = 1+FLOOR(RAND()*100);

CREATE  TEMPORARY TABLE genders (name CHAR(1));
INSERT INTO genders VALUES ('m'),('f');
SELECT * FROM genders;
SELECT *FROM genders ORDER BY RAND() LIMIT 1;

UPDATE profiles SET gender = ( SELECT *FROM genders ORDER BY RAND() LIMIT 1 );
UPDATE profiles  SET status_id =  1+FLOOR(RAND()*2);

SELECT * FROM messages;
UPDATE messages SET updated_at = NOW() WHERE updated_at < created_at ;
UPDATE messages  SET 
    from_user_id = 1+FLOOR(RAND()*100),
    to_user_id = 1+FLOOR(RAND()*100);

SELECT * FROM media_types;
TRUNCATE media_types ;
INSERT INTO media_types (name) VALUES ('video'),('audio'),('images');

SELECT * FROM media;
UPDATE media SET media_type_id = 1+FLOOR(RAND()*3);
UPDATE media SET user_id = 1+FLOOR(RAND()*100);
CREATE  TEMPORARY TABLE extensions (name CHAR(3));
INSERT INTO extensions (name) VALUES ('mp3'),('avi'),('mov'),('mpg');
SELECT * FROM extensions;
SELECT * FROM  extensions ORDER BY RAND() LIMIT 1;
UPDATE media SET filename = CONCAT(
	'https://dropbox.com/vk/',
	filename,
	'.',
	(SELECT * FROM  extensions ORDER BY RAND() LIMIT 1)
);
UPDATE media SET size = 100000+FLOOR(RAND()*10000000) WHERE size < 99999;
UPDATE media SET metadata = CONCAT(
	'{"owner":"',
	(SELECT CONCAT(first_name,' ', last_name) FROM users WHERE id = user_id),
	'"}');
ALTER TABLE media  MODIFY COLUMN metadata JSON;

SELECT *FROM friendship_statuses;
TRUNCATE friendship_statuses ;
INSERT INTO friendship_statuses (name) VALUES ('sent'),('accepted'),('rejected'),('cancelled');

SELECT *FROM friendship;
UPDATE friendship SET status_id = 1+FLOOR(RAND()*4);
UPDATE friendship  SET 
    friend_id = 1+FLOOR(RAND()*100),
    user_id = 1+FLOOR(RAND()*100);
UPDATE friendship SET confirmed_at = NOW() WHERE confirmed_at < requested_at ;

SELECT * FROM communities;
DELETE FROM communities WHERE id > 30;
UPDATE communities SET updated_at = NOW() WHERE updated_at < created_at ;

SELECT * FROM communities_users;
UPDATE communities_users  SET 
    community_id = 1+FLOOR(RAND()*29),
    user_id = 1+FLOOR(RAND()*100);
   
SELECT * FROM city;
UPDATE city SET updated_at = NOW() WHERE updated_at < created_at ;

SELECT * FROM country;
UPDATE country SET updated_at = NOW() WHERE updated_at < created_at ;

SELECT * FROM photo_album;
UPDATE photo_album SET user_id = 1+FLOOR(RAND()*100);
UPDATE photo_album SET updated_at = NOW() WHERE updated_at < created_at ;

SELECT * FROM photo;
UPDATE photo SET updated_at = NOW() WHERE updated_at < created_at ;
UPDATE photo  SET 
    album_id = 1+FLOOR(RAND()*100),
    media_id = 1+FLOOR(RAND()*100);
   
SELECT * FROM likes;
UPDATE likes SET updated_at = NOW() WHERE updated_at < created_at ;
UPDATE likes  SET 
    user_id = 1+FLOOR(RAND()*100),
    media_id = 1+FLOOR(RAND()*100);

   
SELECT * FROM posts;
UPDATE posts SET updated_at = NOW() WHERE updated_at < created_at ;
UPDATE posts  SET 
    user_id = 1+FLOOR(RAND()*100),
    likes_id = 1+FLOOR(RAND()*100);
