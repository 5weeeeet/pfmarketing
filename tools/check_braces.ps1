$html = Get-Content -Raw 'C:\VS\pfmarketing\index.html'
$rx = [regex] '(?s)<style>(.*?)</style>'
$m = $rx.Match($html)
if (-not $m.Success) { Write-Output 'No style block found'; exit }
$s = $m.Groups[1].Value
$open = ($s.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$close = ($s.ToCharArray() | Where-Object { $_ -eq '}' }).Count
Write-Output "open:$open close:$close"
$lines = $s -split "\n"
for ($i=0;$i -lt $lines.Count; $i++) {
  $line = $lines[$i]
  $o = ($line.ToCharArray() | Where-Object { $_ -eq '{' }).Count
  $c = ($line.ToCharArray() | Where-Object { $_ -eq '}' }).Count
  if ($o -ne 0 -or $c -ne 0) { Write-Output ("{0,4}: open={1} close={2} | {3}" -f ($i+1), $o, $c, $line.Trim()) }
}
