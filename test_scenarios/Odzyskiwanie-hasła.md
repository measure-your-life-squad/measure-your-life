## Odzyskiwanie hasła MeasureYourLife

### Pierwszy przypadek - test sprawdza czy można odzyskać hasło podając istniejący w bazie mail
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska link „Odzyskaj hasło”
1. SPRAWDZA: pojawia się strona „Odzyskiwanie hasła”
1. Wypełnia pole „E-mail” danymi „janusz.testowy@gmail.com”
1. Naciska button „Wyślij”
1. SPRAWDZA: Pojawia się komunikat „Instrukcje przywracania hasła zostały wysłane na Twój adres e-mail”
1. SPRAWDZA: w skrzynce mailowej znajduje się mail z linkiem
1. Naciska link.
1. Wypełnia pole "Nowe hasło" danymi "abc12!@"
1. Wypełnia pole "Powtórz hasło" danymi "abc12!@#"
1. Naciska button "Zapisz"
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek”
1. Wypełnia pole „Hasło” danymi „abc12!@”
1. Naciska button „Zaloguj mnie”
1. SPRAWDZA: pojawia się strona aktywności

### Drugi przypadek - test sprawdza czy można odzyskać hasło podając nieistniejący w bazie mail
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska link „Odzyskaj hasło”
1. SPRAWDZA: pojawia się strona „Odzyskiwanie hasła”
1. Wypełnia pole „E-mail” danymi „nieistniejacymail@gmail.com”
1. Naciska button „Wyślij”
1. SPRAWDZA: Pojawia się komunikat „Nieudało się wysłać linka. Spróbuj później”

### Trzeci przypadek - test sprawdza sprawdza zachowanie formularza odzyskiwania hasła bez wypełnienia pól
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska link „Odzyskaj hasło”
1. SPRAWDZA: pojawia się strona „Odzyskiwanie hasła”
1. Naciska button „Wyślij”
1. SPRAWDZA: nad polem „E-mail” pojawia się komunikat „Pole jest wymagane.”
