$ErrorActionPreference = 'Stop'

$root = 'c:\xampp\htdocs\Hindpol Learn Polish'
$lexPath = Join-Path $root 'data\polish_lexicon.json'
$indpolHindiPath = Join-Path $root 'data\indpol_baza\indpol_hindi_words.json'
$polishSentencePath = Join-Path $root 'data\polski_baza\zdania_uzytkowe.json'
$outDir = Join-Path $root 'data\indpol_baza'

if (-not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Path $outDir | Out-Null
}

function Save-JsonNoBom($obj, [string]$path) {
  $json = $obj | ConvertTo-Json -Depth 10
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
  [System.IO.File]::WriteAllBytes($path, $bytes)
}

function Convert-PolishToMarpol([string]$text) {
  if (-not $text) { return '' }
  $src = $text.ToLower().Trim()

  # Book-style priority exceptions for high-frequency forms.
  $exceptions = @{
    'być' = 'बिच'
    'mieć' = 'म्येच'
    'robić' = 'रोबिच'
    'mówić' = 'मुविच'
    'iść' = 'इश्च'
    'chleb' = 'ख्लेब'
    'woda' = 'वोदा'
    'rzeka' = 'झेका'
    'szkoła' = 'श्कोवा'
    'środa' = 'श्रोदा'
    'czwartek' = 'च्वार्तेक'
    'niedziela' = 'न्येज़ेला'
    'poniedziałek' = 'पोन्येज़्यावेक'
    'wtorek' = 'व्तोरेक'
    'piątek' = 'प्योंतेक'
    'sobota' = 'सोबोता'
  }

  if ($exceptions.ContainsKey($src)) {
    return $exceptions[$src]
  }

  $out = $src

  $pairs = @(
    @('szcz', 'श्च'),
    @('dzi', 'जि'),
    @('dź', 'जि'),
    @('dż', 'ज'),
    @('dz', 'ज'),
    @('cz', 'च'),
    @('sz', 'श'),
    @('rz', 'झ'),
    @('ch', 'ख'),
    @('ci', 'चि'),
    @('si', 'शि'),
    @('zi', 'ज़ि'),
    @('ni', 'नि'),
    @('ć', 'च'),
    @('ś', 'श'),
    @('ź', 'ज़'),
    @('ż', 'झ'),
    @('ń', 'ञ'),
    @('ł', 'व'),
    @('ą', 'ओं'),
    @('ę', 'एं'),
    @('ó', 'उ'),
    @('j', 'य'),
    @('w', 'व')
  )

  foreach ($p in $pairs) {
    $out = $out -replace [regex]::Escape($p[0]), $p[1]
  }

  # Marathi readability: use full vowel letters rather than dangling matras.
  $out = ($out -replace 'a', 'अ')
  $out = ($out -replace 'e', 'ए')
  $out = ($out -replace 'i', 'इ')
  $out = ($out -replace 'o', 'ओ')
  $out = ($out -replace 'u', 'उ')
  $out = ($out -replace 'y', 'इ')
  $out = ($out -replace 'b', 'ब')
  $out = ($out -replace 'c', 'त्स')
  $out = ($out -replace 'd', 'द')
  $out = ($out -replace 'f', 'फ')
  $out = ($out -replace 'g', 'ग')
  $out = ($out -replace 'h', 'ह')
  $out = ($out -replace 'k', 'क')
  $out = ($out -replace 'l', 'ल')
  $out = ($out -replace 'm', 'म')
  $out = ($out -replace 'n', 'न')
  $out = ($out -replace 'p', 'प')
  $out = ($out -replace 'r', 'र')
  $out = ($out -replace 's', 'स')
  $out = ($out -replace 't', 'त')
  $out = ($out -replace 'v', 'व')
  $out = ($out -replace 'z', 'ज़')
  $out = ($out -replace 'x', 'क्स')

  $out = ($out -replace "[\$\^§]", '')
  $out = ($out -replace '\s+', ' ')
  return $out.Trim()
}

if (-not (Test-Path $lexPath)) {
  throw 'Brak pliku data/polish_lexicon.json'
}

$lex = Get-Content $lexPath -Raw | ConvertFrom-Json

