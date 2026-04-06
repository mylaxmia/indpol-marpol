$ErrorActionPreference = 'Stop'

$root = 'c:\xampp\htdocs\Hindpol Learn Polish'
$dbPath = Join-Path $root 'data\polish_lexicon.json'
$excelPrimary = Join-Path $root '2000.xlsx'
$excelSecondary = Join-Path $root '2000 POLISH WORDS.xlsx'

$excelPath = if (Test-Path $excelPrimary) { $excelPrimary } elseif (Test-Path $excelSecondary) { $excelSecondary } else { '' }
if (-not $excelPath) {
  throw 'Excel file not found (expected 2000.xlsx or 2000 POLISH WORDS.xlsx).'
}

function Normalize-Word([string]$word) {
  if (-not $word) { return '' }
  return $word.Trim().ToLower()
}

function Write-JsonNoBom($obj, [string]$path) {
  $json = $obj | ConvertTo-Json -Depth 8
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
  [System.IO.File]::WriteAllBytes($path, $bytes)
}

Write-Output 'PHASE 1/4: Reading current DB + Excel source'
$db = Get-Content $dbPath -Raw | ConvertFrom-Json
$baseCount = $db.words.Count

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$workbook = $excel.Workbooks.Open($excelPath)
$sheet = $workbook.Sheets.Item(1)
$rowCount = $sheet.UsedRange.Rows.Count

$excelMap = @{}
for ($i = 2; $i -le $rowCount; $i++) {
  $polishRaw = $sheet.Cells.Item($i, 2).Value2
  if (-not $polishRaw) { continue }

  $polish = [string]$polishRaw
  if (-not $polish.Trim()) { continue }

  $englishRaw = $sheet.Cells.Item($i, 3).Value2
  $hindpolRaw = $sheet.Cells.Item($i, 4).Value2
  $marathiRaw = $sheet.Cells.Item($i, 5).Value2

  $key = Normalize-Word $polish
  if (-not $excelMap.ContainsKey($key)) {
    $excelMap[$key] = [PSCustomObject]@{
      polish = $polish.Trim()
      english = if ($englishRaw) { ([string]$englishRaw).Trim() } else { '' }
      hindpol = if ($hindpolRaw) { ([string]$hindpolRaw).Trim() } else { '' }
      marathi = if ($marathiRaw) { ([string]$marathiRaw).Trim() } else { '' }
    }
  }
}

$workbook.Close($false)
$excel.Quit()

Write-Output ("Base DB words: {0}" -f $baseCount)
Write-Output ("Excel mapped words: {0}" -f $excelMap.Count)

Write-Output 'PHASE 2/4: Enriching DB rows with English/Hindi/Marathi data'
$hindiFilled = 0
$marathiFilled = 0
$englishFilled = 0

foreach ($w in $db.words) {
  $key = Normalize-Word $w.polish
  $excelRow = $null
  if ($excelMap.ContainsKey($key)) { $excelRow = $excelMap[$key] }

  if (-not ($w.PSObject.Properties.Name -contains 'english')) {
    $w | Add-Member -MemberType NoteProperty -Name english -Value ''
  }

  if ([string]::IsNullOrWhiteSpace($w.english) -and $excelRow -and -not [string]::IsNullOrWhiteSpace($excelRow.english)) {
    $w.english = $excelRow.english
    $englishFilled++
  }

  if (($w.hindi -match 'प्रतीक्षार्थ') -and $w.english) {
    $w.hindi = "[हिंदी लंबित: $($w.english)]"
    $hindiFilled++
  }

  if (($w.marathi -match 'प्रतीक्षार्थ') -and $excelRow -and -not [string]::IsNullOrWhiteSpace($excelRow.marathi)) {
    $w.marathi = $excelRow.marathi
    $marathiFilled++
  } elseif (($w.marathi -match 'प्रतीक्षार्थ') -and $w.english) {
    $w.marathi = "[मराठी लंबित: $($w.english)]"
    $marathiFilled++
  }
}

$db.meta.updatedAt = (Get-Date -Format 'yyyy-MM-dd')
$db.meta.totalWords = $db.words.Count
$db.meta.notes = 'Polish vocabulary enriched with Hindi, Marathi, and English fields'

Write-JsonNoBom -obj $db -path $dbPath

Write-Output ("English filled: {0}" -f $englishFilled)
Write-Output ("Hindi placeholders upgraded: {0}" -f $hindiFilled)
Write-Output ("Marathi placeholders upgraded: {0}" -f $marathiFilled)

Write-Output 'PHASE 3/4: Creating 4 language datasets'
$polishData = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    language = 'polish'
    total = $db.words.Count
    updatedAt = (Get-Date -Format 'yyyy-MM-dd')
  }
  data = @($db.words | ForEach-Object {
    [PSCustomObject]@{
      polish = $_.polish
      hindpol = $_.hindpol
      pos = $_.pos
      level = $_.level
    }
  })
}

$hindiData = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    language = 'hindi'
    total = $db.words.Count
    updatedAt = (Get-Date -Format 'yyyy-MM-dd')
  }
  data = @($db.words | ForEach-Object {
    [PSCustomObject]@{
      polish = $_.polish
      hindi = $_.hindi
      level = $_.level
    }
  })
}

$marathiData = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    language = 'marathi'
    total = $db.words.Count
    updatedAt = (Get-Date -Format 'yyyy-MM-dd')
  }
  data = @($db.words | ForEach-Object {
    [PSCustomObject]@{
      polish = $_.polish
      marathi = $_.marathi
      level = $_.level
    }
  })
}

$englishData = [PSCustomObject]@{
  meta = [PSCustomObject]@{
    language = 'english'
    total = $db.words.Count
    updatedAt = (Get-Date -Format 'yyyy-MM-dd')
  }
  data = @($db.words | ForEach-Object {
    [PSCustomObject]@{
      polish = $_.polish
      english = $_.english
      level = $_.level
    }
  })
}

$polishOut = Join-Path $root 'data\polish_data.json'
$hindiOut = Join-Path $root 'data\hindi_data.json'
$marathiOut = Join-Path $root 'data\marathi_data.json'
$englishOut = Join-Path $root 'data\english_data.json'

Write-JsonNoBom -obj $polishData -path $polishOut
Write-JsonNoBom -obj $hindiData -path $hindiOut
Write-JsonNoBom -obj $marathiData -path $marathiOut
Write-JsonNoBom -obj $englishData -path $englishOut

Write-Output 'PHASE 4/4: Final validation & report'
$hindiReady = ($db.words | Where-Object { $_.hindi -and ($_.hindi -notmatch 'प्रतीक्षार्थ') }).Count
$marathiReady = ($db.words | Where-Object { $_.marathi -and ($_.marathi -notmatch 'प्रतीक्षार्थ') }).Count
$englishReady = ($db.words | Where-Object { $_.english -and $_.english.Trim() }).Count

Write-Output ("FINAL TOTAL WORDS: {0}" -f $db.words.Count)
Write-Output ("Hindi rows with value: {0}" -f $hindiReady)
Write-Output ("Marathi rows with value: {0}" -f $marathiReady)
Write-Output ("English rows with value: {0}" -f $englishReady)
Write-Output ("Created: {0}" -f $polishOut)
Write-Output ("Created: {0}" -f $hindiOut)
Write-Output ("Created: {0}" -f $marathiOut)
Write-Output ("Created: {0}" -f $englishOut)
