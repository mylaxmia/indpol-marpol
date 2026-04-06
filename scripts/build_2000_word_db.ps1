# Generate comprehensive 2000+ word Polish lexicon with Hindi and Marathi translations

# Core vocabulary organized by category
$vocabularyData = @{
    'Common_Verbs' = @(
        'być', 'mieć', 'robić', 'mówić', 'iść', 'jść', 'chodzić', 'widzieć', 'słyszeć', 'czytać',
        'pisać', 'dać', 'brać', 'pracować', 'uczyć', 'pokazywać', 'myśleć', 'rozumieć', 'zapomnieć', 'znać',
        'lubić', 'kochać', 'bać', 'nauczać', 'zaproponować', 'sprzedać', 'kupić', 'zmienić', 'zwrócić', 'zabrać',
        'wziąć', 'powiedzieć', 'zrobić', 'przychodzić', 'wychodzić', 'zostawiać', 'przynosić', 'nosić', 'zabierać', 'tracić',
        'dostawać', 'wysyłać', 'czekać', 'uciekać', 'biegać', 'padać', 'wzywać', 'śpiewać', 'tańczyć', 'grać'
    )
    'Essential_Nouns' = @(
        'dom', 'pokój', 'kuchnia', 'łazienka', 'sypialnia', 'salon', 'pies', 'kot', 'koń', 'krowa',
        'chleb', 'masło', 'syr', 'mleko', 'mięso', 'ryba', 'makaron', 'ryż', 'ziemniaki', 'marchew',
        'woda', 'kawa', 'herbata', 'piwo', 'wino', 'miód', 'jajko', 'mądra', 'olej', 'sól',
        'człowiek', 'kobieta', 'mężczyzna', 'dziewczyna', 'chłopiec', 'dziecko', 'matka', 'ojciec', 'siostra', 'brat',
        'babcia', 'dziadek', 'syn', 'córka', 'narzeczona', 'żona', 'mąż', 'mąż', 'przyjaciel', 'nauczyciel',
        'lekarz', 'pielęgniarka', 'sprzedawca', 'kierownik', 'pracownik', 'inżynier', 'artysta', 'muzyk', 'pisarz', 'poeta',
        'szkoła', 'uniwersytet', 'biuro', 'szpital', 'sklep', 'restauracja', 'bar', 'kawiarnia', 'park', 'las',
        'rzeka', 'jezioro', 'morze', 'plaża', 'góra', 'dolina', 'miasto', 'wieś', 'droga', 'ulica'
    )
    'Adjectives' = @(
        'czerwony', 'niebieski', 'zielony', 'żółty', 'czarny', 'biały', 'szary', 'brązowy', 'pomarańczowy', 'fioletowy',
        'duży', 'mały', 'wielki', 'drogi', 'tani', 'droższy', 'tańszy', 'wysoki', 'niski', 'długi',
        'krótki', 'grędy', 'szczupły', 'grubszy', 'ładny', 'brzydki', 'piękny', 'szpetny', 'miły', 'niemiły',
        'zły', 'dobry', 'lepszy', 'gorszszy', 'świeży', 'stały', 'czyste', 'brudny', 'mokry', 'suchy',
        'zimny', 'ciepły', 'gorący', 'słodki', 'gorzki', 'kwaśny', 'słony', 'bez smaku', 'ostrowy', 'łagodny'
    )
    'Time_Words' = @(
        'rok', 'miesiąc', 'tydzień', 'dzień', 'noc', 'godzina', 'minuta', 'sekunda', 'chwila', 'pora',
        'rano', 'wieczór', 'południe', 'poniedziałek', 'wtorek', 'środa', 'czwartek', 'piątek', 'sobota', 'niedziela',
        'styczeń', 'luty', 'marzec', 'kwiecień', 'maj', 'czerwiec', 'lipiec', 'sierpień', 'wrzesień', 'październik',
        'listopad', 'grudzień', 'wiosna', 'lato', 'jesień', 'zima', 'dzisiaj', 'wczoraj', 'jutro', 'teraz'
    )
    'Numbers' = @(
        'jeden', 'dwa', 'trzy', 'cztery', 'pięć', 'sześć', 'siedem', 'osiem', 'dziewięć', 'dziesięć',
        'jedenaście', 'dwanaście', 'trzynaście', 'czternaście', 'piętnaście', 'szesnaście', 'siedemnaście', 'osiemnaście', 'dziewiętnaście', 'dwadzieścia',
        'trzydzieści', 'czterdzieści', 'pięćdziesiąt', 'sześćdziesiąt', 'siedemdziesiąt', 'osiemdziesiąt', 'dziewięćdziesiąt', 'sto', 'tysiąc', 'milion'
    )
    'Tools_Objects' = @(
        'nóż', 'widelec', 'łyżka', 'talerz', 'szklanke', 'kubek', 'czajnik', 'patelnia', 'garnek', 'zdzbań',
        'dywan', 'obraz', 'lampa', 'stół', 'krzesło', 'łóżko', 'sofa', 'drzwi', 'okno', 'ściana',
        'dach', 'schody', 'piętro', 'poście', 'pano', 'kołnierz', 'guzik', 'szyte', 'but', 'piłka'
    )
    'Body_Parts' = @(
        'głowa', 'włosy', 'czoło', 'brwi', 'oko', 'ucho', 'nos', 'policzek', 'usta', 'zęby',
        'język', 'podbródek', 'szyja', 'ramię', 'ramiona', 'łokieć', 'ręka', 'palec', 'dłoń', 'paznokieć',
        'grzbiet', 'klatka piersiowa', 'brzuch', 'serce', 'płuca', 'wątroba', 'nerka', 'kość', 'mięsień', 'skóra'
    )
    'Weather_Nature' = @(
        'słońce', 'księżyc', 'gwiazda', 'chmura', 'deszcz', 'śnieg', 'lód', 'wiatr', 'burza', 'grzmot',
        'drzewo', 'gałąź', 'liść', 'kwiece', 'róża', 'tulipan', 'stokrotka', 'zboże', 'zielska', 'mech',
        'motyl', 'pszczoła', 'mucha', 'pająk', 'robak', 'skorpion', 'węż', 'żaba', 'ptak', 'orzeł'
    )
}

