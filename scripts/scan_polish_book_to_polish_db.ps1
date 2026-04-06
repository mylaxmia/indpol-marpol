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
  $json = $obiekt | ConvertTo-Json -Depth 10
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
  [System.IO.File]::WriteAllBytes($sciezka, $bytes)
}

function Oczysc-Wiersz([string]$linia) {
  if (-not $linia) { return '' }
  $x = $linia
  $x = $x -replace '\s+', ' '
  $x = $x -replace '[\u2013\u2014]', '-'
  $x = $x.Trim()
  return $x
}

function Czy-PolskiWiersz([string]$linia) {
  if (-not $linia) { return $false }
  $l = $linia.ToLower()

  if ($l.Length -lt 3) { return $false }
  if ($l -match '^\d+[\s\-–—]*$') { return $false }

  $maPolskie = $l -match '[ąćęłńóśźż]'
  $maFunkcyjne = $l -match '\b(i|w|z|na|do|po|od|czy|nie|jest|to|się|kiedy|gdzie|który|pan|pani)\b'
  $zaDuzoAng = $l -match '\b(the|and|of|to|is|are|will|when|where|what|this|that|your|my)\b'

  if (($maPolskie -or $maFunkcyjne) -and (-not $zaDuzoAng)) {
    return $true
  }

  return $false
}

function Tokeny([string]$tekst) {
  if (-not $tekst) { return @() }
  $m = [regex]::Matches($tekst.ToLower(), '[a-ząćęłńóśźż]+')
  return @($m | ForEach-Object { $_.Value })
}

function Czy-PolskieHaslo([string]$token, [hashtable]$angCzarne) {
  if (-not $token) { return $false }
  if ($token.Length -lt 2 -or $token.Length -gt 24) { return $false }
  if ($angCzarne.ContainsKey($token)) { return $false }
  if ($token -match '^(etc|ok|co|inc|ny|nr)$') { return $false }
  if ($token -match '(q|x)') { return $false }

  $maPolskiZnak = $token -match '[ąćęłńóśźż]'
  $polskaKoncowka = $token -match '(ać|eć|ić|yć|ować|nąć|nie|anie|enie|owie|owiec|owy|owa|owe|ego|ami|ach|cie|sz|rz)$'
  $maSamogloske = $token -match '[aeiouyąćęó]'

  return ($maPolskiZnak -or $polskaKoncowka -or $maSamogloske)
}

$stop = @(
  'i','a','w','z','na','do','po','od','o','u','za','dla','przy','nad','pod','bez','czy','nie','to','ta','ten','te','się','jest','są','był','była','byli','było','pan','pani'
)
$przyimki = @('w','z','na','do','od','po','o','u','za','dla','przy','nad','pod','bez','przed','między')
$angLista = @('the','and','of','to','is','are','will','when','where','what','this','that','your','my','practical','handbook','language','preface','contents','part','new','york','copyright','monday','tuesday','wednesday','thursday','friday','saturday','sunday','inside','outside','work','machine','stop','forward','backward')
$angCzarne = @{}
foreach ($a in $angLista) { $angCzarne[$a] = $true }

Write-Output 'Etap 1/4: Wczytanie i filtracja wierszy polskich'
$all = Get-Content $bookPath -Encoding UTF8
$clean = @($all | ForEach-Object { Oczysc-Wiersz $_ } | Where-Object { $_ -ne '' })
$polskieWiersze = @($clean | Where-Object { Czy-PolskiWiersz $_ })

Write-Output ("Wszystkie wiersze: {0}" -f $clean.Count)
Write-Output ("Wiersze polskie: {0}" -f $polskieWiersze.Count)

Write-Output 'Etap 2/4: Ekstrakcja zdań i słów'
$tekstPolski = ($polskieWiersze -join ' ')
$frag = [regex]::Split($tekstPolski, '(?<=[\.!\?])\s+')

$zdania = New-Object System.Collections.Generic.List[string]
foreach ($f in $frag) {
  $s = Oczysc-Wiersz $f
  if ($s.Length -lt 12) { continue }
  $tok = Tokeny $s
  if ($tok.Count -lt 3 -or $tok.Count -gt 22) { continue }
  if (-not (Czy-PolskiWiersz $s)) { continue }
  $zdania.Add($s)
}

$unikalneZdania = $zdania | Select-Object -Unique

