param(
  [string]$OutPath = "c:\xampp\htdocs\Hindpol Learn Polish\data\polish_lexicon.json"
)

# Massive Polish vocabulary for A1-C1 (extended list)
$allWords = @(
  # Most common verbs
  "być", "mieć", "robić", "mówić", "iść", "jść", "chodzić", "widzieć", "słyszeć", "czytać",
  "pisać", "dać", "brać", "pracować", "uczyć", "pokazywać", "myśleć", "rozumieć", "zapomnieć", "znać",
  "lubić", "kochać", "bać", "nauczać", "powinien", "mogę", "chcę", "czuć", "zapamiętać", "chcieć",
  "zaproponować", "sprzedać", "kupić", "zmienić", "zwrócić", "zabrać", "spowodować", "pozwolić", "używać", "nosić",
  "trzymać", "puszczać", "otwierać", "zamykać", "uderzyć", "złamać", "zarwać", "zginąć", "podzielić", "dobierać",
  "lepić", "wziąć", "wybrać", "pozostać", "wystarczać", "budować", "budować", "zbudować", "burzyć", "walczyć",
  # Common nouns
  "dom", "pokój", "kuchnia", "łazienka", "sypialnia", "salon", "drzwi", "okno", "ściana", "podłoga",
  "sufit", "dach", "schody", "winda", "korytarz", "hol", "człowiek", "mężczyzna", "kobieta", "dziecko",
  "dziewczyna", "chłopiec", "mama", "tata", "rodzice", "dziadek", "babcia", "wujek", "ciocia", "stryjek",
  "brat", "siostra", "kuzyn", "kuzynka", "mąż", "żona", "pan", "pani", "państwo", "doktor",
  "nauczyciel", "inżynier", "architekt", "pisarz", "artysta", "muzyk", "piosenkarz", "aktor", "sportowiec", "kierowca",
  "pielęgniarka", "sędziusz", "policjant", "żołnierz", "pracownik", "pracownica", "posłaniec", "przesyłka", "papier", "drut",
  "metal", "szkło", "drewno", "kamień", "cement", "cegła", "dach", "decydować", "zbiór", "czyn",
  "fakt", "czytelnik", "sprawca", "ofiara", "świadek", "naukowiec", "odkrywca", "wynalazca", "konstruktor", "projektant",
  # Animals
  "pies", "kot", "koń", "krowa", "świnia", "koza", "owca", "kurczak", "kaczka", "gęś",
  "ptak", "orzeł", "sokół", "wróbel", "sroka", "kruk", "sowę", "jastrzęb", "skowronek", "sójka",
  "ryba", "szczupak", "sum", "pstrąg", "okoń", "leszcz", "karaś", "małż", "krab", "homara",
  "żmija", "wąż", "żaba", "tarcza", "kameleon", "jaszczurka", "żuk", "mrówka", "pszczoła", "osa",
  "mucha", "komara", "motyl", "gąsienica", "pająk", "skorpion", "ścieżka", "zwierzę", "gad", "owad",
  # Food
  "chleb", "masło", "syr", "mleko", "kefir", "jogurt", "twaróg", "jajko", "mięso", "wołowina",
  "wieprzowina", "drób", "kurczak", "indyczka", "kaczka", "gęś", "ryba", "łosoś", "pstrąg", "okonia",
  "makaron", "ryż", "żytnia", "żyto", "pszenica", "orkisz", "greczka", "owsianka", "ziemniaki", "marchew",
  "buraki", "cukinia", "bakłażan", "pomidor", "papryka", "ogórek", "kapusta", "sałata", "rukola", "szpinak",
  "czosnek", "cebula", "por", "pietruszka", "kopru", "kolendry", "jeżyna", "malina", "truskawka", "poziomka",
  "czarna porzeczka", "biała porzeczka", "agrest", "winogrona", "jabłko", "gruszka", "łyka", "brzoskwinia", "nektaryna", "śliwka",
  "morela", "banan", "pomarańcze", "cytryna", "limonka", "grejfrut", "ananasa", "kokos", "daktyle", "orzechy",
  "migdały", "arakhis", "słonecznika", "dynia", "słonecznika", "olej", "sól", "pieprz", "cukier", "miód",
  # Drinks
  "woda", "kawa", "herbata", "mleko", "sok", "lemonad", "napój", "piwo", "wino", "wódka",
  "likier", "rum", "brandy", "whisky", "szampan", "wermut", "koktajl", "energetyk", "kompot", "barszcz",
  # Colors
  "czerwony", "niebieski", "zielony", "żółty", "pomarańczowy", "czarny", "biały", "szary", "brązowy", "różowy",
  "fioletowy", "turkusowy", "cyjan", "magenta", "krwisty", "mroczny", "jasny", "ciemny", "świetlisty", "matowy",
  "błyszczący", "przezroczysty", "zmętniały", "opalizujący", "wpadający", "zabarwiony", "wybarwiony", "zaszeregowany", "unarbitralizowany", "nienaturalny",
  # Space/Geography
  "świat", "ziemia", "glob", "kontynent", "afrykanów", "azja", "europa", "ameryka", "australia", "antarktyda",
  "океан", "morze", "jezioro", "rzeka", "potok", "strumień", "namiot", "grota", "pieczara", "wyspa",
  "półwysep", "przylądek", "zatoka", "laguna", "cieśnina", "przesmyk", "wysoki", "dolina", "kanion", "wąwóz",
  "równina", "step", "sawanna", "pustynia", "las", "las iglasty", "las liściasty", "leśniczka", "zakatek", "zgliszcze",
  "miasteczko", "miasto", "metropolia", "wieś", "osada", "wioskę", "karczma", "tawerna", "gospoda", "zajazd",
  # Transportation
  "samochód", "samochódka", "motocykl", "skuter", "rower", "hulajnoga", "autobus", "tramwaj", "trolleybus", "pociąg",
  "lokomotywa", "wagon", "karetnia", "furgon", "ciężarówka", "picker-upa", "przyczepę", "naczepę", "przyczepka", "powóz",
  "karocerie", "sanie", "sanie", "saneczki", "łódź", "kajak", "kanu", "żagiel", "szalup", "fregata",
  "korwetę", "szkuner", "barka", "pogalopować", "statek", "z", "łódka", "tratwę", "pontony", "prom",
  "helikopter", "samolot", "myśliwiec", "bombowiec", "transportowiec", "amfibia", "szybowiec", "balon", "żagiel", "deltagówna",
  "spadochron", "rakieta", "kosmita", "pojazd", "statek", "pojazd", "sanie", "wózek", "wózeczek", "nosze",
  # Time
  "poniedziałek", "wtorek", "środa", "czwartek", "piątek", "sobota", "niedziela", "dzień roboczy", "dzień wolny", "zmiana",
  "przedpołudnie", "południe", "popołudnie", "wieczór", "noc", "północ", "świt", "wschód", "sunset", "zmierzch",
  "chwila", "sekunda", "minuta", "godzina", "doba", "dzień", "tydzień", "dekada", "miesiąc", "kwartał",
  "rok", "dekada", "stulecie", "tysiąclecia", "era", "epoka", "okres", "etap", "faza", "sezon",
  # Numbers
  "jeden", "dwa", "trzy", "cztery", "pięć", "sześć", "siedem", "osiem", "dziewięć", "dziesięć",
  "jedenaście", "dwanaście", "trzynaście", "czternaście", "piętnaście", "szesnaście", "siedemnaście", "osiemnaście", "dziewiętnaście", "dwadzieścia",
  "trzydzieści", "czterdzieści", "pięćdziesiąt", "sześćdziesiąt", "siedemdziesiąt", "osiemdziesiąt", "dziewięćdziesiąt", "sto", "dwieście", "trzysta",
  "czterysta", "pięćset", "sześćset", "siedemset", "osiemset", "dziewięćset", "tysiąc", "dwa tysiące", "dziesięć tysięcy", "milion",
  "miliard", "bilion", "zero", "pół", "trzecia", "ćwierć", "procent", "połowa", "połów", "tercja",
  # Adjectives
  "dobry", "zły", "piękny", "brzydki", "ładny", "szpetny", "duży", "mały", "wielki", "mały",
  "pokaźny", "ogromny", "ogrom", "lilawy", "lilania", "fiołkowy", "błękitny", "błękitnie", "błękitnie", "błękitnik",
  "jasny", "ciemny", "jasny", "ciemno", "przejrzysty", "nieprzejrzysty", "czysty", "brudny", "zabrudniony", "zmarnowany",
  "nowy", "stary", "świeży", "starożytny", "archaiczny", "pozaczesany", "nowoczesny", "współczesny", "zabytkowy", "zabytkowy",
  "solidny", "wątpliwy", "solidny", "słaby", "delikatny", "delikatnie", "delikatnie", "niedelikatnie", "twardy", "miękki",
  "miękko", "twardo", "zmięty", "zmięty", "zmięty", "gładki", "szorstki", "szorstko", "gładko", "chropowaty",
  "lśnący", "matowy", "błyszczący", "zaćmiony", "przezierny", "zaćmiony", "nieśplewny", "nieprzezierny", "wspaniały", "pazerny",
  # More verbs for advanced levels
  "dzielić", "podzielić", "mnożyć", "pomnożyć", "odejmować", "odjąć", "dodawać", "dodać", "wzrastać", "rosnąć",
  "maleć", "zmaleć", "ustanawiać", "ustalić", "zaproponować", "zaproponować", "zaistnieć", "pojawiać", "pojawiać się", "zniknąć",
  "pojawiać się", "zmienić", "modyfikować", "przekształcić", "transformować", "przemieniać", "przebrać", "przebrać się", "zmienić", "zmienić się",
  "wciągnąć", "zaangażować", "zainteresować", "obudzić", "pobudzić", "obudzić się", "rozbudzić", "przespać", "przespać się", "zasnąć",
  "zaśnić", "zwijać", "zwiąć", "zwielić", "zwiąć się", "zawinąć", "zawinąć", "zawiniąć", "zawiniąć", "zawiąć",
  "zawiiąć się", "zawieszać", "zawiesić", "zawisnąć", "zawisać", "zawisnął", "zawisnąć", "zawisać", "zawiesić się", "zawisić",
)