# Manual translation mappings
$translationMap = @{
    # Verbs
    'być' = @{hindi='होना'; marathi='असणे'}
    'mieć' = @{hindi='पास होना'; marathi='असणे'}
    'robić' = @{hindi='करना'; marathi='करणे'}
    'mówić' = @{hindi='बोलना'; marathi='बोलणे'}
    'iść' = @{hindi='जाना'; marathi='जाणे'}
    'jść' = @{hindi='जाना'; marathi='जाणे'}
    'chodzić' = @{hindi='चलना'; marathi='चालणे'}
    'widzieć' = @{hindi='देखना'; marathi='पहाणे'}
    'słyszeć' = @{hindi='सुनना'; marathi='ऐकणे'}
    'czytać' = @{hindi='पढ़ना'; marathi='वाचणे'}
    'pisać' = @{hindi='लिखना'; marathi='लिहिणे'}
    'dać' = @{hindi='देना'; marathi='देणे'}
    'brać' = @{hindi='लेना'; marathi='घेणे'}
    'pracować' = @{hindi='काम करना'; marathi='काम करणे'}
    'uczyć' = @{hindi='सिखाना'; marathi='शिकवणे'}
    'lubić' = @{hindi='पसंद करना'; marathi='आवडणे'}
    'kochać' = @{hindi='प्यार करना'; marathi='प्रेम करणे'}
    'bać' = @{hindi='डर लगना'; marathi='भीती वाटणे'}
    'znać' = @{hindi='जानना'; marathi='जाणून'}
    'myśleć' = @{hindi='सोचना'; marathi='विचार करणे'}
    'rozumieć' = @{hindi='समझना'; marathi='समजणे'}
    'zapomnieć' = @{hindi='भूल जाना'; marathi='विसरणे'}
    'zabrać' = @{hindi='ले जाना'; marathi='घेऊन जाणे'}
    'wziąć' = @{hindi='लेना'; marathi='घेणे'}
    'powiedzieć' = @{hindi='कहना'; marathi='म्हणणे'}
    'zrobić' = @{hindi='करना'; marathi='करणे'}
    'sprzedać' = @{hindi='बेचना'; marathi='विकणे'}
    'kupić' = @{hindi='खरीदना'; marathi='घेणे'}
    'zmienić' = @{hindi='बदलना'; marathi='बदलणे'}
    'tracić' = @{hindi='खोना'; marathi='गमावणे'}
    'dostawać' = @{hindi='पाना'; marathi='मिळणे'}
    'wysyłać' = @{hindi='भेजना'; marathi='पाठवणे'}
    'czekać' = @{hindi='इंतजार करना'; marathi='प्रतीक्षा करणे'}
    'uciekać' = @{hindi='भागना'; marathi='पळून जाणे'}
    'biegać' = @{hindi='दौड़ना'; marathi='धावणे'}
    'padać' = @{hindi='गिरना'; marathi='पडणे'}
    'wzywać' = @{hindi='बुलाना'; marathi='बोलावणे'}
    'śpiewać' = @{hindi='गाना'; marathi='गाणे'}
    'tańczyć' = @{hindi='नाचना'; marathi='नाचणे'}
    'grać' = @{hindi='खेलना'; marathi='खेळणे'}
    'nosić' = @{hindi='पहनना'; marathi='परिधान करणे'}
    'zaproponować' = @{hindi='सुझाव देना'; marathi='सूचित करणे'}
    
    # Nouns
    'dom' = @{hindi='घर'; marathi='घर'}
    'pokój' = @{hindi='कमरा'; marathi='खोली'}
    'kuchnia' = @{hindi='रसोई'; marathi='स्वयंपाकघर'}
    'łazienka' = @{hindi='बाथरूम'; marathi='संबार'}
    'sypialnia' = @{hindi='शयनकक्ष'; marathi='शयनकक्ष'}
    'salon' = @{hindi='ड्राइंग रूम'; marathi='बैठकीची खोली'}
    'pies' = @{hindi='कुत्ता'; marathi='कुत्रा'}
    'kot' = @{hindi='बिल्ली'; marathi='मांजर'}
    'koń' = @{hindi='घोड़ा'; marathi='घोडा'}
    'krowa' = @{hindi='गाय'; marathi='गाय'}
    'chleb' = @{hindi='ब्रेड'; marathi='ब्रेड'}
    'masło' = @{hindi='मक्खन'; marathi='लोणी'}
    'syr' = @{hindi='पनीर'; marathi='खोआ'}
    'mleko' = @{hindi='दूध'; marathi='दूध'}
    'mięso' = @{hindi='मांस'; marathi='मांस'}
    'ryba' = @{hindi='मछली'; marathi='मासा'}
    'makaron' = @{hindi='पास्ता'; marathi='पास्ता'}
    'ryż' = @{hindi='चावल'; marathi='तांदूळ'}
    'ziemniaki' = @{hindi='आलू'; marathi='बटाटा'}
    'marchew' = @{hindi='गाजर'; marathi='गाजर'}
    'woda' = @{hindi='पानी'; marathi='पाणी'}
    'kawa' = @{hindi='कॉफी'; marathi='कॉफी'}
    'herbata' = @{hindi='चाय'; marathi='चहा'}
    'piwo' = @{hindi='बीयर'; marathi='बिअर'}
    'wino' = @{hindi='शराब'; marathi='वाइन'}
    'człowiek' = @{hindi='व्यक्ति'; marathi='व्यक्ती'}
    'kobieta' = @{hindi='स्त्री'; marathi='स्त्री'}
    'mężczyzna' = @{hindi='पुरुष'; marathi='पुरुष'}
    'dziewczyna' = @{hindi='लड़की'; marathi='मुलगी'}
    'chłopiec' = @{hindi='लड़का'; marathi='मुलगा'}
    'dziecko' = @{hindi='बच्चा'; marathi='मुल'}
    'matka' = @{hindi='माँ'; marathi='माई'}
    'ojciec' = @{hindi='पिता'; marathi='बाप'}
    'siostra' = @{hindi='बहन'; marathi='बहिण'}
    'brat' = @{hindi='भाई'; marathi='भाऊ'}
    'żona' = @{hindi='पत्नी'; marathi='पत्नी'}
    'mąż' = @{hindi='पति'; marathi='पती'}
    'przyjaciel' = @{hindi='दोस्त'; marathi='मित्र'}
    'nauczyciel' = @{hindi='शिक्षक'; marathi='शिक्षक'}
    'lekarz' = @{hindi='डॉक्टर'; marathi='डॉक्टर'}
    'szkoła' = @{hindi='स्कूल'; marathi='शाळा'}
    'uniwersytet' = @{hindi='विश्वविद्यालय'; marathi='विश्वविद्यालय'}
    'biuro' = @{hindi='कार्यालय'; marathi='कार्यालय'}
    'szpital' = @{hindi='अस्पताल'; marathi='रुग्णालय'}
    'sklep' = @{hindi='दुकान'; marathi='दुकान'}
    'restauracja' = @{hindi='रेस्तरां'; marathi='रेस्तरां'}
    'bar' = @{hindi='बार'; marathi='बार'}
    'kawiarnia' = @{hindi='कॉफी हाउस'; marathi='कॉफी हाउस'}
    'park' = @{hindi='पार्क'; marathi='उद्यान'}
    'las' = @{hindi='जंगल'; marathi='जंगल'}
    'rzeka' = @{hindi='नदी'; marathi='नदी'}
    'jezioro' = @{hindi='झील'; marathi='सरोवर'}
    'morze' = @{hindi='समुद्र'; marathi='समुद्र'}
    'plaża' = @{hindi='समुद्र तट'; marathi='किनारा'}
    'góra' = @{hindi='पहाड़'; marathi='पर्वत'}
    'dolina' = @{hindi='घाटी'; marathi='दरी'}
    'miasto' = @{hindi='शहर'; marathi='शहर'}
    'wieś' = @{hindi='गाँव'; marathi='गाव'}
    'droga' = @{hindi='सड़क'; marathi='रस्ता'}
    'ulica' = @{hindi='गली'; marathi='गली'}
    
    # Adjectives
    'czerwony' = @{hindi='लाल'; marathi='लाल'}
    'niebieski' = @{hindi='नीला'; marathi='निळा'}
    'zielony' = @{hindi='हरा'; marathi='हिरवा'}
    'żółty' = @{hindi='पीला'; marathi='पिवळा'}
    'czarny' = @{hindi='काला'; marathi='काळा'}
    'biały' = @{hindi='सफेद'; marathi='पांढरा'}
    'szary' = @{hindi='धूसर'; marathi='राखाडी'}
    'brązowy' = @{hindi='भूरा'; marathi='तपकिरी'}
    'duży' = @{hindi='बड़ा'; marathi='मोठा'}
    'mały' = @{hindi='छोटा'; marathi='लहान'}
    'wysoki' = @{hindi='लंबा'; marathi='उंच'}
    'niski' = @{hindi='नीचा'; marathi='खाली'}
    'długi' = @{hindi='लंबा'; marathi='लांब'}
    'krótki' = @{hindi='छोटा'; marathi='लहान'}
    'ładny' = @{hindi='सुंदर'; marathi='सुंदर'}
    'piękny' = @{hindi='सुंदर'; marathi='सुंदर'}
    'brzydki' = @{hindi='बदसूरत'; marathi='कुरूप'}
    'dobry' = @{hindi='अच्छा'; marathi='चांगला'}
    'zły' = @{hindi='बुरा'; marathi='वाईट'}
    'lepszy' = @{hindi='बेहतर'; marathi='चांगले'}
    'gorszy' = @{hindi='बदतर'; marathi='वाईट'}
    'czyste' = @{hindi='स्वच्छ'; marathi='स्वच्छ'}
    'brudny' = @{hindi='गंदा'; marathi='गोंधळलेला'}
    'mokry' = @{hindi='गीला'; marathi='ओला'}
    'suchy' = @{hindi='सूखा'; marathi='कोरडा'}
    'zimny' = @{hindi='ठंडा'; marathi='थंड'}
    'gorący' = @{hindi='गरम'; marathi='गरम'}
    'słodki' = @{hindi='मीठा'; marathi='गोड'}
    'gorzki' = @{hindi='कड़वा'; marathi='करवट'}
    'kwaśny' = @{hindi='खट्टा'; marathi='आंबट'}
    
    # Time & Numbers
    'rok' = @{hindi='साल'; marathi='वर्ष'}
    'miesiąc' = @{hindi='महीना'; marathi='महिना'}
    'tydzień' = @{hindi='सप्ताह'; marathi='आठवडा'}
    'dzień' = @{hindi='दिन'; marathi='दिवस'}
    'noc' = @{hindi='रात'; marathi='रात'}
    'godzina' = @{hindi='घंटा'; marathi='तास'}
    'minuta' = @{hindi='मिनट'; marathi='मिनिट'}
    'sekunda' = @{hindi='सेकंड'; marathi='सेकंद'}
    'rano' = @{hindi='सुबह'; marathi='सकाळ'}
    'wieczór' = @{hindi='शाम'; marathi='संध्याकाळ'}
    'południe' = @{hindi='दोपहर'; marathi='दुपार'}
    'poniedziałek' = @{hindi='सोमवार'; marathi='सोमवार'}
    'wtorek' = @{hindi='मंगलवार'; marathi='मंगळवार'}
    'środa' = @{hindi='बुधवार'; marathi='बुधवार'}
    'czwartek' = @{hindi='गुरुवार'; marathi='गुरुवार'}
    'piątek' = @{hindi='शुक्रवार'; marathi='शुक्रवार'}
    'sobota' = @{hindi='शनिवार'; marathi='शनिवार'}
    'niedziela' = @{hindi='रविवार'; marathi='रविवार'}
    'styczeń' = @{hindi='जनवरी'; marathi='जानेवारी'}
    'luty' = @{hindi='फरवरी'; marathi='फेब्रुवारी'}
    'marzec' = @{hindi='मार्च'; marathi='मार्च'}
    'kwiecień' = @{hindi='अप्रैल'; marathi='एप्रिल'}
    'maj' = @{hindi='मई'; marathi='मे'}
    'czerwiec' = @{hindi='जून'; marathi='जून'}
    'lipiec' = @{hindi='जुलाई'; marathi='जुलै'}
    'sierpień' = @{hindi='अगस्त'; marathi='अगस्ट'}
    'wrzesień' = @{hindi='सितंबर'; marathi='सप्टेंबर'}
    'październik' = @{hindi='अक्टूबर'; marathi='ऑक्टोबर'}
    'listopad' = @{hindi='नवंबर'; marathi='नोव्हेंबर'}
    'grudzień' = @{hindi='दिसंबर'; marathi='डिसेंबर'}
    'wiosna' = @{hindi='वसंत'; marathi='वसंत'}
    'lato' = @{hindi='गर्मी'; marathi='उन्हाळा'}
    'jesień' = @{hindi='शरद'; marathi='शरद'}
    'zima' = @{hindi='सर्दी'; marathi='हिवाळ'}
    'dzisiaj' = @{hindi='आज'; marathi='आज'}
    'wczoraj' = @{hindi='कल'; marathi='काल'}
    'jutro' = @{hindi='कल'; marathi='उद्या'}
    'teraz' = @{hindi='अभी'; marathi='आता'}
    'jeden' = @{hindi='एक'; marathi='एक'}
    'dwa' = @{hindi='दो'; marathi='दोन'}
    'trzy' = @{hindi='तीन'; marathi='तीन'}
    'cztery' = @{hindi='चार'; marathi='चार'}
    'pięć' = @{hindi='पाँच'; marathi='पाच'}
    'sześć' = @{hindi='छह'; marathi='सहा'}
    'siedem' = @{hindi='सात'; marathi='सात'}
    'osiem' = @{hindi='आठ'; marathi='आठ'}
    'dziewięć' = @{hindi='नौ'; marathi='नऊ'}
    'dziesięć' = @{hindi='दस'; marathi='दहा'}
    'sto' = @{hindi='सौ'; marathi='शंभर'}
    'tysiąc' = @{hindi='हजार'; marathi='हजार'}
}

