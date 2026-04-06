$ErrorActionPreference = 'Stop'

$root = 'c:\xampp\htdocs\Hindpol Learn Polish'
$bookPath = Join-Path $root 'polish book.txt'
$outDir = Join-Path $root 'data\polski_baza'

if (-not (Test-Path $bookPath)) {
  throw 'Nie znaleziono pliku polish book.txt'
}

if (-not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Path $outDir | Out-Null
}

function Zapisz-JsonBezBom($obiekt, [string]$sciezka) {
  $json = $obiekt | ConvertTo-Json -Depth 12
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
  [System.IO.File]::WriteAllBytes($sciezka, $bytes)
}

function Oczysc([string]$txt) {
  if (-not $txt) { return '' }
  $x = $txt.Trim()
  $x = $x -replace '[\u2013\u2014]', '-'
  $x = $x -replace '\s+', ' '
  return $x
}

function Tokeny([string]$tekst) {
  if (-not $tekst) { return @() }
  $m = [regex]::Matches($tekst.ToLower(), '[a-ząćęłńóśźż]+')
  return @($m | ForEach-Object { $_.Value })
}

$polskieFunkcyjne = @('i','w','z','na','do','po','od','o','u','za','dla','przy','bez','czy','nie','jest','są','to','się','kiedy','gdzie','który','pan','pani','że','jak','co','być','mieć')
$przyimki = @('w','z','na','do','od','po','o','u','za','dla','przy','nad','pod','bez','przed','między')
$angielskie = @('the','and','of','to','is','are','will','when','where','what','this','that','your','my','you','we','they','have','has','had','do','does','did','in','like','used','before','never','sound','met','pin','law','hole','practical','handbook','language','part','contents','preface','copyright','monday','tuesday','wednesday','thursday','friday','saturday','sunday','inside','outside','work','machine','forward','backward','stop','let','please','here')
$transliteracja = @('pahn','panie','chih','yeh','veh','nah','gaw','vaw','vyeh','naw','daw','taw','shih','oo','raw','bill','esh','kaw')

$polF = @{}; foreach ($w in $polskieFunkcyjne) { $polF[$w] = $true }
$angF = @{}; foreach ($w in $angielskie) { $angF[$w] = $true }
$trF = @{}; foreach ($w in $transliteracja) { $trF[$w] = $true }

function Wynik-Polskosci([string]$fragment) {
  $t = Tokeny $fragment
  if ($t.Count -eq 0) { return -999 }

  $score = 0
  $polHits = 0
  $angHits = 0
  $trlHits = 0

  foreach ($w in $t) {
    if ($w -match '[ąćęłńóśźż]') { $score += 3; $polHits += 1 }
    if ($polF.ContainsKey($w)) { $score += 1; $polHits += 1 }
    if ($angF.ContainsKey($w)) { $score -= 3; $angHits += 1 }
    if ($trF.ContainsKey($w)) { $score -= 2; $trlHits += 1 }
  }

  # premiuj fragmenty wyglądające jak naturalne zdanie polskie
  if ($fragment -match '\b(czy|kiedy|gdzie|dlaczego|proszę|dzień|godzina|jutro|wczoraj)\b') { $score += 2 }

  # kara za zbyt dużo angielskiego
  if ($angHits -ge 2) { $score -= 4 }
  if ($trlHits -ge 2) { $score -= 2 }

  return $score
}

function Wybierz-PolskiFragment([string]$linia) {
  $x = Oczysc $linia
  if (-not $x) { return '' }

  # rozdzielanie potencjalnych kolumn OCR
  $parts = @()
  $parts += @([regex]::Split($x, '\s{2,}'))
  $parts += @([regex]::Split($x, '\t+'))
  if ($parts.Count -eq 0) { $parts = @($x) }

  $best = ''
  $bestScore = -999

  foreach ($p0 in $parts) {
    $p = Oczysc $p0
    if ($p.Length -lt 4) { continue }
    $sc = Wynik-Polskosci $p
    if ($sc -gt $bestScore) {
      $bestScore = $sc
      $best = $p
    }
  }

  if ($bestScore -lt 2) { return '' }
  if (($best -notmatch '[ąćęłńóśźż]') -and ($best -notmatch '\b(czy|gdzie|kiedy|dlaczego|proszę|dzień|jutro|wczoraj|chcesz|jest|nie|pan|pani)\b')) { return '' }
  return $best
}

