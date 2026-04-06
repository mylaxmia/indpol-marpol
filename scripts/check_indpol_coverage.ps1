$p = 'c:\xampp\htdocs\Hindpol Learn Polish\data\indpol_baza\indpol_hindi_words.json'
$db = Get-Content $p -Raw | ConvertFrom-Json

$total = $db.data.Count
$filled = ($db.data | Where-Object { $_.indpol -and $_.indpol.Trim() -ne '' }).Count
$missing = ($db.data | Where-Object { -not $_.indpol -or $_.indpol.Trim() -eq '' }).Count
$hindiFilled = ($db.data | Where-Object { $_.hindi_meaning -and $_.hindi_meaning.Trim() -ne '' }).Count
$hindiPending = ($db.data | Where-Object { $_.hindi_meaning -match 'लंबित' }).Count

Write-Output "TOTAL=$total"
Write-Output "INDPOL_FILLED=$filled"
Write-Output "INDPOL_MISSING=$missing"
Write-Output "HINDI_MEANING_FILLED=$hindiFilled"
Write-Output "HINDI_MEANING_PENDING=$hindiPending"
