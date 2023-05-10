CREATE TABLE IF NOT EXISTS Genre (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS Executor (
	id SERIAL PRIMARY KEY,
	alias VARCHAR(30) DEFAULT 'unknown',
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS GenresExecutors (
	genre_id INTEGER REFERENCES Genre(id),
	executor_id INTEGER REFERENCES Executor(id),
	CONSTRAINT genre_executor PRIMARY KEY (genre_id, executor_id)
);

CREATE TABLE IF NOT EXISTS Album (
	id SERIAL PRIMARY KEY,
	album_name VARCHAR(60) DEFAULT 'unknown_album',
	release_date DATE,
	CHECK (EXTRACT(YEAR FROM release_date) BETWEEN 1970 AND 2023),
	rate INTEGER,
	CHECK (rate BETWEEN 0 AND 5)
);

CREATE TABLE IF NOT EXISTS ExecutorsAlbums (
 	executor_id INTEGER REFERENCES Executor(id),
 	album_id INTEGER REFERENCES Album(id),
 	CONSTRAINT exec_album PRIMARY KEY (executor_id, album_id)
);

CREATE TABLE IF NOT EXISTS Track (
	id SERIAL PRIMARY KEY,
	album_id INTEGER REFERENCES Album(id),
	track_name VARCHAR(60) NOT NULL,
	duration INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Collection (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	release_year INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS TracksCollections (
	track_id INTEGER REFERENCES Track(id),
	collection_id INTEGER REFERENCES Collection(id),
	CONSTRAINT track_coll PRIMARY KEY (track_id, collection_id)
);
