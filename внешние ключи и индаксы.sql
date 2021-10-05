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
	ADD CONSTRAINT profiles_location_id_fk
	FOREIGN KEY (location_id) REFERENCES location(id)
	ON DELETE SET NULL,
	ADD CONSTRAINT profiles_religion_id_fk
	FOREIGN KEY (religion_id) REFERENCES religion(id)
	ON DELETE SET NULL,
	ADD CONSTRAINT profiles_shool_id_fk
	FOREIGN KEY (shool_id) REFERENCES shool(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT profiles_university_id_fk
	FOREIGN KEY (university_id) REFERENCES university(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT profiles_work_place_id_fk
	FOREIGN KEY (work_place_id) REFERENCES work_place(id)
	ON DELETE CASCADE
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
	ADD CONSTRAINT likes_target_types_id_fk
	FOREIGN KEY (target_types_id) REFERENCES target_types(id)
	ON DELETE CASCADE
; 
ALTER TABLE location 
	ADD CONSTRAINT location_city_id_fk
	FOREIGN KEY (city_id) REFERENCES city(id)
	ON DELETE CASCADE, 
	ADD CONSTRAINT location_country_id_fk
	FOREIGN KEY (country_id) REFERENCES country(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT location_street_id_fk
	FOREIGN KEY (street_id) REFERENCES street(id)
	ON DELETE CASCADE
;
ALTER TABLE event 
	ADD CONSTRAINT event_creator_id_fk
	FOREIGN KEY (creator_id) REFERENCES users(id)
	ON DELETE CASCADE, 
	ADD CONSTRAINT event_event_sub_type_id_fk
	FOREIGN KEY (event_sub_type_id) REFERENCES event_sub_type(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT event_eventype_id_fk
	FOREIGN KEY (eventype_id) REFERENCES eventype(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT event_location_id_fk
	FOREIGN KEY (location_id) REFERENCES location(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT event_event_status_id_fk
	FOREIGN KEY (event_status_id) REFERENCES event_statuses(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT event_medium_photo_id_fk
	FOREIGN KEY (medium_photo_id) REFERENCES photo(id)
	ON DELETE CASCADE,
	ADD CONSTRAINT event_large_photo_id_fk
	FOREIGN KEY (large_photo_id) REFERENCES photo(id)
	ON DELETE CASCADE
;
ALTER TABLE event_users 
	ADD CONSTRAINT event_users_event_id_fk
	FOREIGN KEY (event_id) REFERENCES event(id)
	ON DELETE CASCADE, 
	ADD CONSTRAINT event_users_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON DELETE CASCADE
;