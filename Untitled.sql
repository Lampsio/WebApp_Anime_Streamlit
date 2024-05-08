CREATE TABLE Anime (
  id SERIAL PRIMARY KEY,
  tytul varchar(50) NOT NULL,
  opis varchar(600) NOT NULL,
  liczba_odcinkow integer NOT NULL,
  typ varchar NOT NULL,
  data_premiery date NOT NULL,
  url_strony varchar,
  tworca_id integer NOT NULL,
  gatunek_id integer NOT NULL,
  ocena DECIMAL(3,2) NOT NULL
);

CREATE TABLE odcinek (
  id SERIAL PRIMARY KEY,
  nr_odcinka integer NOT NULL,
  tytul varchar(100) NOT NULL,
  opis varchar NOT NULL,
  data_premiery date NOT NULL,
  dlugosc_odcinka integer NOT NULL,
  anime_id integer,
  ocena DECIMAL(3,2) NOT NULL
);

CREATE TABLE gatunek (
  id SERIAL PRIMARY KEY,
  tytul varchar(60) NOT NULL,
  opis varchar NOT NULL
);

CREATE TABLE studio (
  id SERIAL PRIMARY KEY,
  nazwa varchar(60) NOT NULL,
  opis varchar NOT NULL,
  kraj varchar(60) NOT NULL,
  rok_zalozenia int
);

CREATE TABLE tworca (
  id SERIAL PRIMARY KEY,
  imie varchar(60) NOT NULL,
  nazwisko varchar(60) NOT NULL,
  rola varchar(50) NOT NULL,
  data_urodzenia date,
  biografia varchar
);

CREATE TABLE postac (
  id SERIAL PRIMARY KEY,
  imie varchar(60) NOT NULL,
  nazwisko varchar(60) NOT NULL,
  plec varchar NOT NULL,
  url_zdjecie varchar,
  gatunek varchar NOT NULL,
  anime_id integer NOT NULL,
  aktor_id integer NOT NULL
);

CREATE TABLE aktor (
  id SERIAL PRIMARY KEY,
  imie varchar(60) NOT NULL,
  nazwisko varchar(60) NOT NULL,
  kraj varchar(60) NOT NULL,
  rok_urodzenia date,
  biografia varchar
);

ALTER TABLE odcinek ADD FOREIGN KEY (anime_id) REFERENCES Anime (id) ON DELETE SET NULL;

ALTER TABLE Anime ADD FOREIGN KEY (gatunek_id) REFERENCES Gatunek (id) ON DELETE SET NULL;

CREATE TABLE studio_anime (
  id SERIAL PRIMARY KEY,
  studio_id integer,
  anime_studio_id integer
);

ALTER TABLE studio_anime ADD FOREIGN KEY (studio_id) REFERENCES studio (id) ON DELETE SET NULL;

ALTER TABLE studio_anime ADD FOREIGN KEY (anime_studio_id) REFERENCES anime (id) ON DELETE SET NULL;

ALTER TABLE anime ADD FOREIGN KEY (tworca_id) REFERENCES tworca (id) ON DELETE SET NULL;

ALTER TABLE postac ADD FOREIGN KEY (anime_id) REFERENCES anime (id) ON DELETE SET NULL;

ALTER TABLE postac ADD FOREIGN KEY (aktor_id) REFERENCES aktor (id) ON DELETE SET NULL;

CREATE TABLE postac_odcinek (
  id SERIAL PRIMARY KEY,
  postac_odcinek_id integer,
  odcinek_id integer
);

ALTER TABLE postac_odcinek ADD FOREIGN KEY (postac_odcinek_id) REFERENCES postac (id) ON DELETE SET NULL;

INSERT INTO Gatunek (tytul, opis)
VALUES
('Shounen', 'Gatunek anime skierowany do młodej męskiej publiczności. Charakteryzuje się dużą ilością akcji, humoru i przygód.'),
('Seinen', 'Gatunek anime skierowany do dojrzałej męskiej publiczności. Często porusza poważniejsze tematy i zawiera więcej elementów psychologicznych.'),
('Shoujo', 'Gatunek anime skierowany do młodej żeńskiej publiczności. Charakteryzuje się dużą ilością romansu, dramatu i komedii.'),
('Josei', 'Gatunek anime skierowany do dojrzałej żeńskiej publiczności. Często porusza problemy życia codziennego i relacji międzyludzkich.'),
('Mecha', 'Gatunek anime skupiający się na gigantycznych robotach i walkach z nimi.'),
('Sci-fi', 'Gatunek anime oparty na elementach science fiction.'),
('Fantasy', 'Gatunek anime osadzony w świecie fantasy.'),
('Horror', 'Gatunek anime mający na celu przestraszenie widza.'),
('Comedy', 'Gatunek anime mający na celu rozśmieszenie widza.'),
('Slice of Life', 'Gatunek anime skupiający się na codziennym życiu bohaterów.'),
('Drama', 'Gatunek anime poruszający poważne i emocjonalne tematy.'),
('Romance', 'Gatunek anime skupiający się na relacjach romantycznych między bohaterami.'),
('Action', 'Gatunek anime skupiający się na scenach akcji i walki.'),
('Thriller', 'Gatunek anime mający na celu wzbudzić napięcie i dreszczyk emocji.'),
('Mystery', 'Gatunek anime skupiający się na rozwiązywaniu tajemnic.'),
('Music', 'Gatunek anime skupiający się na muzyce.'),
('Sports', 'Gatunek anime skupiający się na sporcie.'),
('Psychological', 'Gatunek anime skupiający się na psychologii bohaterów.'),
('Supernatural', 'Gatunek anime oparty na elementach nadprzyrodzonych.'),
('Historical', 'Gatunek anime osadzony w realiach historycznych.');

