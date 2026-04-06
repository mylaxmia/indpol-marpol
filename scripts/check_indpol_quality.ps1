$p = 'c:\xampp\htdocs\Hindpol Learn Polish\data\indpol_baza\indpol_hindi_words.json'
$db = Get-Content $p -Raw | ConvertFrom-Json

$checkWords = @('być','mieć','robić','mówić','iść','czwartek','środa','niedziela','rzeka','szkoła','chleb','woda')

Write-Output 'INDPOL quality spot-check:'
foreach ($w in $checkWords) {
  $row = $db.data | Where-Object { $_.polish -eq $w } | Select-Object -First 1
  if ($row) {
    Write-Output ("  {0} => {1}" -f $row.polish, $row.indpol)
  } else {
    Write-Output ("  {0} => [not found]" -f $w)
  }
}

$total = $db.data.Count
$filled = ($db.data | Where-Object { $_.indpol -and $_.indpol.Trim() -ne '' }).Count
Write-Output ("TOTAL={0}" -f $total)
Write-Output ("FILLED={0}" -f $filled)
