$ErrorActionPreference = 'Stop'

$root = 'c:\xampp\htdocs\Hindpol Learn Polish'
$lexPath = Join-Path $root 'data\polish_lexicon.json'
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

function Convert-PolishToIndpol([string]$text) {
  if (-not $text) { return '' }
  $out = $text.ToLower()

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

  $out = ($out -replace 'a', 'अ')
  $out = ($out -replace 'e', 'े')
  $out = ($out -replace 'i', 'ि')
  $out = ($out -replace 'o', 'ो')
  $out = ($out -replace 'u', 'ु')
  $out = ($out -replace 'y', 'ि')
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

  # cleanup of OCR punctuation and repeated vowel signs after substitutions
  $out = ($out -replace "[\$\^§]", '')
  $out = ($out -replace "''", "'")
  $out = ($out -replace '\s+', ' ')

  return ($out -replace '\s+', ' ').Trim()
}

if (-not (Test-Path $lexPath)) {
  throw 'Brak pliku data/polish_lexicon.json'
}

$lex = Get-Content $lexPath -Raw | ConvertFrom-Json

Write-Output 'Phase 1/2: Building Indpol Hindi-word database'
$wordRows = @($lex.words | ForEach-Object {
  $hindiMeaning = $_.hindi
  if (-not $hindiMeaning -or $hindiMeaning -match 'प्रतीक्षार्थ|लंबित') {
    $hindiMeaning = '[अर्थ लंबित]'
  }

  [PSCustomObject]@{
    polish = $_.polish
    indpol = Convert-PolishToIndpol $_.polish
    hindi_meaning = $hindiMeaning
    pos = $_.pos
    level = $_.level
  }
})

$wordDb = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    language_name = 'Indpol'
    dataset_name = 'indpol_hindi_words'
    description = 'Polish शब्द का Hindi script sound (translation नहीं), साथ में Hindi अर्थ।'
    total = $wordRows.Count
    updatedAt = (Get-Date -Format 'yyyy-MM-dd')
  }
  data = $wordRows
}

$wordOut = Join-Path $outDir 'indpol_hindi_words.json'
Save-JsonNoBom -obj $wordDb -path $wordOut

Write-Output 'Phase 2/2: Building Indpol useful-sentences database'
$sentenceSource = @()
if (Test-Path $polishSentencePath) {
  $sentenceDb = Get-Content $polishSentencePath -Raw | ConvertFrom-Json
  $sentenceSource = @($sentenceDb.dane | Select-Object -First 500)
}

if ($sentenceSource.Count -eq 0) {
  $sentenceSource = @($lex.words | Select-Object -First 200 | ForEach-Object {
    [PSCustomObject]@{
      zdanie = $_.polish
      objaśnienie = 'Przykładowe zdanie z hasła słownikowego.'
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
    indpol_sentence = Convert-PolishToIndpol $pol
    polish_explanation = $exp
  }
} | Where-Object { $_.polish_sentence -and $_.polish_sentence.Trim() } | Select-Object -Unique polish_sentence, indpol_sentence, polish_explanation)

$sentenceDbOut = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    language_name = 'Indpol'
    dataset_name = 'indpol_useful_sentences'
    description = 'Użyteczne zdania: Polish + zapis brzmieniowy Indpol (Hindi script).'
    total = $sentenceRows.Count
    updatedAt = (Get-Date -Format 'yyyy-MM-dd')
  }
  data = $sentenceRows
}

$sentenceOut = Join-Path $outDir 'indpol_useful_sentences.json'
Save-JsonNoBom -obj $sentenceDbOut -path $sentenceOut

Write-Output ("Created: {0}" -f $wordOut)
Write-Output ("Created: {0}" -f $sentenceOut)
Write-Output ("Final totals: words={0}, sentences={1}" -f $wordRows.Count, $sentenceRows.Count)
