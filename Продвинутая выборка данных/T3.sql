SELECT track_name, duration FROM track
WHERE duration = (SELECT MAX(duration) FROM track);

SELECT track_name FROM track
WHERE duration >= 210;

SELECT name FROM collection
WHERE release_year BETWEEN 2018 AND 2020;

SELECT alias FROM executor
WHERE alias NOT LIKE '% %';

INSERT INTO track (track_name, duration)
VALUES
('Enemy', 214),
('Дом мой', 235);  -- для теста следующей выборки

SELECT track_name FROM track
WHERE track_name LIKE 'My %' OR track_name LIKE 'Мой %' 
OR LOWER(track_name) LIKE '% my' OR LOWER(track_name) LIKE '% мой'
OR LOWER(track_name) LIKE '% my %' OR LOWER(track_name) LIKE '% мой %'
OR LOWER(track_name) LIKE 'My' OR track_name LIKE 'Мой';

DELETE FROM track WHERE track_name IN ('Enemy', 'Дом мой');  -- кроме теста эти песни не были нужны

SELECT g.name, COUNT(*) FROM genresexecutors ge, genre g, executor e
WHERE ge.genre_id = g.id AND ge.executor_id = e.id
GROUP BY g.name;

SELECT COUNT(*) FROM track, album
WHERE album_id = album.id 
AND album.id IN 
(SELECT id FROM album 
WHERE EXTRACT(YEAR FROM release_date) BETWEEN 2019 AND 2020);

SELECT album_name, AVG(duration) FROM track
JOIN album ON album.id = album_id
GROUP BY album_name;
-- в альбоме "Рифмономикон" 2 песни, в остальных по одной. Средняя длина высчитывается корректно

SELECT alias FROM executor
WHERE id NOT IN 
(
SELECT executor_id
FROM executorsalbums
JOIN album ON album.id = album_id
JOIN executor ON executor_id = executor.id
WHERE EXTRACT (YEAR FROM release_date) = 2020
);

SELECT DISTINCT c.name FROM collection c
JOIN trackscollections tc ON tc.collection_id = c.id
JOIN track t ON t.id = tc.track_id
JOIN executorsalbums ea ON ea.album_id = t.album_id
JOIN executor e ON e.id = ea.executor_id
WHERE e.alias = 'Horus';