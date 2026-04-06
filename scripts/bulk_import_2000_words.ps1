param(
  [string]$ExcelPath = "c:\xampp\htdocs\Hindpol Learn Polish\2000 POLISH WORDS.xlsx",
  [string]$OutPath = "c:\xampp\htdocs\Hindpol Learn Polish\data\polish_lexicon.json"
)

$ErrorActionPreference = "Stop"

# Hindi/Marathi translation dictionary for common words
$translationMap = @{
  "being" = @{hindi="होना"; marathi="असणे"}
  "to be" = @{hindi="होना"; marathi="असणे"}
  "have" = @{hindi="रखना"; marathi="असणे"}
  "to have" = @{hindi="रखना"; marathi="असणे"}
  "do" = @{hindi="करना"; marathi="करणे"}
  "to do" = @{hindi="करना"; marathi="करणे"}
  "go" = @{hindi="जाना"; marathi="जाणे"}
  "to go" = @{hindi="जाना"; marathi="जाणे"}
  "come" = @{hindi="आना"; marathi="येणे"}
  "to come" = @{hindi="आना"; marathi="येणे"}
  "make" = @{hindi="बनाना"; marathi="बनवणे"}
  "to make" = @{hindi="बनाना"; marathi="बनवणे"}
  "say" = @{hindi="कहना"; marathi="सांगणे"}
  "to say" = @{hindi="कहना"; marathi="सांगणे"}
  "give" = @{hindi="देना"; marathi="देणे"}
  "to give" = @{hindi="देना"; marathi="देणे"}
  "take" = @{hindi="लेना"; marathi="घेणे"}
  "to take" = @{hindi="लेना"; marathi="घेणे"}
  "see" = @{hindi="देखना"; marathi="पहाणे"}
  "to see" = @{hindi="देखना"; marathi="पहाणे"}
  "know" = @{hindi="जानना"; marathi="जाणणे"}
  "to know" = @{hindi="जानना"; marathi="जाणणे"}
  "want" = @{hindi="चाहना"; marathi="हवे असणे"}
  "to want" = @{hindi="चाहना"; marathi="हवे असणे"}
  "think" = @{hindi="सोचना"; marathi="विचार करणे"}
  "to think" = @{hindi="सोचना"; marathi="विचार करणे"}
  "get" = @{hindi="प्राप्त करना"; marathi="मिळणे"}
  "to get" = @{hindi="प्राप्त करना"; marathi="मिळणे"}
  "try" = @{hindi="कोशिश करना"; marathi="प्रयत्न करणे"}
  "to try" = @{hindi="कोशिश करना"; marathi="प्रयत्न करणे"}
  "work_verb" = @{hindi="काम करना"; marathi="काम करणे"}
  "to work" = @{hindi="काम करना"; marathi="काम करणे"}
  "use" = @{hindi="उपयोग करना"; marathi="वापर करणे"}
  "to use" = @{hindi="उपयोग करना"; marathi="वापर करणे"}
  "need" = @{hindi="ज़रूरत होना"; marathi="गरज असणे"}
  "to need" = @{hindi="ज़रूरत होना"; marathi="गरज असणे"}
  "eat" = @{hindi="खाना"; marathi="खाणे"}
  "to eat" = @{hindi="खाना"; marathi="खाणे"}
  "drink" = @{hindi="पीना"; marathi="पिणे"}
  "to drink" = @{hindi="पीना"; marathi="पिणे"}
  "sleep" = @{hindi="सोना"; marathi="झोपणे"}
  "to sleep" = @{hindi="सोना"; marathi="झोपणे"}
  "sit" = @{hindi="बैठना"; marathi="बसणे"}
  "to sit" = @{hindi="बैठना"; marathi="बसणे"}
  "stand" = @{hindi="खड़ा होना"; marathi="उभे राहणे"}
  "to stand" = @{hindi="खड़ा होना"; marathi="उभे राहणे"}
  "walk" = @{hindi="चलना"; marathi="चालणे"}
  "to walk" = @{hindi="चलना"; marathi="चालणे"}
  "run" = @{hindi="दौड़ना"; marathi="धावणे"}
  "to run" = @{hindi="दौड़ना"; marathi="धावणे"}
  "talk" = @{hindi="बात करना"; marathi="बोलणे"}
  "to talk" = @{hindi="बात करना"; marathi="बोलणे"}
  "speak" = @{hindi="बोलना"; marathi="बोलणे"}
  "to speak" = @{hindi="बोलना"; marathi="बोलणे"}
  "listen" = @{hindi="सुनना"; marathi="ऐकणे"}
  "to listen" = @{hindi="सुनना"; marathi="ऐकणे"}
  "write" = @{hindi="लिखना"; marathi="लिहिणे"}
  "to write" = @{hindi="लिखना"; marathi="लिहिणे"}
  "read" = @{hindi="पढ़ना"; marathi="वाचणे"}
  "to read" = @{hindi="पढ़ना"; marathi="वाचणे"}
  "love" = @{hindi="प्यार करना"; marathi="प्रेम करणे"}
  "to love" = @{hindi="प्यार करना"; marathi="प्रेम करणे"}
  "help" = @{hindi="मदद करना"; marathi="मदत करणे"}
  "to help" = @{hindi="मदद करना"; marathi="मदत करणे"}
  "house" = @{hindi="घर"; marathi="घर"}
  "home" = @{hindi="घर"; marathi="घर"}
  "man" = @{hindi="आदमी"; marathi="माणूस"}
  "woman" = @{hindi="औरत"; marathi="स्त्री"}
  "child" = @{hindi="बच्चा"; marathi="मूल"}
  "person" = @{hindi="व्यक्ति"; marathi="व्यक्ती"}
  "day" = @{hindi="दिन"; marathi="दिवस"}
  "night" = @{hindi="रात"; marathi="रात्र"}
  "time" = @{hindi="समय"; marathi="वेळ"}
  "morning" = @{hindi="सुबह"; marathi="सकाळ"}
  "evening" = @{hindi="शाम"; marathi="संध्या"}
  "water" = @{hindi="पानी"; marathi="पाणी"}
  "fire" = @{hindi="आग"; marathi="आग"}
  "earth" = @{hindi="पृथ्वी"; marathi="पृथ्वी"}
  "sky" = @{hindi="आसमान"; marathi="आकाश"}
  "good" = @{hindi="अच्छा"; marathi="चांगला"}
  "bad" = @{hindi="बुरा"; marathi="वाईट"}
  "big" = @{hindi="बड़ा"; marathi="मोठा"}
  "small" = @{hindi="छोटा"; marathi="लहान"}
  "fast" = @{hindi="तेज़"; marathi="वेगवान"}
  "slow" = @{hindi="धीरा"; marathi="हळू"}
  "beautiful" = @{hindi="सुंदर"; marathi="सुंदर"}
  "ugly" = @{hindi="बदसूरत"; marathi="असुंदर"}
  "happy" = @{hindi="खुश"; marathi="आनंदी"}
  "sad" = @{hindi="दुःखी"; marathi="दुःखी"}
  "angry" = @{hindi="गुस्से में"; marathi="रागी"}
  "tired" = @{hindi="थका"; marathi="थकलेला"}
  "hungry" = @{hindi="भूखा"; marathi="भुकेला"}
  "thirsty" = @{hindi="प्यासा"; marathi="तहानेला"}
  "food" = @{hindi="खाना"; marathi="खाना"}
  "bread" = @{hindi="ब्रेड"; marathi="पाव"}
  "meat" = @{hindi="मांस"; marathi="मांस"}
  "fish" = @{hindi="मछली"; marathi="मासा"}
  "money" = @{hindi="पैसा"; marathi="पैसे"}
  "work_noun" = @{hindi="काम"; marathi="काम"}
  "school" = @{hindi="स्कूल"; marathi="शाळा"}
  "book" = @{hindi="किताब"; marathi="पुस्तक"}
  "pen" = @{hindi="कलम"; marathi="कलम"}
  "paper" = @{hindi="कागज़"; marathi="कागद"}
  "color" = @{hindi="रंग"; marathi="रंग"}
  "red" = @{hindi="लाल"; marathi="लाल"}
  "blue" = @{hindi="नीला"; marathi="निळा"}
  "green" = @{hindi="हरा"; marathi="हिरवा"}
  "yellow" = @{hindi="पीला"; marathi="पिवळा"}
  "white" = @{hindi="सफेद"; marathi="पांढरा"}
  "black" = @{hindi="काला"; marathi="काळा"}
  "mother" = @{hindi="माता"; marathi="आई"}
  "father" = @{hindi="पिता"; marathi="बाप"}
  "sister" = @{hindi="बहन"; marathi="बहीण"}
  "brother" = @{hindi="भाई"; marathi="भाऊ"}
  "friend" = @{hindi="दोस्त"; marathi="मित्र"}
  "teacher" = @{hindi="शिक्षक"; marathi="शिक्षक"}
  "doctor" = @{hindi="डॉक्टर"; marathi="डॉक्टर"}
  "police" = @{hindi="पुलिस"; marathi="पोलीस"}
  "car" = @{hindi="गाड़ी"; marathi="गाडी"}
  "bus" = @{hindi="बस"; marathi="बस"}
  "train" = @{hindi="ट्रेन"; marathi="ट्रेन"}
  "airplane" = @{hindi="हवाई जहाज़"; marathi="विमान"}
  "boat" = @{hindi="नाव"; marathi="नाव"}
  "road" = @{hindi="सड़क"; marathi="रस्ता"}
  "street" = @{hindi="गली"; marathi="गली"}
  "shop" = @{hindi="दुकान"; marathi="दुकान"}
  "market" = @{hindi="बाजार"; marathi="बाजार"}
  "hospital" = @{hindi="अस्पताल"; marathi="रुग्णालय"}
  "church" = @{hindi="चर्च"; marathi="चर्च"}
  "temple" = @{hindi="मंदिर"; marathi="मंदिर"}
  "mosque" = @{hindi="मस्जिद"; marathi="मशीद"}
}

