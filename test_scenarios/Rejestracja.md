## Rejestracja w aplikacji MeasureYourLife

### Pierwszy przypadek - test sprawdza zachowanie formularza rejestracji bez wypełnienia pól
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się strona rejestracji aplikacji MeasureYourLife
1. Naciska button "Zakładam konto"
1. SPRAWDZA: nad polem „E-mail” pojawia się komunikat „Pole jest wymagane”
1. SPRAWDZA: nad polem „Login” pojawia się komunikat „Pole jest wymagane”
1. SPRAWDZA: nad polem „Hasło” pojawia się komunikat „Pole jest wymagane”
1. SPRAWDZA: nad polem „Powtórz hasło” pojawia się komunikat „Pole jest wymagane”

### Drugi przypadek - test sprawdza możliwość rejestracji w aplikacji, wypełnione wszystkie pola (1)
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się strona rejestracji aplikacji MeasureYourLife
1. Wypełnia pole „E-mail” danymi „janusz.testowy@gmail.com”
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek7”
1. Wypełnia pole „Hasło” „Test12!@”
1. Wypełnia pole „Powtórz hasło” „Test12!@”
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się popup z komunikatem "Na Twoje konto e-mail wysłaliśmy maila weryfikacyjnego"
1. Potwierdza adres e-mail.
1. Otwiera stronę logowania.
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek7”
1. Wypełnia pole „Hasło” „Test12!@”
1. Naciska button „Loguję się”
1. SPRAWDZA: pojawia się strona aktywności

### Trzeci przypadek - test sprawdza możliwość rejestracji w aplikacji, wypełnione wszystkie pola (2)
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się strona rejestracji aplikacji MeasureyYourlife
1. Wypełnia pole „E-mail” danymi „janusz.testowy2@gmail.com”
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek2”
1. Wypełnia pole „Hasło” „Test12!@”
1. Wypełnia pole „Powtórz hasło” „Test12!@”
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się popup z komunikatem "Na Twoje konto e-mail wysłaliśmy maila weryfikacyjnego"
1. Potwierdza adres e-mail.
1. Otwiera stronę logowania.
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek2”
1. Wypełnia pole „Hasło” „Test12!@”
1. Naciska button „Loguję się”
1. SPRAWDZA: pojawia się strona aktywności

### Czwarty przypadek - test sprawdza możliwość rejestracji w aplikacji, podane różne hasła
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się strona rejestracji aplikacji MeasureYourLife
1. Wypełnia pole „E-mail” danymi „janusz.testowy4@gmail.com”
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek4”
1. Wypełnia pole „Hasło” „Test12!@”
1. Wypełnia pole „Powtórz hasło” „!@12tesT”
1. Naciska button „Zakładam konto”
1. SPRAWDZA: nad polem „Hasło” pojawia się komunikat „Powtórzone hasło nie jest identyczne z podanym hasłem”

### Piąty przypadek - test sprawdza możliwość rejestracji drugi raz w aplikacji na ten sam login
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się strona rejestracji aplikacji MeasureYourLife
1. Wypełnia pole „E-mail” danymi „janusz.testowy5@gmail.com”
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek5”
1. Wypełnia pole „Hasło” „Test12!@”
1. Wypełnia pole „Powtórz hasło” „Test12!@”
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się popup z komunikatem "Na Twoje konto e-mail wysłaliśmy maila weryfikacyjnego"
1. Potwierdza adres e-mail.
1. Otwiera stronę logowania.
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek5”
1. Wypełnia pole „Hasło” „Test12!@”
1. Naciska button „Loguję się”
1. SPRAWDZA: pojawia się strona aktywności
1. Wylogowuje się.
1. Pojawia się strona główna aplikacji MeasureYourLife
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się strona rejestracji aplikacji MeasureYourLife
1. Wypełnia pole „E-mail” danymi „janusz.testowy6@gmail.com”
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek5”
1. Wypełnia pole „Hasło” „Test12!@”
1. Wypełnia pole „Powtórz hasło” „Test12!@”
1. Naciska button „Zakładam konto”
1. SPRAWDZA: nad polem „Login” pojawia się komunikat „Nie udało się zarejestrować. Spróbuj jeszcze raz.”

### Szósty przypadek - test sprawdza możliwość rejestracji drugi raz w aplikacji za pomocą już istniejącego w bazie maila
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się strona rejestracji aplikacji MeasureYourLife
1. Wypełnia pole „E-mail” danymi „janusz.testowy6@gmail.com”
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek6”
1. Wypełnia pole „Hasło” „Test12!@”
1. Wypełnia pole „Powtórz hasło” „Test12!@”
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się popup z komunikatem "Na Twoje konto e-mail wysłaliśmy maila weryfikacyjnego"
1. Potwierdza adres e-mail.
1. Otwiera stronę logowania.
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek6”
1. Wypełnia pole „Hasło” „Test12!@”
1. Naciska button „Loguję się”
1. SPRAWDZA: pojawia się strona aktywności
1. Wylogowuje się.
1. Pojawia się strona główna aplikacji MeasureYourLife
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się strona rejestracji aplikacji MeasureYourLife
1. Wypełnia pole „E-mail” danymi „janusz.testowy6@gmail.com”
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek7”
1. Wypełnia pole „Hasło” „Test12!@”
1. Wypełnia pole „Powtórz hasło” „Test12!@”
1. Naciska button „Zakładam konto”
1. SPRAWDZA: nad polem „E-mail” pojawia się komunikat „Nie udało się zarejestrować. Spróbuj jeszcze raz.”


### Siódmy przypadek - test sprawdza możliwość rejestracji w aplikacji, wypełnione wszystkie pola krótkim ciągiem znaków
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska button „Zakładam konto”
1. SPRAWDZA: pojawia się strona rejestracji aplikacji MeasureYourLife
1. Wypełnia pole „E-mail” danymi „aa”
1. Wypełnia pole „Login” danymi „aa”
1. Wypełnia pole „Hasło” „aa”
1. Wypełnia pole „Powtórz hasło” „aa”
1. Naciska button „Zakładam konto”
1. SPRAWDZA: nad polem „E-mail” pojawia się komunikat „Nie prawidłowy format adresu e-mail”
1. SPRAWDZA: nad polem „Login” pojawia się komunikat „Login powinien składać się z co najmniej czterech znaków”
1. SPRAWDZA: nad polem „Hasło” pojawia się komunikat „Hasło powinno składać się z co najmniej sześciu znaków, w tym zawierać dwa rodzaje znaków spośród małych i wielkich liter, cyfr i znaków specjalnych.”
1. SPRAWDZA: nad polem „Powtórz hasło” pojawia się komunikat „Hasło jest zbyt krótkie”
