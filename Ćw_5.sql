create database Firma2;
use Firma2;
create schema ksiegowosc;

create table ksiegowosc.pracownicy (
    id_pracownika INT NOT NULL PRIMARY KEY,
    imie VARCHAR(20) NOT NULL,
    nazwisko VARCHAR(20) NOT NULL,
    adres VARCHAR(40) NOT NULL,
    telefon VARCHAR(12) NOT NULL
    );

create table ksiegowosc.godziny (
    id_godziny INT NOT NULL PRIMARY KEY, 
    data DATE NOT NULL,
    liczba_godzin INT NOT NULL, 
    id_pracownika INT NOT NULL,
);

create table ksiegowosc.pensja (
    id_pensji INT NOT NULL PRIMARY KEY,
    stanowisko VARCHAR(20) NOT NULL,
    kwota DECIMAL(10,2) NOT NULL,
);

create table ksiegowosc.premia (
    id_premii INT NOT NULL PRIMARY KEY,
    rodzaj VARCHAR(20) NOT NULL,
    kwota DECIMAL(10,2) NOT NULL
);

create table ksiegowosc.wynagrodzenie (
    id_wynagrodzenia INT NOT NULL PRIMARY KEY,
	data DATE NOT NULL,
	id_pracownika INT NOT NULL,
	id_godziny INT NOT NULL,
	id_pensji INT NOT NULL,
	id_premii INT NOT NULL,
);

ALTER TABLE ksiegowosc.godziny ADD FOREIGN key (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenia ADD FOREIGN key (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenia ADD FOREIGN key (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynagrodzenia ADD FOREIGN key (id_premii) REFERENCES ksiegowosc.premia(id_premii);
ALTER TABLE ksiegowosc.wynagrodzenia ADD FOREIGN key (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);

insert into ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
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
      
insert into ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
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

insert into ksiegowosc.pensja (id_pensji, stanowisko, kwota)
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
 
insert into ksiegowosc.premia (id_premii, rodzaj, kwota)
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

insert into ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
values
(1, '2021-15-04', 1, 1, 1, 1),
(2, '2015-15-11', 2, 2, 2, 2),
(3, '2024-04-03', 3, 3, 3, 3),
(4, '2023-24-05', 4, 4, 4, 4),
(5, '2021-12-12', 5, 5, 5, 5),
(6, '2022-09-08', 6, 6, 6, 6),
(7, '2023-24-05', 7, 7, 7, 7),
(8, '2022-09-08', 8, 8, 8, 8),
(9, '2015-15-11', 9, 9, 9, 9),
(10, '2024-04-10', 10, 10, 10, 10);



-- a)
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

-- b)
SELECT pracownicy.id_pracownika
FROM ksiegowosc.pracownicy pracownicy
JOIN ksiegowosc.wynagrodzenie wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
WHERE pensja.kwota > 1000;

-- c)
SELECT pracownicy.id_pracownika, pensja.kwota, premia.id_premii 
FROM ksiegowosc.pracownicy pracownicy
JOIN ksiegowosc.wynagrodzenie wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
LEFT JOIN ksiegowosc.premia premia ON wynagrodzenie.id_premii = premia.id_premii
WHERE premia.id_premii IS NOT NULL AND pensja.kwota > 2000;

-- d)
SELECT * FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%';

-- e)
SELECT * FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

-- f)
SELECT pracownicy.imie, pracownicy.nazwisko, SUM(godziny.liczba_godzin) - 160 AS nadgodziny
FROM ksiegowosc.pracownicy pracownicy
JOIN ksiegowosc.godziny godziny ON pracownicy.id_pracownika = godziny.id_pracownika
GROUP BY pracownicy.imie, pracownicy.nazwisko
HAVING SUM(godziny.liczba_godzin) > 160;

-- g)
SELECT p.imie, p.nazwisko
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja s ON w.id_pensji = s.id_pensji
WHERE s.kwota BETWEEN 1500 AND 3000;

-- h)
SELECT pracownicy.imie, pracownicy.nazwisko
FROM ksiegowosc.pracownicy pracownicy
JOIN ksiegowosc.wynagrodzenie wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.godziny godziny ON pracownicy.id_pracownika = godziny.id_pracownika
LEFT JOIN ksiegowosc.premia premia ON wynagrodzenie.id_premii = premia.id_premii
WHERE godziny.liczba_godzin > 160 AND premia.id_premii IS NULL;

-- i)
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota AS pensja
FROM ksiegowosc.pracownicy pracownicy
JOIN ksiegowosc.wynagrodzenie wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
ORDER BY pensja.kwota;

-- j)
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota AS pensja, premia.kwota AS premia
FROM ksiegowosc.pracownicy pracownicy
JOIN ksiegowosc.wynagrodzenie wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
LEFT JOIN ksiegowosc.premia premia ON wynagrodzenie.id_premii = premia.id_premii
ORDER BY pensja.kwota DESC, premia.kwota DESC;