Write-Output "Starting import from: $ExcelPath"

# Try different methods to read Excel
try {
  # Method 1: Try ImportExcel module
  if (Get-Command Import-Excel -ErrorAction SilentlyContinue) {
    Import-Module ImportExcel -ErrorAction Stop
    $sheet = (Get-ExcelSheetInfo -Path $ExcelPath -ErrorAction Stop | Select-Object -First 1).Name
    $rows = Import-Excel -Path $ExcelPath -WorksheetName $sheet -NoHeader -ErrorAction Stop
    
    $wordsList = @()
    foreach ($r in $rows) {
      $val = $r.P1
      if ($null -ne $val -and $val.ToString().Trim() -ne "") {
        $wordsList += $val.ToString().Trim()
      }
    }
    Write-Output "Excel import successful: $($wordsList.Count) words"
  }
} catch {
  Write-Output "ImportExcel method failed, trying COM object..."
  
  # Method 2: Try COM object
  try {
    $excel = New-Object -ComObject Excel.Application
    $excel.Visible = $false
    $wb = $excel.Workbooks.Open((Resolve-Path $ExcelPath).Path)
    $ws = $wb.Worksheets.Item(1)
    $used = $ws.UsedRange
    
    $wordsList = @()
    for ($r = 1; $r -le $used.Rows.Count; $r++) {
      $val = $ws.Cells.Item($r, 1).Text
      if ($val -and $val.Trim() -ne "") {
        $wordsList += $val.Trim()
      }
    }
    
    $wb.Close($false)
    $excel.Quit()
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($ws) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($wb) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
    
    Write-Output "COM method successful: $($wordsList.Count) words"
  } catch {
    Write-Output "Both methods failed: $_"
    exit 1
  }
}

