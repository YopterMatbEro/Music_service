CREATE TABLE IF NOT EXISTS Genre (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS Executor (
	id SERIAL PRIMARY KEY,
	alias VARCHAR(30) NOT NULL,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS GenresExecutors (
	genre_id INTEGER REFERENCES Genre(id),
	executor_id INTEGER REFERENCES Executor(id),
	CONSTRAINT pk PRIMARY KEY (genre_id, executor_id)
);

CREATE TABLE IF NOT EXISTS Track (
	id SERIAL PRIMARY KEY,
	track_name VARCHAR(60) NOT NULL,
	duration TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS Album (
	id SERIAL PRIMARY KEY,
	track_id INTEGER REFERENCES Track(id),
	album_name VARCHAR(60) NOT NULL,
	release_date DATE NOT NULL,
	cover JSONB NOT NULL, 
	-- hz как добавить обложку, пробежавшись по типам, подумал, что можно через url json
	rate INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS ExecutorsAlbums (
 	executor_id INTEGER REFERENCES Executor(id),
 	album_id INTEGER REFERENCES Album(id),
 	CONSTRAINT exec_album PRIMARY KEY (executor_id, album_id)
);

CREATE TABLE IF NOT EXISTS Collection (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	release_year DATE NOT NULL,
	album_id INTEGER REFERENCES Album(id),
	track_id INTEGER REFERENCES Track(id),
	CONSTRAINT coll PRIMARY KEY (album_id, track_id)
);
