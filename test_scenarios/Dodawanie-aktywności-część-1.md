## Dodawanie aktywności w aplikacji Measure Your Life

### Pierwszy przypadek – test sprawdza dodawanie aktywności z kategorii praca, bieżący dzień
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Praca"
1. W polu „Nazwa aktywności” wpisuje „Praca”
1. Wypełnia pole „Czas startu” danymi „8:00”
1. Wypełnia pole „Czas zakończenia” danymi „16:00”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności.
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Praca”
1. SPRAWDZA: pole „Od” wynosi „8:00”
1. SPRAWDZA: pole „Do” wynosi „16:00”
1. SPRAWDZA: aktywność należy do kategorii „Praca”
1. SPRAWDZA: czas trwania czynności wynosi „480 min”

### Drugi przypadek – test sprawdza dodawanie aktywności z kategorii obowiązki, bieżący dzień
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Obowiązki"
1. W polu „Nazwa aktywności” wpisuje „Szykowanie obiadu”
1. Wypełnia pole „Czas startu” danymi „16:00”
1. Wypełnia pole „Czas zakończenia” danymi „17:00”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Szykowanie obiadu”
1. SPRAWDZA: pole „Od” wynosi „16:00”
1. SPRAWDZA: pole „Do” wynosi „17::00”
1. SPRAWDZA: aktywność należy do kategorii „Obowiązki”
1. SPRAWDZA: czas trwania czynności wynosi „60 min”

### Trzeci przypadek – test sprawdza dodawanie aktywności z kategorii „Czas wolny”, bieżący dzień
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera „Czas wolny”
1. W polu „Nazwa aktywności” wpisuje „Czytanie książki”
1. Wypełnia pole „Czas startu” danymi „17:00”
1. Wypełnia pole „Czas zakończenia” danymi „18:15”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Czytanie książki”
1. SPRAWDZA: pole „Od” wynosi „17:00”
1. SPRAWDZA: pole „Do” wynosi „18:15”
1. SPRAWDZA: aktywność należy do kategorii „Czas wolny”
1. SPRAWDZA: czas trwania czynności wynosi „75 min”

### Czwarty przypadek – test sprawdza czy 2 różne aktywności mogą na siebie nachodzić czasowo, bieżący dzień (1)
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Praca"
1. W polu „Nazwa aktywności” wpisuje „Praca w firmie ABC”
1. Wypełnia pole „Czas startu” danymi „9:00”
1. Wypełnia pole „Czas zakończenia” danymi „17:00”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności.
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Praca w firmie ABC”
1. SPRAWDZA: pole „Od” wynosi „9:00”
1. SPRAWDZA: pole „Do” wynosi „17:00”
1. SPRAWDZA: aktywność należy do kategorii „Praca”
1. SPRAWDZA: czas trwania czynności wynosi „480 min”
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Praca"
1. W polu „Nazwa aktywności” wpisuje „Praca w firmie 123”
1. Wypełnia pole „Czas startu” danymi „9:00”
1. Wypełnia pole „Czas zakończenia” danymi „17:00”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: po naciśnięciu pojawia się popup z komunikatem „Uwaga, czynność nachodzi na już istniejące czynności.”

### Piąty przypadek – test sprawdza czy 2 różne aktywności mogą na siebie nachodzić czasowo, bieżący dzień (2)
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Obowiązki"
1. W polu „Nazwa aktywności” wpisuje „Koszenie trawy”
1. Wypełnia pole „Czas startu” danymi „18:00”
1. Wypełnia pole „Czas zakończenia” danymi „19:30”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Koszenie trawy”
1. SPRAWDZA: pole „Od” wynosi „18:00”
1. SPRAWDZA: pole „Do” wynosi „19:30”
1. SPRAWDZA: aktywność należy do kategorii „Obowiązki”
1. SPRAWDZA: czas trwania czynności wynosi „90 min”
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Obowiązki"
1. W polu „Nazwa aktywności” wpisuje „Zajęcia dodatkowe na uczelni”
1. Wypełnia pole „Czas startu” danymi „19:15”
1. Wypełnia pole „Czas zakończenia” danymi „20:15”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZAM: po naciśnięciu pojawia się komunikat „Uwaga, czynność nachodzi na już istniejące czynności.”

