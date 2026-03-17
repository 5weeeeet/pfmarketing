$s = Get-Content -Raw 'C:\VS\pfmarketing\index.html'
$dq = ($s.ToCharArray() | Where-Object { $_ -eq '"' }).Count
$sq = ($s.ToCharArray() | Where-Object { $_ -eq "'" }).Count
Write-Output "double_quotes:$dq single_quotes:$sq"