INSERT INTO Studio (nazwa, opis, kraj, rok_zalozenia)
VALUES
('MAPPA', 'Studio animacji założone w 2011 roku w Japonii. Znane z takich anime jak Jujutsu Kaisen, Attack on Titan i Chainsaw Man.', 'Japonia', 2011),
('Madhouse', 'Studio animacji założone w 1972 roku w Japonii. Znane z takich anime jak Death Note, One Punch Man i Hunter x Hunter.', 'Japonia', 1972),
('Gainax', 'Studio animacji założone w 1984 roku w Japonii. Znane z takich anime jak Neon Genesis Evangelion, Gurren Lagann i Tengen Toppa Gurren Lagann.', 'Japonia', 1984),
('Sunfire', 'Studio animacji założone w 1976 roku w Japonii. Znane z takich anime jak Cowboy bebop, Gintama.', 'Japonia', 1976),
('Toei Animation', 'Studio animacji założone w 1948 roku w Japonii. Znane z takich anime jak Dragon Ball, One Piece i Sailor Moon.', 'Japonia', 1948),
('Kyoto Animation', 'Studio animacji założone w 1981 roku w Japonii. Znane z takich anime jak Violet Evergarden, K-On! i Clannad.', 'Japonia', 1981),
('White fox', 'Studio animacji założone w 1985 roku w Japonii. Znane z takich filmów jak Stein gate', 'Japonia', 1985),
('Ufotable', 'Studio animacji założone w 2000 roku w Japonii. Znane z takich anime jak Fate/Zero, Demon Slayer: Kimetsu no Yaiba i Kara no Kyoukai.', 'Japonia', 2000),
('Shaft', 'Studio animacji założone w 1975 roku w Japonii. Znane z takich anime jak Puella Magi Madoka Magica, Monogatari Series i Bakemonogatari.', 'Japonia', 1975),
('Pierrot', 'Studio animacji założone w 1998 roku w Japonii. Znane z takich anime jak Fullmetal Alchemist: Brotherhood, My Hero Academia i Soul Eater.', 'Japonia', 1998),
('Trigger', 'Studio animacji założone w 2011 roku w Japonii. Znane z takich anime jak Kill la Kill, Little Witch Academia i Promare.', 'Japonia', 2011);


INSERT INTO tworca (imie, nazwisko, rola, data_urodzenia, biografia)
VALUES
('Gege', 'Akutami', 'Mangaka', '1992-02-05', 'Japoński mangaka, znany przede wszystkim z mangi Jujutsu Kaisen.'),
('Hideaki', 'Anno', 'Reżyser, scenarzysta', '1960-05-22', 'Japoński reżyser, scenarzysta i animator, najbardziej znany z serii Neon Genesis Evangelion.'),
('Tsugumi', 'Ohba', 'Scenarzysta', '1980-10-19', 'Japoński scenarzysta mangi, znany przede wszystkim z serii Death Note.'),
('Shinichirou', 'Watanabe', 'Scenarzysta', '1965-05-24', 'Japoński scenarzysta mangi, znany przede wszystkim z serii Cowboy bebop oraz Death Parade.'),
('Chiyomaru', 'Shikura','Mangaka','1978-03-05', 'https://en.wikipedia.org/wiki/Chiyomaru_Shikura'),
('Tatsuki', 'Fujimoto','Mangaka','1992-06-05', 'https://en.wikipedia.org/wiki/Tatsuki_Fujimoto'),
('Masashi', 'Kishimoto','Mangaka','1992-01-05', 'https://en.wikipedia.org/wiki/Masashi_Kishimoto'),
('Yuuichirou', 'Fukushi', 'Producent', '1980-05-30', 'Japoński scenarzysta mangi, znany przede wszystkim z serii Frieren.');


