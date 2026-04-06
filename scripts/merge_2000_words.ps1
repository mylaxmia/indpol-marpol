# Merge Hindi, Marathi, and English datasets into comprehensive 2000 Polish words
$dataDir = "data"

# Load all datasets
$hindi = (Get-Content "$dataDir/indpol_baza/indpol_hindi_words.json" | ConvertFrom-Json).data
$marathi = (Get-Content "$dataDir/indpol_baza/indpol_marathi_words.json" | ConvertFrom-Json).data
$english = (Get-Content "$dataDir/english_data.json" | ConvertFrom-Json).data

Write-Host "📊 Source data counts:"
Write-Host "  Hindi words: $($hindi.Count)"
Write-Host "  Marathi words: $($marathi.Count)"
Write-Host "  English words: $($english.Count)"

# Create lookup tables
$marathiLookup = @{}
$englishLookup = @{}

$marathi | ForEach-Object { $marathiLookup[$_.polish] = $_ }
$english | ForEach-Object { $englishLookup[$_.polish] = $_.english }

# Merge and deduplicate
$merged = @{}
$hindi | ForEach-Object {
    $key = $_.polish
    if (-not $merged.ContainsKey($key)) {
        $marathiData = $marathiLookup[$key]
        $merged[$key] = [PSCustomObject]@{
            polish = $_.polish
            indpol_hindi = $_.indpol
            indpol_marathi = if ($marathiData) { $marathiData.marpol } else { $_.indpol }
            hindi_meaning = $_.hindi_meaning
            marathi_meaning = if ($marathiData) { $marathiData.marathi_meaning } else { "" }
            english_meaning = if ($englishLookup[$key]) { $englishLookup[$key] } else { "" }
            pos = $_.pos
            level = $_.level
        }
    }
}

$mergedArray = $merged.Values | Sort-Object polish

Write-Host "✅ Total merged (deduplicated): $($mergedArray.Count)"

# Create output structure
$output = [PSCustomObject]@{
    meta = [PSCustomObject]@{
        language_name = "Indpol"
        dataset_name = "indpol_2000_comprehensive"
        description = "2000 Polish words with Indpol-Hindi, Indpol-Marathi, and meanings in Hindi, Marathi, English"
        total = $mergedArray.Count
        fields = @("polish", "indpol_hindi", "indpol_marathi", "hindi_meaning", "marathi_meaning", "english_meaning", "pos", "level")
        updatedAt = (Get-Date -Format "yyyy-MM-dd")
    }
    data = $mergedArray
}

# Save as JSON
$output | ConvertTo-Json -Depth 10 | Out-File "$dataDir/indpol_2000_comprehensive.json" -Encoding UTF8

Write-Host ""
Write-Host "💾 Saved to: data/indpol_2000_comprehensive.json"

# Show sample
Write-Host ""
Write-Host "📋 Sample entries:"
$mergedArray | Select-Object -First 5 | ForEach-Object {
    Write-Host "$($_.polish) | $($_.indpol_hindi) | $($_.hindi_meaning) | $($_.english_meaning)"
}
