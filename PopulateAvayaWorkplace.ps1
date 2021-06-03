while ($true) {
    $allusers = Get-ADGroupMember "all users" | Where-Object objectclass -eq user | Select-Object samaccountname 
Add-ADGroupMember -Identity "avaya workplace" -Members $allusers
if (condition) {
    
}
Start-Sleep -Seconds 30
}