INSERT INTO Anime (tytul, opis, liczba_odcinkow, typ, data_premiery, url_strony, tworca_id, gatunek_id,ocena)
VALUES ('Jujutsu Kaisen', 'W świecie opanowanym przez Klątwy, licealista Yuji Itadori połyka potężny palec Sukuny Ryoumena, legendarnego Króla Klątw. Teraz sam staje się medium dla Sukuny, jednak zaskakująco udaje mu się zachować kontrolę. Dołącza do Jujutsu Tech, organizacji walczących z Klętwami, by nauczyć się kontrolować moc i w końcu unicestwić wszystkie palce Sukuny.', 24, 'TV serial', '2020-10-02', 'https://jujutsu-kaisen.fandom.com/wiki/Jujutsu_Kaisen', 1, 1,8.90);

INSERT INTO Anime (tytul, opis, liczba_odcinkow, typ, data_premiery, url_strony, tworca_id, gatunek_id,ocena)
VALUES ('Death Note', 'Light Yagami, genialny licealista, znajduje tajemniczy notatnik - Death Note. Zeszyt pozwala zabić każdego, którego imię i nazwisko zostanie w nim zapisane. Light postanawia wykorzystać Death Note, by oczyścić świat ze zbrodniarzy i stworzyć idealne społeczeństwo.', 37, 'TV serial', '2006-10-03', 'https://deathnote.fandom.com/wiki/Death_Note', 2, 2,8.45);

INSERT INTO Anime (tytul, opis, liczba_odcinkow, typ, data_premiery, url_strony, tworca_id, gatunek_id,ocena)
VALUES ('Neon Genesis Evangelion', 'Prowadzona przez organizację Nerv nastolatniowie pilotują gigantyczne biomechaniczne humanoidalne bronie - Evangeliony - by stawić czoła kosmicznym potworom nazywanym Aniołami. Shinji Ikari, niechętny 14-latek, zostaje wybrany na pilota Evangelion Unit-01 i wciągnięty w konflikt o losy ludzkości.', 26, 'TV serial', '1995-10-04', 'https://wiki.evagelion.org/wiki/Neon_Genesis_Evangelion', 3, 3,8.21);

INSERT INTO Anime (tytul, opis, liczba_odcinkow, typ, data_premiery, url_strony, tworca_id, gatunek_id,ocena)
VALUES ('Cowboy Bebop', 'Do roku 2071 ludzkość rozszerzyła się na całą galaktykę, wypełniając powierzchnię innych planet osadami podobnymi do tych na Ziemi.', 26, 'TV serial', '1998-03-03', 'https://jujutsu-kaisen.fandom.com/wiki/Cowboy_bebop', 4, 6,8.32);

INSERT INTO Anime (tytul, opis, liczba_odcinkow, typ, data_premiery, url_strony, tworca_id, gatunek_id,ocena)
VALUES
('Steins;Gate', 'Rintaro Okabe, student fizyki, odkrywa, że może wysyłać wiadomości w przeszłość za pomocą mikrofalówki. Używa tej mocy, aby spróbować zapobiec tragicznym wydarzeniom.', 24, 'TV serial', '2011-04-06', 'https://en.wikipedia.org/wiki/Steins;Gate_%28TV_series%29', 5, 6,9.03);

INSERT INTO Anime (tytul, opis, liczba_odcinkow, typ, data_premiery, url_strony, tworca_id, gatunek_id,ocena)
VALUES
('Chainsaw Man', 'Denji, młody człowiek żyjący w biedzie, łączy się z psem-piłą spalinową imieniem Pochita i staje się hybrydą człowieka i piły łańcuchowej.', 12, 'TV serial', '2022-10-11', 'https://en.wikipedia.org/wiki/Chainsaw_Man', 6, 7,8.56);

INSERT INTO Anime (tytul, opis, liczba_odcinkow, typ, data_premiery, url_strony, tworca_id, gatunek_id,ocena)
VALUES
('Naruto', 'Naruto Uzumaki, młody ninja, marzy o zostaniu Hokage, przywódcą wioski.', 220, 'TV serial', '2002-10-03', 'https://en.wikipedia.org/wiki/Naruto', 7, 13,8.21);

INSERT INTO Anime (tytul, opis, liczba_odcinkow, typ, data_premiery, url_strony, tworca_id, gatunek_id,ocena)
VALUES
('Takt Op. Destiny', 'W świecie opanowanym przez D2, muzyka stała się tabu. Takt Asahina, dyrygent bez talentu muzycznego, łączy siły z Cosette, muzyczną duszą w formie karabinu, by walczyć z D2.', 12, 'TV serial', '2021-10-05', 'https://myanimelist.net/anime/48556/Takt_Op_Destiny', 8, 7,6.87);




INSERT INTO Odcinek (nr_odcinka, tytul, opis, data_premiery, dlugosc_odcinka, anime_id,ocena)
VALUES
(1, 'Przebudzenie', 'Yuji Itadori połyka palec Sukuny i staje się medium dla Króla Klątw.', '2020-10-02', 24, 1,8.90),
(2, 'Dołączając do Czarowników Jujutsu', 'Yuji dołącza do Jujutsu Tech i poznaje swoich przyszłych towarzyszy.', '2020-10-09', 24, 1,7.44),
(3, 'Klątwa w szkole', 'Yuji i jego koledzy stają w obliczu Klątwy nawiedzającej szkołę.', '2020-10-16', 24, 1,8.92);

