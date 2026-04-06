# Comprehensive validation and export of 2000 Polish words dataset
$dataDir = "data"

# Load comprehensive dataset
$data = (Get-Content "$dataDir/indpol_2000_comprehensive.json" | ConvertFrom-Json).data

Write-Host "🔍 VALIDATION REPORT" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 1. Check for missing fields
$missingHindi = $data | Where-Object { [string]::IsNullOrWhiteSpace($_.hindi_meaning) -or $_.hindi_meaning -like "*लंबित*" } | Measure-Object | Select-Object -ExpandProperty Count
$missingMarathi = $data | Where-Object { [string]::IsNullOrWhiteSpace($_.marathi_meaning) -or $_.marathi_meaning -like "*प्रलंबित*" } | Measure-Object | Select-Object -ExpandProperty Count
$missingEnglish = $data | Where-Object { [string]::IsNullOrWhiteSpace($_.english_meaning) } | Measure-Object | Select-Object -ExpandProperty Count

Write-Host "📋 COMPLETENESS:"
Write-Host "  Total entries: $($data.Count)"
Write-Host "  ✓ Polish: $($data.Count)"
Write-Host "  ✓ Indpol-Hindi: $($data.Count)"
Write-Host "  ✓ Indpol-Marathi: $($data.Count)"
Write-Host "  ⚠ Hindi meanings: $(($data.Count - $missingHindi)) / $($data.Count)"
Write-Host "  ⚠ Marathi meanings: $(($data.Count - $missingMarathi)) / $($data.Count)"
Write-Host "  ⚠ English meanings: $(($data.Count - $missingEnglish)) / $($data.Count)"

# 2. Distribution by part of speech
Write-Host ""
Write-Host "📊 PART OF SPEECH DISTRIBUTION:"
$data | Group-Object pos | Sort-Object -Property Count -Descending | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Count)"
}

# 3. Distribution by level
Write-Host ""
Write-Host "📚 PROFICIENCY LEVELS:"
$data | Group-Object level | Sort-Object -Property Name | ForEach-Object {
    Write-Host "  $($_.Name): $($_.Count)"
}

# 4. Sample with good coverage
Write-Host ""
Write-Host "✅ SAMPLES WITH COMPLETE DATA:"
$complete = $data | Where-Object { 
    -not [string]::IsNullOrWhiteSpace($_.hindi_meaning) -and 
    -not ($_.hindi_meaning -like "*लंबित*") -and
    -not [string]::IsNullOrWhiteSpace($_.english_meaning)
} | Select-Object -First 10

$complete | ForEach-Object {
    Write-Host "  $($_.polish)"
    Write-Host "    Hindi: $($_.indpol_hindi) → $($_.hindi_meaning)"
    Write-Host "    Marathi: $($_.indpol_marathi) → $($_.marathi_meaning)"
    Write-Host "    English: $($_.english_meaning)"
}

# Export to CSV
Write-Host ""
Write-Host "💾 EXPORTING TO CSV..."
$data | Select-Object polish, indpol_hindi, indpol_marathi, hindi_meaning, marathi_meaning, english_meaning, pos, level | 
    Export-Csv -Path "$dataDir/indpol_2000_comprehensive.csv" -Encoding UTF8 -NoTypeInformation
Write-Host "✓ Saved: data/indpol_2000_comprehensive.csv"

# Export to Excel-friendly format
Write-Host "💾 EXPORTING TO EXCEL FORMAT..."
$excelData = $data | Select-Object @(
    "polish",
    "indpol_hindi", 
    "indpol_marathi",
    "hindi_meaning",
    "marathi_meaning", 
    "english_meaning",
    "pos",
    "level"
)

$excelData | Export-Csv -Path "$dataDir/indpol_2000_comprehensive_excel.csv" -Encoding UTF8 -Delimiter "`t" -NoTypeInformation
Write-Host "✓ Saved: data/indpol_2000_comprehensive_excel.csv (tab-delimited for Excel)"

Write-Host ""
Write-Host "✅ All exports complete!"
