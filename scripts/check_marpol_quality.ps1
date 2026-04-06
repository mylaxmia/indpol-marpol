$p = 'c:\xampp\htdocs\Hindpol Learn Polish\data\indpol_baza\indpol_marathi_words.json'
$db = Get-Content $p -Raw | ConvertFrom-Json
$keys = @('być','mieć','robić','mówić','iść','czwartek','środa','niedziela','szkoła','chleb','woda','rzeka')
Write-Output 'Marpol pronunciation check:'
foreach ($k in $keys) {
  $r = $db.data | Where-Object { $_.polish -eq $k } | Select-Object -First 1
  if ($r) { Write-Output ("  {0} => {1}" -f $r.polish, $r.marpol) }
}
$filled = ($db.data | Where-Object { $_.marpol -and $_.marpol.Trim() -ne '' }).Count
Write-Output ("TOTAL={0}" -f $db.data.Count)
Write-Output ("MARPOL_FILLED={0}" -f $filled)
