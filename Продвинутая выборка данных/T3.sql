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
OR LOWER(track_name) LIKE '% my %' OR LOWER(track_name) LIKE '% мой %';

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

-- первый раз мне удалось решить этот запрос через три запроса: изобрёл колесо, но собрал его из костылей :)
-- 1) нашел альбомы с конкретным годом релиза
-- 2) выбрал псевдонимы исполнителей, альбомы которых находятся в выборке ниже
-- 3) исключил эти псевдонимы из общего списка псевдонимов
-- 4) и выбрал оставшиеся псевдонимы
SELECT DISTINCT alias   -- 4
FROM executor
EXCEPT  				-- 3
SELECT DISTINCT alias   -- 2
FROM executorsalbums e, executor, album
WHERE e.executor_id = executor.id AND e.album_id = album.id
AND album_name IN
(SELECT DISTINCT album_name FROM album  -- 1
WHERE EXTRACT (YEAR FROM album.release_date) = 2020);

-- то же задание, но уже чуть проще исполненно, по-моему...
SELECT alias FROM executor
WHERE id NOT IN 
(
SELECT executor_id
FROM executorsalbums
JOIN album ON album.id = album_id
JOIN executor ON executor_id = executor.id
WHERE EXTRACT (YEAR FROM release_date) = 2020
);

-- стойкое ощущение, что столько джойнов - не есть хорошо. Но у executor и collection ведь нет связок ¯\_(ツ)_/¯
-- да и сдаётся мне, что джойны быстрее кучи вложенных запросов, хотя и памятизатратны
SELECT collection.name FROM collection
WHERE name IN
(
SELECT c.name FROM trackscollections
JOIN track t ON t.id = track_id
JOIN collection c ON c.id = collection_id
JOIN album a ON a.id = t.album_id
JOIN executorsalbums ea ON ea.album_id = a.id
JOIN executor e ON ea.executor_id = e.id
WHERE alias = 'Horus'
);