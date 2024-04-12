
-- 1)

create database firma;
use firma;

-- 2)

create schema rozliczenia;

-- 3a,b,c)

create table rozliczenia.pracownicy (
    id_pracownika INT PRIMARY KEY,
    imie VARCHAR(20) NOT NULL,
    nazwisko VARCHAR(20) NOT NULL,
    adres VARCHAR(40) NOT NULL,
    telefon VARCHAR(12) NOT NULL
);

create table rozliczenia.godziny (
    id_godziny INT PRIMARY KEY,
    data DATE,
    liczba_godzin DECIMAL(15, 2) NOT NULL,
    id_pracownika INT
);

create table rozliczenia.pensje (
    id_pensji INT PRIMARY KEY,
    stanowisko VARCHAR(20) NOT NULL,
    kwota DECIMAL(15, 2) NOT NULL,
    id_premii INT
);

create table rozliczenia.premie (
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(50),
    kwota DECIMAL(15, 2) NOT NULL
);

-- 3d)

ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);
ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

-- 4)

insert into rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
values
(1, 'Agnieszka', 'Mucha','ul.Stojałowskiego 43A/7, Warszawa','473 298 167'),
(2, 'Maciej', 'Kowalski', 'al.Edypa 22, Kraków','289 715 267'),
(3, 'Weronika', 'Kotik', 'ul.Lipowa 2, Drawsko Pomorskie','345 678 901'),
(4, 'Szymon', 'Gordonowicz', 'ul.Jęczmienna 73, Hel','284 328 630'),
(5, 'Kacper', 'Mucha', 'ul.Fina 9, Madryt','198 254 127'),
(6, 'Jakub', 'Opalski', 'al.Świętych 12, Wrocław','209 472 718'),
(7, 'Aleksandra', 'Higiena', 'ul.Więckiewicza 9a, Runeterra','284 289 109'),
(8, 'Wiktoria', 'Spój', 'ul.Baka 32, Słomianki','123 123 123'),
(9, 'Paulina', 'Dęba', 'ul.Konopnickiej 22, Kraków','382 178 432'),
(10, 'Marek', 'Kolo', 'ul.Barmana 3, Opole','666 666 666');

insert into rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika)
values
(1, '2021-15-04', 33, 1),
(2, '2022-23-06', 45, 2),
(3, '2022-01-01', 64, 3),
(4, '2021-12-12', 23, 4),
(5, '2023-24-05', 176, 5),
(6, '2023-17-02', 236, 6),
(7, '2024-22-06', 12, 7),
(8, '2024-26-04', 167, 8),
(9, '2022-09-08', 34, 9),
(10, '2015-15-11', 22, 10);

insert into rozliczenia.pensje (id_pensji, stanowisko, kwota, id_premii)
values
(1, 'Programista', 6000, 1),
(2, 'Tester', 3000, 2),
(3, 'Programista', 12000, 3),
(4, 'Sprzątacz', 1200, 4),
(5, 'Tester', 2500, 5),
(6, 'Tester', 3100, 6),
(7, 'Programista', 9000, 7),
(8, 'Sekretarka', 1500, 8),
(9, 'Sprzątaczka', 1100, 9),
(10, 'Programista', 12000, 10);

insert into rozliczenia.premie (id_premii, rodzaj, kwota)
values
(1, 'Bonus', 900),
(2, 'Za nadgodziny', 200),
(3, 'Za wyniki', 120),
(4, 'Bonus', 430),
(5, 'Za nadgodziny', 300),
(6, 'Bonus', 321),
(7, 'Za wyniki', 800),
(8, 'Za wyniki', 1000),
(9, 'Za nadgodziny', 200),
(10, 'Za nadgodziny', 320);

-- 5)

SELECT nazwisko, adres
FROM rozliczenia.pracownicy;

-- 6)

SELECT id_godziny, DATA, DATEPART (DAY, DATA) AS dzien_tygodnia, DATEPART(MONTH, DATA) AS miesiac
FROM rozliczenia.godziny;

-- 7)

ALTER TABLE rozliczenia.pensje
RENAME COLUMN kwota TO kwota_brutto;

ALTER TABLE rozliczenia.pensje
ADD COLUMN kwota_netto DECIMAL(10,2);

UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto * 0.8;
