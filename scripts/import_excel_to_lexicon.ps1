param(
  [string]$ExcelPath = "c:\xampp\htdocs\Hindpol Learn Polish\2000 POLISH WORDS.xlsx",
  [string]$OutPath = "c:\xampp\htdocs\Hindpol Learn Polish\data\polish_lexicon.json",
  [string]$DefaultLevel = "A1"
)

Import-Module ImportExcel -ErrorAction Stop

if (-not (Test-Path $ExcelPath)) {
  throw "Excel file not found: $ExcelPath"
}

$sheet = (Get-ExcelSheetInfo -Path $ExcelPath | Select-Object -First 1).Name
$rows = Import-Excel -Path $ExcelPath -WorksheetName $sheet -NoHeader

$rawWords = @()
foreach ($r in $rows) {
  if ($null -ne $r.P1 -and $r.P1.ToString().Trim() -ne "") {
    $rawWords += $r.P1.ToString().Trim().ToLower()
  }
}

$uniqueWords = $rawWords | Sort-Object -Unique

if (Test-Path $OutPath) {
  $db = Get-Content $OutPath -Raw | ConvertFrom-Json
} else {
  $db = [pscustomobject]@{
    meta = [pscustomobject]@{
      source = "excel-import"
      targetLevels = @("A1", "A2", "B1", "B2", "C1")
      updatedAt = (Get-Date -Format "yyyy-MM-dd")
      notes = "Auto imported from Excel"
    }
    words = @()
  }
}

$existing = @{}
foreach ($w in $db.words) {
  $existing[$w.polish] = $true
}

foreach ($w in $uniqueWords) {
  if (-not $existing.ContainsKey($w)) {
    $db.words += [pscustomobject]@{
      polish = $w
      hindpol = ""
      hindi = ""
      marathi = ""
      pos = ""
      level = $DefaultLevel
    }
  }
}

$db.meta.updatedAt = (Get-Date -Format "yyyy-MM-dd")

($db | ConvertTo-Json -Depth 8) | Set-Content -Path $OutPath -Encoding UTF8

Write-Output "Imported words: $($uniqueWords.Count)"
Write-Output "Database words total: $($db.words.Count)"
