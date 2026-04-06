$ErrorActionPreference = 'Stop'

$dir = 'c:\xampp\htdocs\Hindpol Learn Polish\data\polski_baza'
$slowaPath = Join-Path $dir 'slowa.json'
$konstrPath = Join-Path $dir 'konstrukcje.json'
$zdaniaPath = Join-Path $dir 'zdania_uzytkowe.json'
$indeksPath = Join-Path $dir 'indeks_bazy.json'

$ang = @('the','and','of','to','is','are','will','when','where','what','this','that','your','my','you','we','they','have','has','had','do','does','did','in','like','used','before','never','sound','met','pin','law','hole','cheesy')
$trl = @('pahn','chih','yeh','veh','nah','gaw','vaw','vyeh','naw','daw','taw','shih','oo','raw','bill','esh','kaw','tay')
$angF = @{}; foreach ($w in $ang) { $angF[$w] = $true }
$trlF = @{}; foreach ($w in $trl) { $trlF[$w] = $true }

function Tok([string]$txt) {
  if (-not $txt) { return @() }
  $m = [regex]::Matches($txt.ToLower(), '[a-ząćęłńóśźż]+')
  return @($m | ForEach-Object { $_.Value })
}

function CzystyTekst([string]$txt) {
  if (-not $txt) { return $false }
  $t = Tok $txt
  if ($t.Count -lt 2) { return $false }

  foreach ($w in $t) {
    if ($angF.ContainsKey($w)) { return $false }
    if ($trlF.ContainsKey($w)) { return $false }
  }

  if ($txt -match '\([a-z]{2,}\)') { return $false }
  if ($txt -match '\$') { return $false }

  return $true
}

function CzysteHaslo([string]$txt) {
  if (-not $txt) { return $false }
  $t = Tok $txt
  if ($t.Count -lt 1) { return $false }

  foreach ($w in $t) {
    if ($angF.ContainsKey($w)) { return $false }
    if ($trlF.ContainsKey($w)) { return $false }
  }

  return $true
}

function SaveNoBom($obj, [string]$path) {
  $json = $obj | ConvertTo-Json -Depth 12
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
  [System.IO.File]::WriteAllBytes($path, $bytes)
}

$slowa = Get-Content $slowaPath -Raw | ConvertFrom-Json
$konstr = Get-Content $konstrPath -Raw | ConvertFrom-Json
$zdania = Get-Content $zdaniaPath -Raw | ConvertFrom-Json
$indeks = Get-Content $indeksPath -Raw | ConvertFrom-Json

$slowaNowe = @($slowa.dane | Where-Object { CzysteHaslo $_.haslo })
$konstrNowe = @($konstr.dane | Where-Object { CzystyTekst $_.konstrukcja })
$zdaniaNowe = @($zdania.dane | Where-Object { CzystyTekst $_.zdanie })

$slowa.dane = $slowaNowe
$slowa.meta.liczba_hasel = $slowaNowe.Count

$konstr.dane = $konstrNowe
$konstr.meta.liczba_konstrukcji = $konstrNowe.Count

$zdania.dane = $zdaniaNowe
$zdania.meta.liczba_zdan = $zdaniaNowe.Count

$indeks.podsumowanie.hasla = $slowaNowe.Count
$indeks.podsumowanie.konstrukcje = $konstrNowe.Count
$indeks.podsumowanie.zdania = $zdaniaNowe.Count
$indeks.meta.data_aktualizacji = (Get-Date -Format 'yyyy-MM-dd')

SaveNoBom $slowa $slowaPath
SaveNoBom $konstr $konstrPath
SaveNoBom $zdania $zdaniaPath
SaveNoBom $indeks $indeksPath

Write-Output ("Po czyszczeniu: hasla={0}, konstrukcje={1}, zdania={2}" -f $slowaNowe.Count, $konstrNowe.Count, $zdaniaNowe.Count)
