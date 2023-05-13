INSERT INTO genre (name) VALUES ('Rap'), ('Rock'), ('Club');

INSERT INTO executor (alias, name)
VALUES 
('Horus', 'Алексей Спиридонов'),
('Oxxxymiron', 'Мирон Фёдоров'),
('Бледный', 'Андрей Позднухов'),
('Ант', 'Антон Завьялов'),
('System of a Down', 'Serj Tankian'),
('Rammstein', 'Till Lindemann'),
('Motionless in White', 'Chris Cerulli'),
('David Guetta', 'David Guetta'),
('Armin van Buuren', 'Armin van Buuren'),
('Tiesto', 'Tijs Michiel Verwest');

INSERT INTO genresexecutors (genre_id, executor_id)
VALUES
(1, 1), (1, 2), (1, 3), (1, 4),
(2, 5), (2, 6), (2, 7),
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