function Czy-CzystePolskieZdanie([string]$s) {
  $txt = Oczysc $s
  if ($txt.Length -lt 8) { return $false }

  $tok = Tokeny $txt
  if ($tok.Count -lt 3 -or $tok.Count -gt 24) { return $false }

  $angHits = 0
  $trlHits = 0
  $polHits = 0

  foreach ($w in $tok) {
    if ($angF.ContainsKey($w)) { $angHits += 1 }
    if ($trF.ContainsKey($w)) { $trlHits += 1 }
    if ($w -match '[ąćęłńóśźż]' -or $polF.ContainsKey($w)) { $polHits += 1 }
  }

  if ($angHits -gt 0) { return $false }
  if ($trlHits -gt 0) { return $false }
  if ($polHits -lt 1) { return $false }
  if (($txt -notmatch '[ąćęłńóśźż]') -and ($txt -notmatch '\b(czy|gdzie|kiedy|dlaczego|proszę|dzień|jutro|wczoraj|chcesz|jest|nie|pan|pani)\b')) { return $false }

  return $true
}

function Czy-PolskieHaslo([string]$w) {
  if (-not $w) { return $false }
  if ($w.Length -lt 2 -or $w.Length -gt 24) { return $false }
  if ($angF.ContainsKey($w) -or $trF.ContainsKey($w)) { return $false }
  if ($w -match '^(etc|inc|co)$') { return $false }
  if ($w -match '[qxv]') { return $false }
  if ($w -notmatch '[aeiouyąćęó]') { return $false }
  return $true
}

Write-Output 'Etap 1/4: Wybór polskich fragmentów z całej książki'
$lines = Get-Content $bookPath -Encoding UTF8
$fragmenty = New-Object System.Collections.Generic.List[string]

foreach ($line in $lines) {
  $f = Wybierz-PolskiFragment $line
  if ($f) { $fragmenty.Add($f) }
}

$fragmenty = @($fragmenty | Select-Object -Unique)
Write-Output ("Fragmenty polskie: {0}" -f $fragmenty.Count)

Write-Output 'Etap 2/4: Budowa zdań i słownika'
$zdania = New-Object System.Collections.Generic.List[string]
foreach ($f in $fragmenty) {
  $parts = [regex]::Split($f, '(?<=[\.!\?])\s+')
  if ($parts.Count -eq 0) { $parts = @($f) }

  foreach ($p in $parts) {
    $s = Oczysc $p
    if (Czy-CzystePolskieZdanie $s) {
      $zdania.Add($s)
    }
  }
}

$unikalneZdania = @($zdania | Select-Object -Unique)

$stop = @('i','a','w','z','na','do','po','od','o','u','za','dla','przy','nad','pod','bez','czy','nie','to','ta','ten','te','się','jest','są','był','była','byli','było','pan','pani')
$stopF = @{}; foreach ($s in $stop) { $stopF[$s] = $true }

$freq = @{}
foreach ($frag in $fragmenty) {
  foreach ($t in (Tokeny $frag)) {
    if (-not (Czy-PolskieHaslo $t)) { continue }
    if ($stopF.ContainsKey($t)) { continue }
    if ($freq.ContainsKey($t)) { $freq[$t] += 1 } else { $freq[$t] = 1 }
  }
}

$slowa = $freq.GetEnumerator() |
  Sort-Object -Property Value -Descending |
  ForEach-Object {
    $w = $_.Key
    $f = [int]$_.Value

    $typ = 'inne'
    if ($w -match '(ać|eć|ić|yć|ować|nąć|c)$') { $typ = 'czasownik' }
    elseif ($w -match '(ość|cja|sja|unek|anie|enie|arz|ista)$') { $typ = 'rzeczownik' }
    elseif ($w -match '(y|i|a|e)$') { $typ = 'forma_odmienna' }

    [PSCustomObject]@{
      haslo = $w
      czestosc = $f
      typ = $typ
      objaśnienie = 'Hasło wyodrębnione automatycznie z polskiego korpusu książki i przygotowane do szybkiego wyszukiwania.'
    }
  }

