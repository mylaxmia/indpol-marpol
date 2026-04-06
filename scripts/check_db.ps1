# Check database file size and content
$dbPath = 'c:\xampp\htdocs\Hindpol Learn Polish\data\polish_lexicon.json'
$json = Get-Content $dbPath -Raw | ConvertFrom-Json

Write-Output "Database file check:"
Write-Output "  Total words: $($json.words.Count)"
Write-Output "  File size: $(((Get-Item $dbPath).Length / 1KB).ToString('0.0')) KB"
Write-Output ""
Write-Output "First 10 words:"
for ($i = 0; $i -lt 10; $i++) {
    Write-Output "  $($json.words[$i].polish)"
}