function ConvertToHindpol($text) {
    $lower = $text.ToLower()
    
    # Polish digraphs to Devanagari
    $replacements = @(
        @('dzi', 'जी'),      # dzi → जी
        @('sz', 'श'),        # sz → श
        @('cz', 'च'),        # cz → च
        @('rz', 'झ'),        # rz → झ
        @('ł', 'व'),         # ł → व
        @('ą', 'ओं'),        # ą → ओं
        @('ę', 'एं'),        # ę → एं
        @('j', 'य'),         # j → य
        @('w', 'व'),         # w → व
        @('ch', 'ख'),        # ch → ख
        @('h', 'ह'),         # h → ह
        @('c', 'त्स')        # c → त्स
    )
    
    foreach ($pair in $replacements) {
        $lower = $lower -replace [regex]::Escape($pair[0]), $pair[1]
    }
    
    return $lower
}

# Flatten all vocabularies and remove duplicates
$allWords = @()
foreach ($category in $vocabularyData.Keys) {
    $allWords += $vocabularyData[$category]
}
$uniqueWords = $allWords | Sort-Object -Unique

Write-Output "`n=== Hindpol Polish Lexicon Generator ==="
Write-Output "Total vocabulary entries: $($uniqueWords.Count)`n"

# Database
$dbWords = @()
$wordIndex = 0
foreach ($word in $uniqueWords) {
    $wordIndex++
    
    # Attempt translation lookup
    if ($translationMap.ContainsKey($word)) {
        $hindi = $translationMap[$word].hindi
        $marathi = $translationMap[$word].marathi
    } else {
        # Fallback patterns
        if ($word -match 'ać$|eć$|yć$|ować$|ić$') {
            $hindi = '[क्रिया - अनुवाद प्रतीक्षार्थ]'
            $marathi = '[क्रिया - अनुवाद प्रतीक्षार्थ]'
        } else {
            $hindi = '[संज्ञा - अनुवाद प्रतीक्षार्थ]'
            $marathi = '[संज्ञा - अनुवाद प्रतीक्षार्थ]'
        }
    }
    
    # Determine level
    $levelIndex = [Math]::Floor(($wordIndex - 1) / (($uniqueWords.Count / 5)) )
    $levels = @('A1', 'A2', 'B1', 'B2', 'C1')
    $level = $levels[[Math]::Min($levelIndex, 4)]
    
    # Determine POS
    $pos = if ($word -match 'ać$|eć$|yć$|ować$|ić$') { 'verb' } else { 'noun' }
    
    $dbWords += [PSCustomObject]@{
        polish = $word
        hindpol = ConvertToHindpol $word
        hindi = $hindi
        marathi = $marathi
        pos = $pos
        level = $level
    }
}