Write-Output ("Zdania czysto polskie: {0}" -f $unikalneZdania.Count)
Write-Output ("Hasła polskie: {0}" -f $slowa.Count)

Write-Output 'Etap 3/4: Konstrukcje + gramatyka praktyczna'
$konstrukcjeMap = @{}
foreach ($z in $unikalneZdania) {
  $t = Tokeny $z
  for ($i = 0; $i -lt ($t.Count - 1); $i++) {
    if ($przyimki -contains $t[$i]) {
      if (-not (Czy-PolskieHaslo $t[$i+1])) { continue }
      $k = "$($t[$i]) $($t[$i+1])"
      if ($konstrukcjeMap.ContainsKey($k)) { $konstrukcjeMap[$k] += 1 } else { $konstrukcjeMap[$k] = 1 }
    }
  }
}

$konstrukcje = $konstrukcjeMap.GetEnumerator() |
  Where-Object { $_.Value -ge 2 } |
  Sort-Object -Property Value -Descending |
  Select-Object -First 1500 |
  ForEach-Object {
    [PSCustomObject]@{
      konstrukcja = $_.Key
      liczba_uzyc = [int]$_.Value
      objaśnienie = 'Konstrukcja częsta w praktycznych dialogach i ćwiczeniach komunikacyjnych.'
    }
  }

$czasowniki = @($slowa | Where-Object { $_.typ -eq 'czasownik' } | Select-Object -First 400 -ExpandProperty haslo)
$rzeczowniki = @($slowa | Where-Object { $_.typ -eq 'rzeczownik' } | Select-Object -First 400 -ExpandProperty haslo)
$pytania = @($unikalneZdania | Where-Object { $_ -match '\?$|\b(czy|kiedy|gdzie|co|jak|który|dlaczego)\b' } | Select-Object -First 400)
$rozkazujace = @($unikalneZdania | Where-Object { $_ -match '^(idź|chodź|zrób|daj|powiedz|proszę|trzymaj|zatrzymaj|weź)\b' } | Select-Object -First 400)

$gramatyka = [PSCustomObject]@{
  opis = 'Kompletna sekcja gramatyczna oparta na tekście książki, zorientowana na użycie praktyczne i szybkie odnajdywanie wzorców.'
  rzeczownik_i_przypadki = [PSCustomObject]@{
    opis = 'Model odmiany rzeczownika: mianownik, dopełniacz, celownik, biernik, narzędnik, miejscownik, wołacz.'
    wskazowka = 'Wyszukuj hasło bazowe oraz odmiany zakończone na -a, -u, -em, -ie, -ów, -ami, -ach.'
  }
  czasownik_i_czasy = [PSCustomObject]@{
    opis = 'Czasowniki obejmują bezokoliczniki i formy osobowe w czasie teraźniejszym, przeszłym oraz przyszłym.'
    wskazowka = 'Szybkie filtrowanie bezokoliczników: końcówki -ć, -ać, -eć, -ić, -ować.'
  }
  skladnia_praktyczna = [PSCustomObject]@{
    opis = 'Szyk zdania budowany jest na bazie rzeczywistych pytań, poleceń i zdań informacyjnych z materiału.'
    wskazowka = 'Najpierw identyfikuj orzeczenie, potem podmiot i dopełnienia przyimkowe.'
  }
  czasowniki_bezokoliczniki = [PSCustomObject]@{
    opis = 'Najczęstsze bezokoliczniki i formy czasownikowe wykryte w materiale.'
    przyklady = $czasowniki
  }
  rzeczowniki = [PSCustomObject]@{
    opis = 'Najczęstsze rzeczowniki i formy rzeczownikowe używane w kontekstach codziennych.'
    przyklady = $rzeczowniki
  }
  zdania_pytajace = [PSCustomObject]@{
    opis = 'Wzorce pytań używanych w rozmowie praktycznej.'
    przyklady = $pytania
  }
  zdania_rozkazujace = [PSCustomObject]@{
    opis = 'Wzorce poleceń i instrukcji typowe dla języka użytkowego.'
    przyklady = $rozkazujace
  }
  konstrukcje_przyimkowe = [PSCustomObject]@{
    opis = 'Częste połączenia przyimków z wyrazami następującymi po nich.'
    przyklady = @($konstrukcje | Select-Object -First 400 -ExpandProperty konstrukcja)
  }
}