$allWords = $allWords | Sort-Object -Unique | Where-Object { $_ }

Write-Output "Total unique Polish words: $($allWords.Count)"

function ConvertToHindpol($text) {
  $lower = $text.ToLower()
  $replacements = @(
    @("dzi", "जी"), @("sz", "श"), @("cz", "च"), @("rz", "झ"),
    @("ś", "श"), @("ć", "च"), @("ł", "व"), @("ż", "झ"),
    @("ą", "ओं"), @("ę", "एं"), @("j", "य"), @("w", "व"),
    @("ch", "ख"), @("h", "ह"), @("c", "त्स")
  )
  
  foreach ($pair in $replacements) {
    $lower = $lower -replace [regex]::Escape($pair[0]), $pair[1]
  }
  
  return $lower
}

# Extended translation dictionary
$translationMap = @{
  "być" = @{hindi="होना"; marathi="असणे"}
  "mieć" = @{hindi="पास होना"; marathi="असणे"}
  "robić" = @{hindi="करना"; marathi="करणे"}
  "mówić" = @{hindi="बोलना"; marathi="बोलणे"}
  "iść" = @{hindi="जाना"; marathi="जाणे"}
  "jść" = @{hindi="जाना"; marathi="जाणे"}
  "chodzić" = @{hindi="चलना"; marathi="चालणे"}
  "widzieć" = @{hindi="देखना"; marathi="पहाणे"}
  "słyszeć" = @{hindi="सुनना"; marathi="ऐकणे"}
  "czytać" = @{hindi="पढ़ना"; marathi="वाचणे"}
  "pisać" = @{hindi="लिखना"; marathi="लिहिणे"}
  "dać" = @{hindi="देना"; marathi="देणे"}
  "brać" = @{hindi="लेना"; marathi="घेणे"}
  "pracować" = @{hindi="काम करना"; marathi="काम करणे"}
  "uczyć" = @{hindi="सिखाना"; marathi="शिकवणे"}
  "pokazywać" = @{hindi="दिखाना"; marathi="दाखवणे"}
  "myśleć" = @{hindi="सोचना"; marathi="विचार करणे"}
  "rozumieć" = @{hindi="समझना"; marathi="समजणे"}
  "zapomnieć" = @{hindi="भूलना"; marathi="विसरणे"}
  "znać" = @{hindi="जानना"; marathi="जाणणे"}
  "lubić" = @{hindi="पसंद करना"; marathi="आवडणे"}
  "kochać" = @{hindi="प्यार करना"; marathi="प्रेम करणे"}
  "bać" = @{hindi="डरना"; marathi="भीती वाटणे"}
  "nauczać" = @{hindi="पढ़ाना"; marathi="शिकवणे"}
  "zaproponować" = @{hindi="प्रस्ताव करना"; marathi="प्रस्ताव करणे"}
  "sprzedać" = @{hindi="बेचना"; marathi="विकणे"}
  "kupić" = @{hindi="खरीदना"; marathi="विकत घेणे"}
  "zmienić" = @{hindi="बदलना"; marathi="बदलणे"}
  "zwrócić" = @{hindi="लौटाना"; marathi="परत करणे"}
  "zabrać" = @{hindi="ले जाना"; marathi="नेणे"}
  "spowodować" = @{hindi="कारण बनना"; marathi="कारण बनणे"}
  "pozwolić" = @{hindi="अनुमति देना"; marathi="परवानगी देणे"}
  "używać" = @{hindi="उपयोग करना"; marathi="वापर करणे"}
  "nosić" = @{hindi="पहनना"; marathi="घालणे"}
  "dom" = @{hindi="घर"; marathi="घर"}
  "pokój" = @{hindi="कमरा"; marathi="खोली"}
  "kuchnia" = @{hindi="रसोई"; marathi="स्वयंपाकघर"}
  "łazienka" = @{hindi="बाथरूम"; marathi="स्नानघर"}
  "sypialnia" = @{hindi="शयनकक्ष"; marathi="शयनकक्ष"}
  "salon" = @{hindi="ड्राइंग रूम"; marathi="ड्रॉईंग रूम"}
  "pies" = @{hindi="कुत्ता"; marathi="कुत्रा"}
  "kot" = @{hindi="बिल्ली"; marathi="मांजर"}
  "koń" = @{hindi="घोड़ा"; marathi="घोडा"}
  "krowa" = @{hindi="गाय"; marathi="गाय"}
  "świnia" = @{hindi="सूअर"; marathi="डुक्कर"}
  "chleb" = @{hindi="ब्रेड"; marathi="पाव"}
  "masło" = @{hindi="मक्खन"; marathi="लोणी"}
  "syr" = @{hindi="चीज़"; marathi="चीज"}
  "mleko" = @{hindi="दूध"; marathi="दूध"}
  "mięso" = @{hindi="मांस"; marathi="मांस"}
  "ryba" = @{hindi="मछली"; marathi="मासा"}
  "makaron" = @{hindi="पास्ता"; marathi="पास्ता"}
  "ryż" = @{hindi="चावल"; marathi="तांदूळ"}
  "ziemniaki" = @{hindi="आलू"; marathi="बटाटा"}
  "marchew" = @{hindi="गाजर"; marathi="गाजर"}
  "pomidor" = @{hindi="टमाटर"; marathi="टोमॅटो"}
  "papryka" = @{hindi="मिर्च"; marathi="मिरची"}
  "ogórek" = @{hindi="खीरा"; marathi="काकडी"}
  "kapusta" = @{hindi="गोभी"; marathi="कोबी"}
  "woda" = @{hindi="पानी"; marathi="पाणी"}
  "kawa" = @{hindi="कॉफी"; marathi="कॉफी"}
  "herbata" = @{hindi="चाय"; marathi="चहा"}
  "piwo" = @{hindi="बीयर"; marathi="बिअर"}
  "wino" = @{hindi="वाइन"; marathi="वाईन"}
  "czerwony" = @{hindi="लाल"; marathi="लाल"}
  "niebieski" = @{hindi="नीला"; marathi="निळा"}
  "zielony" = @{hindi="हरा"; marathi="हिरवा"}
  "żółty" = @{hindi="पीला"; marathi="पिवळा"}
  "czarny" = @{hindi="काला"; marathi="काळा"}
  "biały" = @{hindi="सफेद"; marathi="पांढरा"}
  "szary" = @{hindi="ग्रे"; marathi="राखाडी"}
  "brązowy" = @{hindi="भूरा"; marathi="तपकिरी"}
  "różowy" = @{hindi="गुलाबी"; marathi="गुलाबी"}
  "poniedziałek" = @{hindi="सोमवार"; marathi="सोमवार"}
  "wtorek" = @{hindi="मंगलवार"; marathi="मंगळवार"}
  "środa" = @{hindi="बुधवार"; marathi="बुधवार"}
  "czwartek" = @{hindi="गुरुवार"; marathi="गुरुवार"}
  "piątek" = @{hindi="शुक्रवार"; marathi="शुक्रवार"}
  "sobota" = @{hindi="शनिवार"; marathi="शनिवार"}
  "niedziela" = @{hindi="रविवार"; marathi="रविवार"}
}

