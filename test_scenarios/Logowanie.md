## Logowanie do aplikacji MeasureYourLife

### Pierwszy przypadek - test sprawdza czy można zalogować się bez wypełnienia pól formularza
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska button „Zaloguj mnie”
1. SPRAWDZA: pod polem „Login” pojawia się komunikat „Pole jest wymagane”
1. SPRAWDZA: pod polem „Hasło” pojawia się komunikat „Pole jest wymagane”

### Drugi przypadek - test sprawdza możliwość zalogowania się istniejącym w bazie loginem
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Wypełnia pole „Login” danymi „JanuszekKopciuszek7”
1. Wypełnia pole „Hasło” danymi „Test12!@”
1. Naciska button „Zaloguj mnie”
1. SPRAWDZA: pojawia się strona aktywności

### Trzeci przypadek - test sprawdza niemożność zalogowania się istniejącym w bazie loginem, przy użyciu nieprawidłowego hasło
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Wypełnia pole „Login” danymi „JanuszekKopciusszek7”
1. Wypełnia pole „Hasło” danymi „Test12!@blabla”
1. Naciska button „Zaloguj mnie”
1. SPRAWDZA: pojawia się popup z komunikatem „Podałeś nieprawidłowe dane”

### Czwarty przypadek - test sprawdza niemożność zalogowania się nieistniejącym w bazie loginem, przy użyciu nieprawidłowego hasło
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Wypełnia pole „Login” danymi „JankaSkakanka”
1. Wypełnia pole „Hasło” danymi „Test12!@blabla”
1. Naciska button „Zaloguj mnie”
1. SPRAWDZA: pojawia się komunikat „Podałeś nieprawidłowe dane”

### Piąty przypadek - test sprawdza czy działa link do rejestracji
1. Otwiera stronę główną aplikacji MeasureYourLife
1. Naciska button „Zarejestruj się"
1. SPRAWDZA: pojawia się strona rejestracji