$freq = @{}
foreach ($z in $unikalneZdania) {
  foreach ($t in (Tokeny $z)) {
    if ($t.Length -lt 2) { continue }
    if ($stop -contains $t) { continue }
    if (-not (Czy-PolskieHaslo -token $t -angCzarne $angCzarne)) { continue }
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
      objaśnienie = "Hasło wyodrębnione automatycznie z książki; użycie potwierdzone w korpusie tekstu."
    }
  }

Write-Output ("Zdania unikalne: {0}" -f $unikalneZdania.Count)
Write-Output ("Słowa unikalne: {0}" -f $slowa.Count)

Write-Output 'Etap 3/4: Konstrukcje i gramatyka (tylko po polsku)'
$konstrukcjeMap = @{}
foreach ($z in $unikalneZdania) {
  $t = Tokeny $z
  for ($i = 0; $i -lt ($t.Count - 1); $i++) {
    if ($przyimki -contains $t[$i]) {
      if (-not (Czy-PolskieHaslo -token $t[$i+1] -angCzarne $angCzarne)) { continue }
      $k = "$($t[$i]) $($t[$i+1])"
      if ($konstrukcjeMap.ContainsKey($k)) { $konstrukcjeMap[$k] += 1 } else { $konstrukcjeMap[$k] = 1 }
    }
  }
}

$konstrukcje = $konstrukcjeMap.GetEnumerator() |
  Where-Object { $_.Value -ge 2 } |
  Sort-Object -Property Value -Descending |
  Select-Object -First 1200 |
  ForEach-Object {
    [PSCustomObject]@{
      konstrukcja = $_.Key
      liczba_uzyc = [int]$_.Value
      objaśnienie = "Konstrukcja przyimkowa częsta w materiale źródłowym; używana w komunikacji codziennej."
    }
  }

$czasowniki = @($slowa | Where-Object { $_.typ -eq 'czasownik' } | Select-Object -First 400 -ExpandProperty haslo)
$rzeczowniki = @($slowa | Where-Object { $_.typ -eq 'rzeczownik' } | Select-Object -First 400 -ExpandProperty haslo)

$pytania = @($unikalneZdania | Where-Object { $_ -match '\?$|\b(czy|kiedy|gdzie|co|jak|który)\b' } | Select-Object -First 300)
$rozkazujace = @($unikalneZdania | Where-Object { $_ -match '^(idz|chodz|zrob|daj|powiedz|pros|niech|trzymaj|zatrzymaj)\b' } | Select-Object -First 300)

$gramatyka = [PSCustomObject]@{
  opis = 'Sekcja gramatyczna zbudowana automatycznie na podstawie polskich zdań z książki. Wszystkie opisy pozostają wyłącznie w języku polskim.'
  rzeczownik_i_przypadki = [PSCustomObject]@{
    opis = 'Model odmiany rzeczownika: mianownik, dopełniacz, celownik, biernik, narzędnik, miejscownik, wołacz. W bazie przechowywane są formy spotkane w realnych zdaniach.'
    wskazowka = 'Przy wyszukiwaniu warto sprawdzać zarówno formę podstawową, jak i odmiany z końcówkami -a, -u, -em, -ie, -ów, -ami, -ach.'
  }
  czasownik_i_czasy = [PSCustomObject]@{
    opis = 'Czasowniki obejmują bezokolicznik, formy teraźniejsze, przeszłe i przyszłe zauważone w materiale.'
    wskazowka = 'Końcówki -ć, -ać, -eć, -ić i -ować pomagają szybko odnaleźć bezokoliczniki.'
  }
  skladnia_praktyczna = [PSCustomObject]@{
    opis = 'Korpus zawiera pytania, polecenia i zdania informacyjne; to umożliwia analizę szyku i najczęstszych konstrukcji.'
    wskazowka = 'Najpierw analizuj konstrukcję czasownikową, następnie dołącz przyimki i dopełnienia.'
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
    przyklady = @($konstrukcje | Select-Object -First 300 -ExpandProperty konstrukcja)
  }
}

$uzyteczneZdania = @($unikalneZdania | Select-Object -First 2500 | ForEach-Object {
  [PSCustomObject]@{
    zdanie = $_
    objaśnienie = 'Zdanie praktyczne do ćwiczeń komunikacyjnych; zachowuje naturalny szyk i słownictwo z materiału źródłowego.'
  }
})

Write-Output 'Etap 4/4: Zapis baz językowych (czysty polski)'
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
