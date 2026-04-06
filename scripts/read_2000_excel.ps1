# Read 2000.xlsx and merge with existing database

$excelPath = 'c:\xampp\htdocs\Hindpol Learn Polish\2000.xlsx'
$dbPath = 'c:\xampp\htdocs\Hindpol Learn Polish\data\polish_lexicon.json'

# Read Excel file
try {
    $excel = New-Object -ComObject Excel.Application
    $excel.Visible = $false
    $workbook = $excel.Workbooks.Open($excelPath)
    $sheet = $workbook.Sheets.Item(1)
    
    $rowCount = $sheet.UsedRange.Rows.Count
    $colCount = $sheet.UsedRange.Columns.Count
    
    Write-Output "Excel file loaded: $rowCount rows, $colCount columns"
    
    # Extract Polish words from column 2 (skip header)
    $polishWords = @()
    for ($i = 2; $i -le $rowCount; $i++) {
        $cell = $sheet.Cells.Item($i, 2).Value2  # Column 2 = Polish
        if ($cell) {
            $cellStr = [string]$cell
            if ($cellStr.Trim()) {
                $polishWords += $cellStr.Trim()
            }
        }
    }
    
    $workbook.Close($false)
    $excel.Quit()
    
    Write-Output "Extracted $($polishWords.Count) words from Excel"
    Write-Output "First 10 words:"
    $polishWords[0..9] | ForEach-Object { Write-Output "  $_" }
    
} catch {
    Write-Output "Error reading Excel: $_"
    exit 1
}

# Read current database
$json = Get-Content $dbPath -Raw | ConvertFrom-Json
$existingCount = $json.words.Count

Write-Output "`nCurrent database: $existingCount words"

# Create translation function
function ConvertToHindpol($text) {
    $lower = $text.ToLower()
    $pairs = @(
        @('dzi', 'जी'), @('sz', 'श'), @('cz', 'च'), @('rz', 'झ'),
        @('ł', 'व'), @('ą', 'ओं'), @('ę', 'एं'), @('j', 'य'), @('w', 'व'),
        @('ch', 'ख'), @('h', 'ह'), @('c', 'त्स')
    )
    
    foreach ($p in $pairs) {
        $lower = $lower -replace [regex]::Escape($p[0]), $p[1]
    }
    
    return $lower
}

# Add new words to database
$newWords = @()
$duplicates = 0
$existingPolish = $json.words | Select-Object -ExpandProperty polish

foreach ($word in $polishWords) {
    if ($existingPolish -contains $word) {
        $duplicates++
    } else {
        # Determine level based on position
        $levelIdx = [Math]::Floor(($newWords.Count / ($polishWords.Count / 5)))
        $levels = @('A1', 'A2', 'B1', 'B2', 'C1')
        $level = $levels[[Math]::Min($levelIdx, 4)]
        
        # Determine POS
        $pos = if ($word -match 'ać$|eć$|yć$|ować$|ić$') { 'verb' } else { 'noun' }
        
        $newWords += [PSCustomObject]@{
            polish = $word
            hindpol = ConvertToHindpol $word
            hindi = '[अनुवाद प्रतीक्षार्थ]'
            marathi = '[अनुवाद प्रतीक्षार्थ]'
            pos = $pos
            level = $level
        }
    }
}

Write-Output "`nNew words to add: $($newWords.Count)"
Write-Output "Duplicate words: $duplicates"

# Merge and update
$json.words = @($json.words) + @($newWords)
$json.meta.totalWords = $json.words.Count
$json.meta.updatedAt = (Get-Date -Format 'yyyy-MM-dd')

# Save updated database
$utf8NoBom = [System.Text.Encoding]::UTF8
$dbJson = $json | ConvertTo-Json -Depth 5
$bytes = $utf8NoBom.GetBytes($dbJson)
[System.IO.File]::WriteAllBytes($dbPath, $bytes)

Write-Output "`n✓ Database updated!"
Write-Output "✓ Final total: $($json.words.Count) words"

# Level breakdown
$a1 = ($json.words | Where-Object { $_.level -eq 'A1' }).Count
$a2 = ($json.words | Where-Object { $_.level -eq 'A2' }).Count
$b1 = ($json.words | Where-Object { $_.level -eq 'B1' }).Count
$b2 = ($json.words | Where-Object { $_.level -eq 'B2' }).Count
$c1 = ($json.words | Where-Object { $_.level -eq 'C1' }).Count

Write-Output "`nLevel distribution:"
Write-Output "  A1: $a1"
Write-Output "  A2: $a2"
Write-Output "  B1: $b1"
Write-Output "  B2: $b2"
Write-Output "  C1: $c1"
