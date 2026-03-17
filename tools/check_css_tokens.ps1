$html = Get-Content -Raw 'C:\VS\pfmarketing\index.html'
$rx = [regex] '(?s)<style>(.*?)</style>'
$m = $rx.Match($html)
if (-not $m.Success) { Write-Output 'No style block found'; exit }
$css = $m.Groups[1].Value
$counts = @{}
$counts['openBrace'] = ($css.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$counts['closeBrace'] = ($css.ToCharArray() | Where-Object { $_ -eq '}' }).Count
$counts['commentOpen'] = [regex]::Matches($css,'/\*').Count
$counts['commentClose'] = [regex]::Matches($css,'\*/').Count
$counts['parensOpen'] = ($css.ToCharArray() | Where-Object { $_ -eq '(' }).Count
$counts['parensClose'] = ($css.ToCharArray() | Where-Object { $_ -eq ')' }).Count
$counts['semicolons'] = [regex]::Matches($css,';').Count
$counts.GetEnumerator() | Sort-Object Name | Format-Table -AutoSize
