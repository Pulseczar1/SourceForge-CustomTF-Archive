DROP DATABASE IF EXISTS cplog;
CREATE DATABASE cplog;
USE cplog;

-- instead, weapons are given constant IDs in game.
--CREATE TABLE IF NOT EXISTS t_weapons(
--	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
--	name VARCHAR(32) NOT NULL UNIQUE
--);

CREATE TABLE IF NOT EXISTS t_maps(
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS t_games(
	id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	mapid SMALLINT UNSIGNED NOT NULL,
	playdate INTEGER UNSIGNED NOT NULL,

	KEY(mapid)
);

CREATE TABLE IF NOT EXISTS t_players(
	id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS t_frags(
	id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,

	gameid MEDIUMINT UNSIGNED NOT NULL,

	attackerid MEDIUMINT UNSIGNED NOT NULL,
	attackerflags SMALLINT UNSIGNED NOT NULL,
	attackerspeed SMALLINT UNSIGNED NOT NULL,

	victimid MEDIUMINT UNSIGNED NOT NULL,
	victimflags SMALLINT UNSIGNED NOT NULL,
	victimspeed SMALLINT UNSIGNED NOT NULL,

	speed SMALLINT UNSIGNED NOT NULL,
	distance SMALLINT UNSIGNED NOT NULL,
	weapon TINYINT UNSIGNED NOT NULL,

	score TINYINT UNSIGNED NOT NULL DEFAULT 0, -- scaled score

	KEY(gameid),
	KEY(attackerid,victimid), -- used as attackerid key also.
	KEY(victimid),
	KEY(weapon)
);