### Szósty przypadek – test sprawdza czy 2 różne aktywności mogą na siebie nachodzić czasowo, bieżący dzień (3)
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera „Czas wolny”
1. W polu „Nazwa aktywności” wpisuje „Bieganie”
1. Wypełnia pole „Czas startu” danymi „21:15”
1. Wypełnia pole „Czas zakończenia” danymi „22:45”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Bieganie”
1. SPRAWDZA: pole „Od” wynosi „21:15”
1. SPRAWDZA: pole „Do” wynosi „22:45”
1. SPRAWDZA: aktywność należy do kategorii „Czas wolny”
1. SPRAWDZA: czas trwania czynności wynosi „90 min”
1. Naciska przycisk "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera „Czas wolny”
1. W polu „Nazwa aktywności” wpisuje „Pływanie”
1. Wypełnia pole „Czas startu” danymi „20:15”
1. Wypełnia pole „Czas zakończenia” danymi „21:30”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZAM: po naciśnięciu pojawia się komunikat „Uwaga, czynność nachodzi na już istniejące czynności.”

### Siódmy przypadek – test sprawdza czy można dodać drugi raz aktywność o tej samej nazwie, inny czas, kategoria praca
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Praca"
1. W polu „Nazwa aktywności” wpisuje „Praca, nadgodziny”
1. Wypełnia pole „Czas startu” danymi „16:00”
1. Wypełnia pole „Czas zakończenia” danymi „20:00”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności.
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Praca, nadgodziny”
1. SPRAWDZA: pole „Od” wynosi „16:00”
1. SPRAWDZA: pole „Do” wynosi „20:00”
1. SPRAWDZA: aktywność należy do kategorii „Praca”
1. SPRAWDZA: czas trwania czynności wynosi „240 min”
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Praca"
1. W polu „Nazwa aktywności” wpisuje „Praca, nadgodziny”
1. Wypełnia pole „Czas startu” danymi „20:00”
1. Wypełnia pole „Czas zakończenia” danymi „20:30”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Praca, nadgodziny”
1. SPRAWDZA: pole „Od” wynosi „20:00”
1. SPRAWDZA: pole „Do” wynosi „20:30”
1. SPRAWDZA: aktywność należy do kategorii „Praca”
1. SPRAWDZA: czas trwania czynności wynosi „30 min”

### Ósmy przypadek – test sprawdza czy można dodać drugi raz aktywność o tej samej nazwie, inny czas, kategoria obowiązki
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Obowiązki"
1. W polu „Nazwa aktywności” wpisuje „Zaprowadzenie dziecka na zajęcia plastyczne”
1. Wypełnia pole „Czas startu” danymi „17:00”
1. Wypełnia pole „Czas zakończenia” danymi „19:00”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności.
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Zaprowadzenie dziecka na zajęcia plastyczne”
1. SPRAWDZA: pole „Od” wynosi „17:00”
1. SPRAWDZA: pole „Do” wynosi „19:00”
1. SPRAWDZA: aktywność należy do kategorii „Obowiązki”
1. SPRAWDZA: czas trwania czynności wynosi „120 min”
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Obowiązki"
1. W polu „Nazwa aktywności” wpisuje „Zaprowadzenie dziecka na zajęcia plastyczne”
1. Wypełnia pole „Czas startu” danymi „19:00”
1. Wypełnia pole „Czas zakończenia” danymi „19:15”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Zaprowadzenie dziecka na zajęcia plastyczne”
1. SPRAWDZA: pole „Od” wynosi „19:00”
1. SPRAWDZA: pole „Do” wynosi „19:15”
1. SPRAWDZA: aktywność należy do kategorii „Obowiązki”
1. SPRAWDZA: czas trwania czynności wynosi „15 min”

### Dziewiąty przypadek – test sprawdza czy można dodać drugi raz aktywności o tej samej nazwie, inny czas, kategoria „Czas wolny”
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera „Czas wolny”
1. W polu „Nazwa aktywności” wpisuje „Uprawianie sportu”
1. Wypełnia pole „Czas startu” danymi „17:15”
1. Wypełnia pole „Czas zakończenia” danymi „18:00”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności.
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Uprawianie sportu”
1. SPRAWDZA: pole „Od” wynosi „17:15”
1. SPRAWDZA: pole „Do” wynosi „18:00”
1. SPRAWDZA: aktywność należy do kategorii „Czas Wolny”
1. SPRAWDZA: czas trwania czynności wynosi „45 min”
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera „Czas wolny”
1. W polu „Nazwa aktywności” wpisuje „Uprawianie sportu”
1. Wypełnia pole „Czas startu” danymi „18:30”
1. Wypełnia pole „Czas zakończenia” danymi „18:45”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się strona aktywności
1. SPRAWDZA: na liście aktywności znajduje się aktywność „Uprawianie sportu”
1. SPRAWDZA: pole „Od” wynosi „18:30”
1. SPRAWDZA: pole „Do” wynosi „18:45”
1. SPRAWDZA: aktywność należy do kategorii „Czas wolny”
1. SPRAWDZA: czas trwania czynności wynosi „15 min”