$indpolMap = @{}
if (Test-Path $indpolHindiPath) {
  $indpolHindi = Get-Content $indpolHindiPath -Raw | ConvertFrom-Json
  foreach ($r in $indpolHindi.data) {
    if ($r.polish -and $r.indpol) {
      $indpolMap[$r.polish] = $r.indpol
    }
  }
}

Write-Output 'Phase 1/2: Building Indpol Marathi-word database'
$wordRows = @($lex.words | ForEach-Object {
  $marathiMeaning = $_.marathi

  if (-not $marathiMeaning -or $marathiMeaning -match 'प्रतीक्षार्थ|लंबित') {
    if ($_.english -and $_.english.Trim() -ne '') {
      $marathiMeaning = "[अर्थ प्रलंबित: $($_.english)]"
    } else {
      $marathiMeaning = '[अर्थ प्रलंबित]'
    }
  }

  $indpolSound = if ($indpolMap.ContainsKey($_.polish)) { $indpolMap[$_.polish] } else { Convert-PolishToMarpol $_.polish }
  $marpolSound = Convert-PolishToMarpol $_.polish

  [PSCustomObject]@{
    polish = $_.polish
    indpol = $indpolSound
    marpol = $marpolSound
    marathi_meaning = $marathiMeaning
    pos = $_.pos
    level = $_.level
  }
})

$wordDb = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    language_name = 'Indpol'
    dataset_name = 'indpol_marathi_words'
    description = 'Polish शब्दाचा Hindi script sound (translation नाही), सोबत Marathi अर्थ.'
    total = $wordRows.Count
    updatedAt = (Get-Date -Format 'yyyy-MM-dd')
  }
  data = $wordRows
}

$wordOut = Join-Path $outDir 'indpol_marathi_words.json'
Save-JsonNoBom -obj $wordDb -path $wordOut

Write-Output 'Phase 2/2: Building Indpol Marathi useful-sentences database'
$sentenceSource = @()
if (Test-Path $polishSentencePath) {
  $sentenceDb = Get-Content $polishSentencePath -Raw | ConvertFrom-Json
  $sentenceSource = @($sentenceDb.dane | Select-Object -First 500)
}

if ($sentenceSource.Count -eq 0) {
  $sentenceSource = @($lex.words | Select-Object -First 200 | ForEach-Object {
    [PSCustomObject]@{
      zdanie = $_.polish
      objaśnienie = 'Zdanie użytkowe do praktyki.'
    }
  })
}

$sentenceRows = @($sentenceSource | ForEach-Object {
  $pol = [string]$_.zdanie
  if (-not $pol) { $pol = [string]$_.polish }
  $exp = [string]$_.objaśnienie
  if (-not $exp) { $exp = 'Zdanie użytkowe do praktyki.' }

  [PSCustomObject]@{
    polish_sentence = $pol
    indpol_sentence = Convert-PolishToMarpol $pol
    marpol_sentence = Convert-PolishToMarpol $pol
    marathi_meaning = '[वाक्य अर्थ प्रलंबित]'
    polish_explanation = $exp
  }
} | Where-Object { $_.polish_sentence -and $_.polish_sentence.Trim() } | Select-Object -Unique polish_sentence, indpol_sentence, marpol_sentence, marathi_meaning, polish_explanation)

$sentenceDbOut = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    language_name = 'Indpol'
    dataset_name = 'indpol_useful_sentences_marathi'
    description = 'Użyteczne zdania: Polish + zapis brzmieniowy Indpol + Marathi placeholder अर्थ.'
    total = $sentenceRows.Count
    updatedAt = (Get-Date -Format 'yyyy-MM-dd')
  }
  data = $sentenceRows
}

$sentenceOut = Join-Path $outDir 'indpol_useful_sentences_marathi.json'
Save-JsonNoBom -obj $sentenceDbOut -path $sentenceOut

$pending = ($wordRows | Where-Object { $_.marathi_meaning -match 'प्रलंबित' }).Count

Write-Output ("Created: {0}" -f $wordOut)
Write-Output ("Created: {0}" -f $sentenceOut)
Write-Output ("Final totals: words={0}, sentences={1}, marathi_pending={2}" -f $wordRows.Count, $sentenceRows.Count, $pending)