$uzyteczneZdania = @($unikalneZdania | Select-Object -First 3000 | ForEach-Object {
  [PSCustomObject]@{
    zdanie = $_
    objaśnienie = 'Zdanie użytkowe do nauki komunikacji; zawiera naturalne słownictwo i strukturę z materiału źródłowego.'
  }
})

Write-Output 'Etap 4/4: Zapis bazy polskiej (bez mieszania języków)'
$slowaOut = Join-Path $outDir 'slowa.json'
$konstrOut = Join-Path $outDir 'konstrukcje.json'
$gramOut = Join-Path $outDir 'gramatyka.json'
$zdaniaOut = Join-Path $outDir 'zdania_uzytkowe.json'
$indeksOut = Join-Path $outDir 'indeks_bazy.json'

$slowaDb = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    jezyk = 'polski'
    zrodlo = 'polish book.txt'
    liczba_hasel = $slowa.Count
    data_aktualizacji = (Get-Date -Format 'yyyy-MM-dd')
  }
  dane = $slowa
}

$konstrDb = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    jezyk = 'polski'
    zrodlo = 'polish book.txt'
    liczba_konstrukcji = $konstrukcje.Count
    data_aktualizacji = (Get-Date -Format 'yyyy-MM-dd')
  }
  dane = $konstrukcje
}

$gramDb = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    jezyk = 'polski'
    zrodlo = 'polish book.txt'
    data_aktualizacji = (Get-Date -Format 'yyyy-MM-dd')
  }
  dane = $gramatyka
}

$zdaniaDb = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    jezyk = 'polski'
    zrodlo = 'polish book.txt'
    liczba_zdan = $uzyteczneZdania.Count
    data_aktualizacji = (Get-Date -Format 'yyyy-MM-dd')
  }
  dane = $uzyteczneZdania
}

$indeks = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    jezyk_systemu = 'polski'
    zasada = 'Brak mieszania języków; wszystkie opisy i dane są wyłącznie po polsku.'
    data_aktualizacji = (Get-Date -Format 'yyyy-MM-dd')
  }
  pliki = [PSCustomObject]@{
    slowa = 'data/polski_baza/slowa.json'
    konstrukcje = 'data/polski_baza/konstrukcje.json'
    gramatyka = 'data/polski_baza/gramatyka.json'
    zdania_uzytkowe = 'data/polski_baza/zdania_uzytkowe.json'
  }
  podsumowanie = [PSCustomObject]@{
    hasla = $slowa.Count
    konstrukcje = $konstrukcje.Count
    zdania = $uzyteczneZdania.Count
  }
}

Zapisz-JsonBezBom -obiekt $slowaDb -sciezka $slowaOut
Zapisz-JsonBezBom -obiekt $konstrDb -sciezka $konstrOut
Zapisz-JsonBezBom -obiekt $gramDb -sciezka $gramOut
Zapisz-JsonBezBom -obiekt $zdaniaDb -sciezka $zdaniaOut
Zapisz-JsonBezBom -obiekt $indeks -sciezka $indeksOut

Write-Output ("Utworzono: {0}" -f $slowaOut)
Write-Output ("Utworzono: {0}" -f $konstrOut)
Write-Output ("Utworzono: {0}" -f $gramOut)
Write-Output ("Utworzono: {0}" -f $zdaniaOut)
Write-Output ("Utworzono: {0}" -f $indeksOut)
Write-Output ("Podsumowanie: hasla={0}, konstrukcje={1}, zdania={2}" -f $slowa.Count, $konstrukcje.Count, $uzyteczneZdania.Count)
