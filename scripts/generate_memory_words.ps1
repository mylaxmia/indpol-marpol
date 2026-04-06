# Generate 20 A1-A2 Polish words with Harry Lorayne memory tricks
# Using Indpol memory system principles

$dataDir = "data"
$data = (Get-Content "$dataDir/indpol_2000_comprehensive.json" | ConvertFrom-Json).data

# Filter A1-A2 words
$a1a2Words = $data | Where-Object { $_.level -in @("A1", "A2") } | Sort-Object polish | Select-Object -First 20

Write-Host "🧠 INDPOL MEMORY SYSTEM - Harry Lorayne Method" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Host ""

$a1a2Words | ForEach-Object {
    Write-Host "Word: $($_.polish)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Indpol (Hindi):   $($_.indpol_hindi)"
    Write-Host "Indpol (Marathi): $($_.indpol_marathi)"
    Write-Host ""
    Write-Host "Hindi Meaning:    $($_.hindi_meaning)"
    Write-Host "Marathi Meaning:  $($_.marathi_meaning)"
    Write-Host "English Meaning:  $($_.english_meaning)"
    Write-Host ""
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    Write-Host ""
}

Write-Host "✅ Total words: $($a1a2Words.Count)"
Write-Host "📊 Level: A1-A2 (Beginner)"
