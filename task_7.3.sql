DROP DATABASE IF EXISTS airlogs;
CREATE DATABASE airlogs;


CREATE TABLE cities (
	label VARCHAR(100) PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);
INSERT INTO cities(label, name)
VALUE ('moscow','Москва'),('irkutsk','Иркутск'),
	  ('novgorod','Новгород'),('kazan','Казань'),
	  ('omsk','Омск'),('orsk','Орск');

CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	`from` VARCHAR(100) NOT NULL,
	`to` VARCHAR(100) NOT NULL
);


ALTER TABLE flights
	ADD CONSTRAINT flights_from_fk
	FOREIGN KEY (`from`) REFERENCES cities (label)
	ON DELETE CASCADE;

ALTER TABLE flights
	ADD CONSTRAINT flights_to_fk
	FOREIGN KEY (`to`) REFERENCES cities (label)
	ON DELETE CASCADE;



INSERT INTO flights(`from`, `to`)
VALUE ('moscow','omsk'),('irkutsk','kazan'),
	  ('irkutsk','moscow'),('omsk','irkutsk'),
	  ('moscow','kazan'),('orsk','moscow');



SELECT
	id AS flight_id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM
	flights
ORDER BY
	flight_id;
	