INSERT INTO Odcinek (nr_odcinka, tytul, opis, data_premiery, dlugosc_odcinka, anime_id,ocena)
VALUES
(1, 'Rebirth', 'Light Yagami znajduje Death Note i zaczyna eliminować zbrodniarzy.', '2006-10-03', 24, 2,8.01),
(2, 'Kira', 'Light staje się znany jako "Kira", a śledczy L podejmuje się jego schwytania.', '2006-10-10', 24, 2,8.34),
(3, 'L', 'Light i L prowadzą ze sobą psychologiczną grę w kotka i myszkę.', '2006-10-17', 24, 2,7.77);

INSERT INTO Odcinek (nr_odcinka, tytul, opis, data_premiery, dlugosc_odcinka, anime_id,ocena)
VALUES
(1, 'Anioł na Ziemi', 'Shinji Ikari zostaje zmuszony do pilotowania Evangelion Unit-01.', '1995-10-04', 24, 3,9.02),
(2, 'Apostoł Ewy', 'Shinji poznaje Rei Ayanami, drugą pilotkę Evangelionu.', '1995-10-11', 24, 3,8.81),
(3, 'Zerwanie pieczęci', 'Anioł zagraża Nerv i Tokio-3.', '1995-10-18', 24, 3,6.69);

INSERT INTO Odcinek (nr_odcinka, tytul, opis, data_premiery, dlugosc_odcinka, anime_id,ocena)
VALUES
(1, 'Asteroid Blues', 'Spike i Jet otrzymują zlecenie na schwytanie przemytnika na asteroidzie.', '1998-04-03', 24, 4,6.55),
(2, 'Stray Dog Strut', 'Załoga Bebop spotyka dziewczynę z amnezją, która okazuje się być cennym łupem.', '1998-04-10', 24, 4,8.27),
(3, 'Honky Tonk Women', 'Faye Valentine musi zmierzyć się z przeszłością.', '1998-04-17', 24, 4,7.90);

INSERT INTO Odcinek (nr_odcinka, tytul, opis, data_premiery, dlugosc_odcinka, anime_id,ocena)
VALUES 
(1, 'Dzień, w którym zaczął się eksperyment', 'Rintaro Okabe przypadkowo odkrywa sposób na podróżowanie w czasie.', '2011-04-06', 24, 5,8.97),
(2, 'Zmiana przeszłości', 'Rintaro próbuje zmienić przeszłość, aby uratować życie swojego przyjaciela.', '2011-04-13', 24, 5,9.06),
(3, 'Konsekwencje podróży w czasie', 'Rintaro zaczyna zdawać sobie sprawę z konsekwencji swoich działań.', '2011-04-20', 24, 5,9.23);

INSERT INTO Odcinek (nr_odcinka, tytul, opis, data_premiery, dlugosc_odcinka, anime_id,ocena)
VALUES 
(1, 'Denji, Człowiek Piła Mechaniczna', 'Denji, nisko opłacany łowca diabłów, łączy się z psem-diabłem Pochitą i staje się Człowiekiem Piłą Mechaniczną.', '2022-10-11', 24, 6,8.90),
(2, 'Dołączenie do Bezpieczeństwa Publicznego', 'Denji dołącza do Publicznej Bezpieczeństwa i poznaje Makimę.', '2022-10-18', 24, 6,6.98),
(3, 'Pierwsza misja', 'Denji i jego drużyna wyruszają na swoją pierwszą misję.', '2022-10-25', 24, 6,6.89);

INSERT INTO Odcinek (nr_odcinka, tytul, opis, data_premiery, dlugosc_odcinka, anime_id,ocena)
VALUES 
(1, 'Uczeń Ninja', 'Naruto Uzumaki marzy o zostaniu Hokage, przywódcą wioski Konohagakure.', '2002-10-03', 24, 7,7.43),
(2, 'Pierwsza misja', 'Naruto i jego drużyna wyruszają na pierwszą misję.', '2002-10-10', 24, 7,8.91),
(3, 'Egzamin na Chunina', 'Naruto i jego przyjaciele biorą udział w egzaminie na Chunina.', '2003-08-07', 24,7, 5.90);

INSERT INTO Odcinek (nr_odcinka, tytul, opis, data_premiery, dlugosc_odcinka, anime_id,ocena)
VALUES 
(1, 'Pierwsza Wojna o Święty Graal', 'Kiritsugu Emiya, mag zabójca, bierze udział w IV Wojnie o Święty Graal.', '2011-10-02', 24, 8,5.86),
(2, 'Saber', 'Kiritsugu przyzywa sługę klasy Saber, Arturia Pendragon.', '2011-10-09', 24, 8,7.78),
(3, 'Wojna się rozpoczyna', 'Kiritsugu staje w obliczu innych magów i ich sług.', '2011-10-16', 24, 8,6.80);




