-- a)

alter table ksiegowosc.pracownicy
add tel NVARCHAR(18);

update ksiegowosc.pracownicy
set tel = '(+48) ' + telefon;

-- b)

update ksiegowosc.pracownicy
set tel = SUBSTRING(telefon, 1, 3) + '-' + SUBSTRING(telefon, 4, 3) + '-' + SUBSTRING(telefon, 7, 3);

-- c)

select top 1 UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko, UPPER(adres) AS adres, telefon
FROM ksiegowosc.pracownicy
ORDER BY LEN(nazwisko) DESC;

-- d)

select pr.id_pracownika, pr.imie, pr.nazwisko, HASHBYTES('MD5', CONVERT(VARCHAR, pn.kwota)) AS md5_pensja 
FROM ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie wn ON pr.id_pracownika = wn.id_pracownika
JOIN ksiegowosc.pensja pn ON wn.id_pensji = pn.id_pensji

-- f)

select pr.id_pracownika, pr.imie, pr.nazwisko, pn.kwota AS pensja, pm.kwota AS premia
FROM ksiegowosc.pracownicy pr
LEFT JOIN ksiegowosc.wynagrodzenie wn ON pr.id_pracownika = wn.id_pracownika
LEFT JOIN ksiegowosc.pensja pn ON wn.id_pensji = pn.id_pensji
LEFT JOIN ksiegowosc.premia pm ON wn.id_premii = pm.id_premii

-- g)

select contact('Pracownik ', pr.imie, ' ', pr.nazwisko, ', w dniu ', wn.data_, ' otrzymał/a pensję całkowitą na kwotę ',
(pn.kwota+pm.kwota), ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ', pn.kwota, ' zł, premia: ',
pm.kwota, ' zł, nadgodziny: ', 
CASE WHEN gd.liczba_godzin > 160 THEN (gd.liczba_godzin - 160) 
ELSE 0 END, ' gd.')
AS raport
FROM ksiegowosc.pracownicy pr
JOIN ksiegowosc.wynagrodzenie wn ON pr.id_pracownika = wn.id_pracownika
JOIN ksiegowosc.pensja pn ON wn.id_pensji = pn.id_pensji
JOIN ksiegowosc.premia pm ON wn.id_premii = pm.id_premii
JOIN ksiegowosc.godziny gd ON wn.id_godziny = gd.id_godziny