### Dziesiąty przypadek – test sprawdza dodawanie aktywności z kategorii praca, na końcu rezygnuje z dodawania aktywności
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Praca"
1. W polu „Nazwa aktywności” wpisuje „Drugi etat”
1. Wypełnia pole „Czas startu” danymi „20:15”
1. Wypełnia pole „Czas zakończenia” danymi „21:00”
1. Naciska button „Rezygnuję”
1. SPRAWDZA: wprowadzone dane zostają wyczyszczone, pojawia się strona aktywności

### Jedenasty przypadek – test sprawdza dodawanie aktywności z kategorii obowiązki, na końcu rezygnuje z dodawania aktywności
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Obowiązki"
1. W polu „Nazwa aktywności” wpisuje „Prasowanie rzeczy”
1. Wypełnia pole „Czas startu” danymi „20:15”
1. Wypełnia pole „Czas zakończenia” danymi „21:15”
1. Naciska button „Rezygnuję”
1. SPRAWDZA: wprowadzone dane zostają wyczyszczone, pojawia się strona aktywności

### Dwunasty przypadek – test sprawdza dodawanie aktywności z kategorii „Czas wolny”, na końcu rezygnuje z dodawania aktywności
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera „Czas wolny”
1. W polu „Nazwa aktywności” wpisuje „Bieganie”
1. Wypełnia pole „Czas startu” danymi „20:30”
1. Wypełnia pole „Czas zakończenia” danymi „21:30”
1. Naciska button „Rezygnuję” 
1. SPRAWDZA: wprowadzone dane zostają wyczyszczone, pojawia się strona aktywności

### Trzynasty przypadek – test sprawdza czy można zapisać aktywność bez wypełnienia pól
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pod polem "Kategoria aktywności" pojawia się komunikat "Kategoria aktywności nie może być pusta"
1. SPRAWDZA: pod polem „Nazwa aktywności” pojawia się komunikat "Aktywność nie może być pusta"
1. SPRAWDZA: pod polem „Czas startu” pojawia się komunikat "Czas startu nie może być pusty"
1. SPRAWDZA: pod polem „Czas zakończenia” pojawia się komunikat "Czas zakończenia nie może być pusty"

### Czternasty przypadek – test sprawdza czy można dodać aktywność podając godziny w nieodpowiedniej kolejności (1)
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Praca"
1. W polu „Nazwa aktywności” wpisuje „Praca”
1. Wypełnia pole „Czas startu” danymi „16:00”
1. Wypełnia pole „Czas zakończenia” danymi „08:00”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się komunikat "Nie można dodać aktywności. Spróbuj później."

### Piętnasty przypadek – test sprawdza czy można dodać aktywność podając godziny w nieodpowiedniej kolejności (2)
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Obowiązki"
1. W polu „Nazwa aktywności” wpisuje „Programowanie”
1. Wypełnia pole „Czas startu” danymi „19:00”
1. Wypełnia pole „Czas zakończenia” danymi „17:00”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się komunikat "Nie można dodać aktywności. Spróbuj później."

### Szesnasty przypadek – test sprawdza czy można dodać aktywność podając godziny w nieodpowiedniej kolejności (3)
1. Zakłada nowe konto i loguje się.
1. Naciska button "+", aby dodać nową aktywność.
1. Z podręcznego menu wybiera "Czas wolny"
1. W polu „Nazwa aktywności” wpisuje „Pływanie”
1. Wypełnia pole „Czas startu” danymi „20:45”
1. Wypełnia pole „Czas zakończenia” danymi „20:00”
1. Naciska button „Dodaj aktywność”
1. SPRAWDZA: pojawia się komunikat "Nie można dodać aktywności. Spróbuj później."