INSERT INTO Aktor (imie, nazwisko, kraj, rok_urodzenia, biografia)
VALUES
('Junya', 'Enoki', 'Japonia', '1988-10-18', 'Aktor głosowy znany z ról Yuji Itadori w Jujutsu Kaisen, Tanjiro Kamado w Demon Slayer: Kimetsu no Yaiba i Bakugo Katsuki w My Hero Academia.'),
('Yuuma', 'Uchida', 'Japonia', '1992-03-03', 'Aktor głosowy znany z ról Megumi Fushiguro w Jujutsu Kaisen, Megumi Fushiguro w Mob Psycho 100 i Haruka Nanase w Free!.'),
('Asami', 'Seto', 'Japonia', '1993-01-05', 'Aktorka głosowa znana z ról Nobara Kugisaki w Jujutsu Kaisen, Raphtalia w The Rising of the Shield Hero i Mami Nanami w Madoka Magica.'),
('Yuuichi', 'Nakamura', 'Japonia', '1981-12-12', 'Aktor głosowy znany z ról Satoru Gojo w Jujutsu Kaisen, Aizawa Shota w My Hero Academia i Undertaker w Black Butler.'),
('Junichi', 'Suwabe', 'Japonia', '1974-04-22', 'Aktor głosowy znany z ról Ryomen Sukuna w Jujutsu Kaisen, Griffith w Berserk i Cloud Strife w Final Fantasy VII.');

INSERT INTO Aktor (imie, nazwisko, kraj, rok_urodzenia, biografia)
VALUES
('Mamoru', 'Miyano', 'Japonia', '1983-03-29', 'Aktor głosowy znany z ról Light Yagami w Death Note, Rintarou Okabe w Steins;Gate i Atsushi Nakajima w Bungou Stray Dogs.'),
('Kappei', 'Yamaguchi', 'Japonia', '1968-11-03', 'Aktor głosowy znany z ról L w Death Note, Eikichi Onizuka w Great Teacher Onizuka i Inuyasha w Inuyasha.'),
('Aya', 'Hirano', 'Japonia', '1987-04-06', 'Aktorka głosowa znana z ról Misa Amane w Death Note, Lucy Heartfilia w Fairy Tail i Nadeshiko Kagamihara w Love Live!.'),
('Kimiko', 'Saitou', 'Japonia', '1975-01-23', 'Aktorka głosowa znana z ról Rem w Death Note, Hinata Hyuga w Naruto i Anna Kyoyama w Shaman King.'),
('Shidou', 'Nakamura', 'Japonia', '1973-10-13', 'Aktor głosowy znany z ról Ryuk w Death Note, Brock w Pokemon i Laxus Dreyar w Fairy Tail.');

INSERT INTO Aktor (imie, nazwisko, kraj, rok_urodzenia, biografia)
VALUES
('Megumi', 'Ogata', 'Japonia', '1965-07-30', 'Aktorka głosowa znana z ról Shinji Ikari w Evangelion, Shinji Ikari w Rebuild of Evangelion i Sailor Moon w Sailor Moon.'),
('Megumi', 'Hayashibara', 'Japonia', '1978-09-09', 'Aktorka głosowa znana z ról Rei w Evangelion, Shinji Ikari w Rebuild of Evangelion i Sailor Moon w Sailor Moon.');

INSERT INTO Aktor (imie, nazwisko, kraj, rok_urodzenia, biografia)
VALUES
('Kouichi', 'Yamadera', 'Japonia', '1961-07-17', 'Aktor głosowy znana z ról Spiegel, Spike w Cowboy bebep'),
('Unshou', 'Ishizuka', 'Japonia', '1951-05-16', 'Aktorka głosowa znana z ról Zabuzy z Naruto');

INSERT INTO Aktor (imie, nazwisko, kraj, rok_urodzenia, biografia)
VALUES
('Asami', 'Imai,', 'Japonia', '1977-05-17', 'Imai rozpoczęła swoją karierę w 1999 roku jako aktorka teatralna. W 2001 roku zadebiutowała jako aktorka głosowa w anime Angelic Layer.'),
('Kana', 'Hanazawa', 'Japonia', '1989-02-25', 'Hanazawa rozpoczęła swoją karierę w 2007 roku jako aktorka głosowa w anime Lucky Star.'),
('Tomokazu', 'Seki', 'Japonia', '1972-09-02', 'Seki rozpoczął swoją karierę w 1992 roku jako aktor głosowy w anime Mobile Suit Gundam Wing.'),
('Yukari', 'Tamura', 'Japonia', '1976-02-26', 'Tamura rozpoczęła swoją karierę w 1994 roku jako aktorka głosowa w anime Marmalade Boy.');