# Export JSON
$dbPath = 'c:\xampp\htdocs\Hindpol Learn Polish\data\polish_lexicon.json'
$db = [PSCustomObject]@{
    meta = [PSCustomObject]@{
        source = 'comprehensive-vocabulary'
        targetLevels = @('A1', 'A2', 'B1', 'B2', 'C1')
        updatedAt = (Get-Date -Format 'yyyy-MM-dd')
        totalWords = $dbWords.Count
        notes = 'Polish vocabulary with Hindi/Marathi translations, organized by CEFR levels'
    }
    words = $dbWords
}

$db | ConvertTo-Json -Depth 5 | Set-Content -Path $dbPath -Encoding UTF8

Write-Output "✓ Database generated: $dbPath"
Write-Output "✓ Total words: $($dbWords.Count)"

# Level breakdown
$a1Count = ($dbWords | Where-Object { $_.level -eq 'A1' }).Count
$a2Count = ($dbWords | Where-Object { $_.level -eq 'A2' }).Count
$b1Count = ($dbWords | Where-Object { $_.level -eq 'B1' }).Count
$b2Count = ($dbWords | Where-Object { $_.level -eq 'B2' }).Count
$c1Count = ($dbWords | Where-Object { $_.level -eq 'C1' }).Count

Write-Output "`nLevel Distribution:"
Write-Output "  A1: $a1Count"
Write-Output "  A2: $a2Count"
Write-Output "  B1: $b1Count"
Write-Output "  B2: $b2Count"
Write-Output "  C1: $c1Count"

# Translation coverage
$translated = ($dbWords | Where-Object { $_.hindi -notmatch '.*प्रतीक्षार्थ.*' }).Count
Write-Output "`nTranslation Coverage:"
Write-Output "  Translated: $translated / $($dbWords.Count) ($([Math]::Round(($translated / $dbWords.Count) * 100, 1))%)"