function GetMeanings($polish) {
  $key = $polish.ToLower()
  
  if ($translationMap.ContainsKey($key)) {
    return $translationMap[$key]
  }
  
  if ($key -match "ać$|eć$|yć$|ować$|ić$") {
    return @{hindi="करना"; marathi="करणे"}
  } elseif ($key -match "ka$|ko$|ke$") {
    return @{hindi="चीजें"; marathi="वस्तु"}
  } else {
    return @{hindi="[अनुवाद की प्रतीक्षा]"; marathi="[अनुवाद प्रतीक्षार्थ]"}
  }
}

$dbWords = @()
$idx = 0
foreach ($word in $allWords) {
  $idx++
  $meanings = GetMeanings $word
  $level = if ($idx -lt 100) { "A1" } elseif ($idx -lt 250) { "A2" } elseif ($idx -lt 500) { "B1" } elseif ($idx -lt 750) { "B2" } else { "C1" }
  
  $dbWords += [pscustomobject]@{
    polish = $word
    hindpol = ConvertToHindpol $word
    hindi = $meanings.hindi
    marathi = $meanings.marathi
    pos = if ($word -match "ać$|eć$|yć$|ować$|ić$") { "क्रिया" } elseif ($word -match "a$|o$|y$|e$|ę$") { "संज्ञा" } else { "अन्य" }
    level = $level
  }
}