INSERT INTO Aktor (imie, nazwisko, kraj, rok_urodzenia, biografia)
VALUES
('Tomori', 'Kusunoki', 'Japonia', '1999-12-22', 'Aktor głosowy znany z ról Makima oraz Mikazuki z Zoom 100.'),
('Ai', 'Fairouz', 'Japonia', '1993-07-06', 'Aktor głosowy znany z ról L w Power oraz Delty.'),
('Kikunosuke', 'Toya', 'Japonia', '1998-11-30', 'Aktorka głosowa znana z ról Denji.'),
('Shougo', 'Sakata', 'Japonia', '1998-06-23', 'Aktorka głosowa znana z ról Aki.'),
('Reina', 'Ueda', 'Japonia', '1994-06-17', 'Aktor głosowy znany z ról Reze.');

INSERT INTO Aktor (imie, nazwisko, kraj, rok_urodzenia, biografia)
VALUES
('Junko', 'Takeuchi', 'Japonia', '1972-04-05', 'Aktor głosowy znany z ról naruto oraz Gon z Hunter x Hunster.'),
('Kazuhiko', 'Inoue', 'Japonia', '1990-08-26', 'Aktor głosowy znany z ról Kakashi oraz Tsugikuni, Yoriichi z Demon slayera.'),
('Noriaki', 'Sugiyama', 'Japonia', '1974-03-30', 'Aktorka głosowa znana z Uchicha Sasuke.'),
('Chie', 'Nakamura', 'Japonia', '1978-05-23', 'Aktorka głosowa znana z ról Sakury z Naruto.'),
('Hideo', 'Ishikawa', 'Japonia', '1969-06-17', 'Aktor głosowy znany z ról Uchicha Itachi oraz rola FBi w Death Note.');

INSERT INTO Aktor (imie, nazwisko, kraj, rok_urodzenia, biografia)
VALUES
('Shion', 'Wakayama', 'Japonia', '1990-02-10', 'Aktor głosowy znany z ról Destiny.'),
('Kouki', 'Uchiyama', 'Japonia', '1954-03-26', 'Aktor głosowy znany z ról Asahina, Takt.'),
('Miku', 'Itou', 'Japonia', '1996-10-12', 'Aktorka głosowa znana z Titan.'),
('Kaede', 'Hondo', 'Japonia', '1996-03-06', 'Aktorka głosowa znana z ról Schneider, Anna.'),
('Inori', 'Minase', 'Japonia', '1995-12-02', 'Aktor głosowy znany z ról Heaven oraz .');






INSERT INTO Postac (imie, nazwisko, plec, url_zdjecie, gatunek, anime_id, aktor_id)
VALUES
('Yuji', 'Itadori', 'M', 'https://static.wikia.nocookie.net/jujutsu-kaisen/images/1/12/Yuji_Itadori.png/revision/latest?cb=20201010021440', 'Czlowiek', 1, 1),
('Megumi', 'Fushiguro', 'M', 'https://static.wikia.nocookie.net/jujutsu-kaisen/images/a/a8/Megumi_Fushiguro.png/revision/latest?cb=20201010021446', 'Czlowiek', 1, 2),
('Nobara', 'Kugisaki', 'K', 'https://static.wikia.nocookie.net/jujutsu-kaisen/images/b/b1/Nobara_Kugisaki.png/revision/latest?cb=20201010021451', 'Czlowiek', 1, 3),
('Satoru', 'Gojo', 'M', 'https://static.wikia.nocookie.net/jujutsu-kaisen/images/5/55/Satoru_Gojo.png/revision/latest?cb=20201010021456', 'Czlowiek', 1, 4),
('Ryomen', 'Sukuna', 'M', 'https://static.wikia.nocookie.net/jujutsu-kaisen/images/a/a9/Ryomen_Sukuna.png/revision/latest?cb=20201010021502', 'Czlowiek', 1, 5);

INSERT INTO Postac (imie, nazwisko, plec, url_zdjecie, gatunek, anime_id, aktor_id)
VALUES
('Light', 'Yagami', 'M', 'https://static.wikia.nocookie.net/deathnote/images/7/7a/Light_Yagami.png/revision/latest?cb=20200810182234', 'Czlowiek', 2, 6),
('L', 'Lawliet', 'M', 'https://static.wikia.nocookie.net/deathnote/images/6/6e/L_Lawliet.png/revision/latest?cb=20200810182240', 'Czlowiek', 2, 7),
('Misa', 'Amane', 'K', 'https://static.wikia.nocookie.net/deathnote/images/a/a8/Misa_Amane.png/revision/latest?cb=20200810182245', 'Czlowiek', 2, 8),
('Rem', 'Ryuk', 'M', 'https://static.wikia.nocookie.net/deathnote/images/3/36/Rem.png/revision/latest?cb=20200810182251', 'Shinigami', 2, 9),
('Ryuk', 'Shinigami', 'M', 'https://static.wikia.nocookie.net/deathnote/images/b/b5/Ryuk.png/revision/latest?cb=20200810182256', 'Shinigami', 2, 10);

