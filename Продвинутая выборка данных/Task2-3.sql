INSERT INTO genre (name) VALUES ('Rock'), ('Rap'), ('Club');

INSERT INTO executor (alias, name, genre)
VALUES 
('Horus', 'Алексей Спиридонов', 'Rap'),
('Oxxxymiron', 'Мирон Фёдоров', 'Rap'),
('Бледный', 'Андрей Позднухов', 'Rap'),
('Ант', 'Антон Завьялов', 'rap'),
('System of a Down', 'Serj Tankian', 'Rock'),
('Rammstein', 'Till Lindemann', 'Rock'),
('Motionless in White', 'Chris Cerulli', 'Rock'),
('David Guetta', 'David Guetta', 'Club'),
('Armin van Buuren', 'Armin van Buuren', 'Club'),
('Tiesto', 'Tijs Michiel Verwest', 'Club');

INSERT INTO genresexecutors (genre_id, executor_id)
VALUES
(1, 5), (1, 6), (1, 7),
(2, 1), (2, 2), (2, 3), (2, 4),
(3, 8), (3, 9), (3, 10);

INSERT INTO album (album_name, release_date, rate)
VALUES
('Роспечаль', '2014-02-15', 5),
('Прометей роняет факел', '2018-04-19', 4),
('Рифмономикон', '2019-09-20', 4),
('Горгород', '2015-11-13', 5),
('Русский подорожник', '2014-09-13', 5),
('Ева Едет В Вавилон', '2017-09-14', 4),
('Байки из склепа', '2020-12-15', 4),
('Toxicity', '2001-09-04', 5),
('Mutter', '2001-04-02', 5),
('Rammstein', '2019-05-17', 5),
('Disguise', '2019-06-07', 4),
('Listen', '2014-11-21', 5),
('Intense', '2013-05-03', 5),
('Imagine', '2008-04-19', 5),
('Kaleidoscope', '2009-10-06', 5);

INSERT INTO executorsalbums (executor_id, album_id)
VALUES
(1, 1), (1, 2), (1, 3),
(2, 4),
(3, 5), (3, 6), (3, 7),  -- 3 и 4 исполнители из одной группы
(4, 5), (4, 6), (4, 7),
(5, 8),
(6, 9), (6, 10),
(7, 11),
(8, 12),
(9, 13), (9, 14),
(10, 15);

INSERT INTO track (track_name, duration)
VALUES
('У моей мечты', 211),
('Земля мёртвых', 175),
('Час сов', 210),
('Накануне', 222),
('Девятибально', 205),
('Моряк', 242),
('Фонтан', 175),
('Toxicity', 216),
('Ich will', 217),
('Deutschland', 323),
('Legacy', 214),
('Lovers On The Sun', 203),
('Intense', 527),
('In and Out of Love', 361),
('I Will Be Here', 206),
('Рифмономикон', 144);


SELECT * FROM track;

INSERT INTO collection (name, release_year)
VALUES
('Это рэпчик, детка!', 2021),
('Вдарим рок в этой дыре!', 2020),
('Колбасный цех', 2019),
('Сборная солянки', 2022);

INSERT INTO trackscollections (track_id, collection_id)
VALUES
(2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1),
(9, 2), (10, 2), (11, 2),
(13, 3), (14, 3), (15, 3),
(1, 4), (8, 4), (12, 4);

SELECT track_name, duration 
FROM track
WHERE duration = (SELECT MAX(duration) FROM track);

SELECT track_name
FROM track
WHERE duration >= 210;

SELECT name
FROM collection
WHERE release_year BETWEEN 2018 AND 2020;

SELECT alias
FROM executor
WHERE alias NOT LIKE '% %';

INSERT INTO track (track_name, duration)
VALUES
('Enemy', 214),
('Дом мой', 235);  -- для теста следующей выборки

SELECT track_name
FROM track
WHERE track_name LIKE 'My %' OR track_name LIKE 'Мой %' 
OR LOWER(track_name) LIKE '% my' OR LOWER(track_name) LIKE '% мой'
OR LOWER(track_name) LIKE '% my %' OR LOWER(track_name) LIKE '% мой %';

DELETE FROM track WHERE track_name IN ('Enemy', 'Дом мой');  -- кроме теста эти песни не были нужны

SELECT g.name, COUNT(*)
FROM genresexecutors ge, genre g, executor e
WHERE ge.genre_id = g.id AND ge.executor_id = e.id
GROUP BY g.name;

SELECT COUNT(*)
FROM track, album
WHERE album_id = album.id 
AND album.id IN (SELECT id FROM album 
WHERE EXTRACT(YEAR FROM release_date) BETWEEN 2019 AND 2020
);

SELECT album_name, AVG(duration)
FROM track
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
SELECT alias
FROM executor
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
SELECT collection.name
FROM collection
WHERE name IN
(
SELECT c.name
FROM trackscollections
JOIN track t ON t.id = track_id
JOIN collection c ON c.id = collection_id
JOIN album a ON a.id = t.album_id
JOIN executorsalbums ea ON ea.album_id = a.id
JOIN executor e ON ea.executor_id = e.id
WHERE alias = 'Horus'
);

