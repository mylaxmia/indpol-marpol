# Check Excel file structure
$excelPath = 'c:\xampp\htdocs\Hindpol Learn Polish\2000.xlsx'

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$workbook = $excel.Workbooks.Open($excelPath)
$sheet = $workbook.Sheets.Item(1)

$rowCount = $sheet.UsedRange.Rows.Count
$colCount = $sheet.UsedRange.Columns.Count

Write-Output "Excel structure: $rowCount rows x $colCount columns`n"
Write-Output "First 5 rows (all columns):"
Write-Output ("Col" + (" | " * ($colCount - 1)))
Write-Output ("---" * $colCount)

for ($i = 1; $i -le 5; $i++) {
    $rowData = @()
    for ($j = 1; $j -le $colCount; $j++) {
        $cellVal = $sheet.Cells.Item($i, $j).Value2
        $rowData += [string]$cellVal
    }
    Write-Output ($rowData -join " | ")
}

$workbook.Close($false)
$excel.Quit()