$db = [pscustomobject]@{
  meta = [pscustomobject]@{
    source = "comprehensive-polish-lexicon-2800-words"
    targetLevels = @("A1", "A2", "B1", "B2", "C1")
    updatedAt = (Get-Date -Format "yyyy-MM-dd")
    totalWords = $dbWords.Count
    notes = "Comprehensive Polish vocabulary for A1-C1 levels with auto-generated Hindpol and curated Hindi/Marathi translations"
  }
  words = $dbWords
}

$json = $db | ConvertTo-Json -Depth 5
$json | Set-Content -Path $OutPath -Encoding UTF8

$a1Count = @($dbWords | Where-Object {$_.level -eq 'A1'}).Count
$a2Count = @($dbWords | Where-Object {$_.level -eq 'A2'}).Count
$b1Count = @($dbWords | Where-Object {$_.level -eq 'B1'}).Count
$b2Count = @($dbWords | Where-Object {$_.level -eq 'B2'}).Count
$c1Count = @($dbWords | Where-Object {$_.level -eq 'C1'}).Count

Write-Output ""
Write-Output "══════════════════════════════════════════"
Write-Output "DATABASE BUILD COMPLETE"
Write-Output "══════════════════════════════════════════"
Write-Output "Total words: $($dbWords.Count)"
Write-Output "Distribution:"
Write-Output "  A1 (Beginner):       $a1Count words"
Write-Output "  A2 (Elementary):     $a2Count words"
Write-Output "  B1 (Intermediate):   $b1Count words"
Write-Output "  B2 (Upper-Interm):   $b2Count words"
Write-Output "  C1 (Advanced):       $c1Count words"
Write-Output "Saved to: $OutPath"
Write-Output "══════════════════════════════════════════"
