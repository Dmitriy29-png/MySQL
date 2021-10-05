
SELECT * FROM user_statuses;
TRUNCATE user_statuses ;
INSERT INTO user_statuses (name) VALUES ('single'),('married');

SELECT * FROM users;
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at ;

DESC profiles;
SELECT * FROM profiles;
UPDATE  profiles SET photo_id = 1+FLOOR(RAND()*100);
UPDATE profiles  SET status_id =  1+FLOOR(RAND()*2);
UPDATE profiles  SET location_id = 1+FLOOR(RAND()*100);
UPDATE profiles  SET religion_id = 1+FLOOR(RAND()*100);
UPDATE profiles  SET shool_id = 1+FLOOR(RAND()*100);
UPDATE profiles  SET university_id = 1+FLOOR(RAND()*100);
UPDATE profiles  SET work_place_id = 1+FLOOR(RAND()*100);
UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at ;


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
	'https://dropbox.com/fb/',
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
    community_id = 1+FLOOR(RAND()*30),
    user_id = 1+FLOOR(RAND()*100);
   
SELECT * FROM city;
UPDATE city SET updated_at = NOW() WHERE updated_at < created_at ;

SELECT * FROM country;
UPDATE country SET updated_at = NOW() WHERE updated_at < created_at ;

SELECT * FROM street;
UPDATE street SET updated_at = NOW() WHERE updated_at < created_at ;

SELECT * FROM location;
UPDATE location SET city_id = 1+FLOOR(RAND()*100);
UPDATE location SET country_id = 1+FLOOR(RAND()*100);
UPDATE location SET street_id = 1+FLOOR(RAND()*100);
UPDATE location SET updated_at = NOW() WHERE updated_at < created_at ;

SELECT * FROM religion;
TRUNCATE religion ;
INSERT INTO religion (name) VALUES 
							('Zoroastrianism'),('Hinduism'),('Ancient Egyptian religion'),('Judaism'),
							('Christianity'),('Islam'),('Sikhism'),('Buddhism'),
							('Shintoism'),('Taoism'),('Confucianism'),('Slavic paganism');
						
SELECT * FROM shool;
UPDATE shool SET graduation_year = NOW() WHERE graduation_year < start_year ;
UPDATE shool SET updated_at = NOW() WHERE updated_at < created_at ;

						
SELECT * FROM university;
UPDATE university SET graduation_year = NOW() WHERE graduation_year < start_year;
UPDATE university SET updated_at = NOW() WHERE updated_at < created_at ;

SELECT * FROM work_place;
UPDATE work_place SET end_date = NOW() WHERE end_date < start_date ;
UPDATE work_place SET updated_at = NOW() WHERE updated_at < created_at ;

SELECT * FROM photo_album;
UPDATE photo_album SET user_id = 1+FLOOR(RAND()*100);
UPDATE photo_album SET updated_at = NOW() WHERE updated_at < created_at ;

SELECT * FROM photo;
ALTER TABLE photo ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP AFTER media_id;
ALTER TABLE photo ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP AFTER created_at;
UPDATE photo SET updated_at = NOW() WHERE updated_at < created_at ;
UPDATE photo  SET 
    album_id = 1+FLOOR(RAND()*100),
    media_id = 1+FLOOR(RAND()*100);
   
SELECT * FROM likes;
INSERT INTO likes
	SELECT
	  id,
	  FLOOR(1+(RAND()*100)),
	  FLOOR(1+(RAND()*100)),
	  FLOOR(1+(RAND()*4)),
	  CURRENT_TIMESTAMP
	FROM messages;

SELECT * FROM target_types;
INSERT INTO target_types (name) VALUES
	('messages'),
	('users'),
	('media'),
	('posts');
   
SELECT * FROM posts;
UPDATE posts SET updated_at = NOW() WHERE updated_at < created_at ;
UPDATE posts  SET 
    user_id = 1+FLOOR(RAND()*100),
    community_id = 1+FLOOR(RAND()*30),
    media_id = 1+FLOOR(RAND()*100);

SELECT * FROM event;
UPDATE event SET updated_at = NOW() WHERE updated_at < created_at ;
UPDATE event SET end_time = NOW() WHERE end_time < start_time ;
UPDATE event SET 
    creator_id = 1+FLOOR(RAND()*100),
    event_sub_type_id = 1+FLOOR(RAND()*2),
    eventype_id = 1+FLOOR(RAND()*21),
    location_id = 1+FLOOR(RAND()*100),
    event_status_id = 1+FLOOR(RAND()*4),
    medium_photo_id = 1+FLOOR(RAND()*100),
    large_photo_id = 1+FLOOR(RAND()*100);  
    
   
SELECT * FROM eventype;
TRUNCATE eventype ;
INSERT INTO eventype (name) VALUES 
							('games'),('initiatives'),('art'),('literature'),
							('music'),('networking'),('humor'),('fitness'),
							('film'),('theatre'),('dancing'),('sport'),
							('gardening'),('craft'),('religion'),('purchases'),
							('beverages'),('party'),('house'),('food'),
							('health');
						
SELECT * FROM event_sub_type;
TRUNCATE event_sub_type ;
INSERT INTO event_sub_type (name) VALUES 
							('online'),('personally');
						
SELECT * FROM event_statuses;
TRUNCATE event_statuses ;
INSERT INTO event_statuses (name) VALUES 
							('I will go'),('possibly'),('reject'),('interested');
						