INSERT INTO Postac (imie, nazwisko, plec, url_zdjecie, gatunek, anime_id, aktor_id)
VALUES
('Shinji', 'Ikari', 'M', 'https://static.wikia.nocookie.net/evangelion/images/a/a8/Shinji_Ikari.png/revision/latest?cb=20200810182302', 'Czlowiek', 3, 11),
('Rei', 'Ayanami', 'K', 'https://static.wikia.nocookie.net/evangelion/images/2/22/Rei_Ayanami.png/revision/latest?cb=202','Czlowiek',3,12);

INSERT INTO Postac (imie, nazwisko, plec, url_zdjecie, gatunek, anime_id, aktor_id)
VALUES
('Spike', 'Spiegel', 'M', 'https://cowboybebop.fandom.com/wiki/Spike_Spiegel', 'Czlowiek', 4, 13),
('Jet', 'Black', 'M', 'https://www.merriam-webster.com/dictionary/jet-black', 'Czlowiek', 4, 14),
('Faye', 'Valentine', 'K', 'https://cowboybebop.fandom.com/wiki/Faye_Valentine', 'Czlowiek', 4, 12);

INSERT INTO Postac (imie, nazwisko, plec, url_zdjecie, gatunek, anime_id, aktor_id)
VALUES
('Rintarou', 'Okabe', 'M', 'https://static.wikia.nocookie.net/deathnote/images/7/7a/Light_Yagami.png/revision/latest?cb=20200810182234', 'Czlowiek', 5, 6),
('Kurisu', 'Makise', 'K', 'https://static.wikia.nocookie.net/deathnote/images/6/6e/L_Lawliet.png/revision/latest?cb=20200810182240', 'Czlowiek', 5, 15),
('Mayuri', 'Shiina', 'K', 'https://static.wikia.nocookie.net/deathnote/images/a/a8/Misa_Amane.png/revision/latest?cb=20200810182245', 'Czlowiek', 5, 16),
('Itaru', 'Hashida', 'M', 'https://static.wikia.nocookie.net/deathnote/images/3/36/Rem.png/revision/latest?cb=20200810182251', 'Czlowiek', 5, 17),
('Suzuha', 'Amane', 'M', 'https://static.wikia.nocookie.net/deathnote/images/b/b5/Ryuk.png/revision/latest?cb=20200810182256', 'Czlowiek', 5, 18);

INSERT INTO Postac (imie, nazwisko, plec, url_zdjecie, gatunek, anime_id, aktor_id)
VALUES
('Makima', '...', 'K', 'https://static.wikia.nocookie.net/deathnote/images/7/7a/Light_Yagami.png/revision/latest?cb=20200810182234', 'Czlowiek', 6, 19),
('Power', '...', 'K', 'https://static.wikia.nocookie.net/deathnote/images/6/6e/L_Lawliet.png/revision/latest?cb=20200810182240', 'Czlowiek', 6, 20),
('Denji', '...', 'M', 'https://static.wikia.nocookie.net/deathnote/images/a/a8/Misa_Amane.png/revision/latest?cb=20200810182245', 'Czlowiek', 6, 21),
('Aki', 'Hayakawa', 'M', 'https://static.wikia.nocookie.net/deathnote/images/3/36/Rem.png/revision/latest?cb=20200810182251', 'Czlowiek', 6, 22),
('Reze', '....', 'K', 'https://static.wikia.nocookie.net/deathnote/images/b/b5/Ryuk.png/revision/latest?cb=20200810182256', 'Czlowiek', 6, 23);

INSERT INTO Postac (imie, nazwisko, plec, url_zdjecie, gatunek, anime_id, aktor_id)
VALUES
('Naruto', 'Uzumaki', 'M', 'https://static.wikia.nocookie.net/deathnote/images/7/7a/Light_Yagami.png/revision/latest?cb=20200810182234', 'Czlowiek', 7, 24),
('Kakashi', 'Hatake', 'M', 'https://static.wikia.nocookie.net/deathnote/images/6/6e/L_Lawliet.png/revision/latest?cb=20200810182240', 'Czlowiek', 7, 25),
('Sasuke', 'Uchicha', 'M', 'https://static.wikia.nocookie.net/deathnote/images/a/a8/Misa_Amane.png/revision/latest?cb=20200810182245', 'Czlowiek', 7, 26),
('Sakura', 'Haruno', 'K', 'https://static.wikia.nocookie.net/deathnote/images/3/36/Rem.png/revision/latest?cb=20200810182251', 'Czlowiek', 7, 27),
('Itachi', 'Uchicha', 'K', 'https://static.wikia.nocookie.net/deathnote/images/b/b5/Ryuk.png/revision/latest?cb=20200810182256', 'Czlowiek', 7, 28);

