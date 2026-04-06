$p = 'c:\xampp\htdocs\Hindpol Learn Polish\data\indpol_baza\indpol_marathi_words.json'
$db = Get-Content $p -Raw | ConvertFrom-Json

$total = $db.data.Count
$indpolFilled = ($db.data | Where-Object { $_.indpol -and $_.indpol.Trim() -ne '' }).Count
$marathiFilled = ($db.data | Where-Object { $_.marathi_meaning -and $_.marathi_meaning.Trim() -ne '' }).Count
$marathiPending = ($db.data | Where-Object { $_.marathi_meaning -match 'प्रलंबित' }).Count

Write-Output "TOTAL=$total"
Write-Output "INDPOL_FILLED=$indpolFilled"
Write-Output "MARATHI_FILLED=$marathiFilled"
Write-Output "MARATHI_PENDING=$marathiPending"