$wordsList = $wordsList | Sort-Object -Unique
Write-Output "Unique words: $($wordsList.Count)"

# Function to convert Polish to Hindpol
function ConvertToHindpol($text) {
  $lower = $text.ToLower()
  $replacements = @(
    @("dzi", "जी"), @("sz", "श"), @("cz", "च"), @("rz", "झ"),
    @("ś", "श"), @("ć", "च"), @("ł", "व"), @("ż", "झ"),
    @("ą", "ओं"), @("ę", "एं"), @("j", "य"), @("w", "व"),
    @("ch", "ख"), @("h", "ह"), @("c", "त्स")
  )
  
  foreach ($pair in $replacements) {
    $lower = $lower -replace [regex]::Escape($pair[0]), $pair[1]
  }
  
  return $lower
}

# Generate default meanings if not in map
function GetMeanings($polish) {
  $key = $polish.ToLower()
  
  if ($translationMap.ContainsKey($key)) {
    return $translationMap[$key]
  }
  
  # Try to find partial match
  foreach ($mapKey in $translationMap.Keys) {
    if ($key -like "*$mapKey*") {
      return $translationMap[$mapKey]
    }
  }
  
  # Fallback: generic meanings based on word patterns
  if ($key -match "ać$|eć$|yć$" -or $key -match "ować$") {
    return @{hindi="करना"; marathi="करणे"}
  } elseif ($key -match "^[a-z]{2,3}$") {
    return @{hindi="शब्द"; marathi="शब्द"}
  } else {
    return @{hindi="अर्थ"; marathi="अर्थ"}
  }
}

# Build database entries
$dbWords = @()
foreach ($word in $wordsList) {
  $hindpol = ConvertToHindpol $word
  $meanings = GetMeanings $word
  
  $dbWords += [pscustomobject]@{
    polish = $word
    hindpol = $hindpol
    hindi = $meanings.hindi
    marathi = $meanings.marathi
    pos = ""
    level = "A1"
  }
}

# Create database object
$db = [pscustomobject]@{
  meta = [pscustomobject]@{
    source = "excel-2000-words-import"
    targetLevels = @("A1", "A2", "B1", "B2", "C1")
    updatedAt = (Get-Date -Format "yyyy-MM-dd")
    totalWords = $dbWords.Count
    notes = "Bulk import with auto-generated Hindpol and translation placeholders"
  }
  words = $dbWords
}

# Save to JSON
$db | ConvertTo-Json -Depth 5 | Set-Content -Path $OutPath -Encoding UTF8

Write-Output ""
Write-Output "====== IMPORT COMPLETE ======"
Write-Output "Polish words imported: $($dbWords.Count)"
Write-Output "Database saved to: $OutPath"
Write-Output "Updated at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