INSERT INTO Postac (imie, nazwisko, plec, url_zdjecie, gatunek, anime_id, aktor_id)
VALUES
('Destiny', '...', 'K', 'https://static.wikia.nocookie.net/deathnote/images/7/7a/Light_Yagami.png/revision/latest?cb=20200810182234', 'Muza', 8, 29),
('Takt', 'Asachina', 'M', 'https://static.wikia.nocookie.net/deathnote/images/6/6e/L_Lawliet.png/revision/latest?cb=20200810182240', 'Czlowiek', 8, 30),
('Titan', '...', 'K', 'https://static.wikia.nocookie.net/deathnote/images/a/a8/Misa_Amane.png/revision/latest?cb=20200810182245', 'Muza', 8, 31),
('Anna', 'Schneider', 'K', 'https://static.wikia.nocookie.net/deathnote/images/3/36/Rem.png/revision/latest?cb=20200810182251', 'Czlowiek', 8, 32),
('Heaven', '...', 'K', 'https://static.wikia.nocookie.net/deathnote/images/b/b5/Ryuk.png/revision/latest?cb=20200810182256', 'Muza', 8, 33);




INSERT INTO studio_anime (studio_id, anime_studio_id)
VALUES
(1, 1);

INSERT INTO studio_anime (studio_id, anime_studio_id)
VALUES
(2, 2);

INSERT INTO studio_anime (studio_id, anime_studio_id)
VALUES
(3, 3);

INSERT INTO studio_anime (studio_id, anime_studio_id)
VALUES
(4, 4);

INSERT INTO studio_anime (studio_id, anime_studio_id)
VALUES
(5, 7);

INSERT INTO studio_anime (studio_id, anime_studio_id)
VALUES
(6, 1);

INSERT INTO studio_anime (studio_id, anime_studio_id)
VALUES
(7, 7);

INSERT INTO studio_anime (studio_id, anime_studio_id)
VALUES
(8, 1),
(8, 2);




INSERT INTO postac_odcinek (postac_odcinek_id, odcinek_id)
VALUES
(1, 1), (1, 2), (1, 3), 
(2, 1), (2, 2), (2, 3), 
(3, 2), (3, 3), 
(4, 1), (4, 2), (4, 3), 
(5, 1); 

INSERT INTO postac_odcinek (postac_odcinek_id, odcinek_id)
VALUES
(6, 4), (6, 5), (6, 6), 
(7, 6), 
(8, 5), (8, 6), 
(9, 4), (9, 5), (9, 6), 
(10, 5), (10, 6); 

INSERT INTO postac_odcinek (postac_odcinek_id, odcinek_id)
VALUES
(11, 7), (11, 8), (11, 9), 
(12, 7), (12, 8);

INSERT INTO postac_odcinek (postac_odcinek_id, odcinek_id)
VALUES
(13, 10), (13, 11), (13, 12),
(14, 10), (14, 11), (14, 12),
(15, 10), (15, 11), (15, 12);

INSERT INTO postac_odcinek (postac_odcinek_id, odcinek_id)
VALUES
(16, 13), (16, 14), (16, 15),
(17, 13), (17, 14), (17, 15),
(18, 13), (18, 14), (18, 15),
(19, 13), (19, 14), (19, 15),
(20, 15);

INSERT INTO postac_odcinek (postac_odcinek_id, odcinek_id)
VALUES
(21, 16), (21, 17), (21, 18),
(22, 17), (22, 18),
(23, 18),
(24, 16), (24, 17), (24, 18),
(25, 16);

INSERT INTO postac_odcinek (postac_odcinek_id, odcinek_id)
VALUES
(26, 19), (26, 20), (26, 21),
(27, 19), (27, 20), (27, 21),
(28, 19), (28, 20), (28, 21),
(29, 19), (29, 20),
(30, 19);

INSERT INTO postac_odcinek (postac_odcinek_id, odcinek_id)
VALUES
(31, 22), (31, 23), (31, 24),
(32, 22), (32, 23), (32, 24),
(33, 22), (33, 23), (33, 24),
(34, 22), (34, 23), (34, 24),
(35, 22), (35, 23), (35, 14);









CREATE OR REPLACE FUNCTION aktualizuj_liczbe_odcinkow() RETURNS TRIGGER AS $$
BEGIN
   UPDATE Anime SET liczba_odcinkow = liczba_odcinkow + 1 WHERE id = NEW.anime_id;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_aktualizuj_liczbe_odcinkow
AFTER INSERT ON odcinek
FOR EACH ROW EXECUTE PROCEDURE aktualizuj_liczbe_odcinkow();




CREATE OR REPLACE FUNCTION aktualizuj_liczbe_odcinkow_po_usunieciu() RETURNS TRIGGER AS $$
BEGIN
   UPDATE Anime SET liczba_odcinkow = liczba_odcinkow - 1 WHERE id = OLD.anime_id;
   RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_aktualizuj_liczbe_odcinkow_po_usunieciu
AFTER DELETE ON odcinek
FOR EACH ROW EXECUTE PROCEDURE aktualizuj_liczbe_odcinkow_po_usunieciu();




