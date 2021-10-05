ALTER TABLE profiles 
	ADD CONSTRAINT profiles_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT profiles_photo_id_fk
	FOREIGN KEY (photo_id) REFERENCES photo(id)
	ON DELETE SET NULL,
	ADD CONSTRAINT profiles_status_id_fk
	foreign key(status_id) references user_statuses(id)
	ON DELETE SET NULL,
	ADD CONSTRAINT profiles_city_id_fk
	FOREIGN KEY (city_id) REFERENCES city(id)
	ON DELETE SET NULL,
	ADD CONSTRAINT profiles_country_id_fk
	FOREIGN KEY (country_id) REFERENCES country(id)
	ON DELETE SET NULL
;

ALTER TABLE photo_album 
	ADD CONSTRAINT photo_album_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON DELETE CASCADE
;

ALTER TABLE photo 
	ADD CONSTRAINT photo_photo_album_id_fk
	FOREIGN KEY (album_id) REFERENCES photo_album(id)
	ON DELETE CASCADE, 
	ADD CONSTRAINT photo_media_id_fk
	FOREIGN KEY (media_id) REFERENCES media(id)
	ON DELETE CASCADE
;
ALTER TABLE media
	ADD CONSTRAINT media_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON DELETE CASCADE, 
	ADD CONSTRAINT media_media_type_id_fk
	FOREIGN KEY (media_type_id) REFERENCES media_types(id)
	ON DELETE CASCADE
;
ALTER TABLE messages 
	ADD CONSTRAINT messager_from_user_id_fk
	FOREIGN KEY (from_user_id) REFERENCES users(id)
	ON DELETE CASCADE, 
	ADD CONSTRAINT messager_to_user_id_fk
	FOREIGN KEY (to_user_id) REFERENCES users(id)
	ON DELETE CASCADE
;
ALTER TABLE friendship 
	ADD CONSTRAINT friendship_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON DELETE CASCADE, 
	ADD CONSTRAINT friendship_friend_id_fk
	FOREIGN KEY (friend_id) REFERENCES users(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT friendship_friendship_statuses_id_fk
	FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
	ON DELETE CASCADE
;
ALTER TABLE communities_users 
	ADD CONSTRAINT communities_users_community_id_fk
	FOREIGN KEY (community_id) REFERENCES communities(id)
	ON DELETE CASCADE, 
	ADD CONSTRAINT communities_users_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON DELETE CASCADE
;
ALTER TABLE posts 
	ADD CONSTRAINT posts_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT posts_community_id_fk
	FOREIGN KEY (community_id) REFERENCES communities(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT posts_media_id_fk
	FOREIGN KEY (media_id) REFERENCES media(id)
	ON DELETE SET NULL 
;
ALTER TABLE likes 
	ADD CONSTRAINT likes_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT likes_targer_id_posts_fk
	FOREIGN KEY (targer_id) REFERENCES posts(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT likes_targer_id_messages_fk
	FOREIGN KEY (targer_id) REFERENCES messages(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT likes_targer_id_users_fk
	FOREIGN KEY (targer_id) REFERENCES users(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT likes_targer_id_media_fk
	FOREIGN KEY (targer_id) REFERENCES media(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT likes_target_types_id_fk
	FOREIGN KEY (target_types_id) REFERENCES target_types(id)
	ON DELETE CASCADE
; 