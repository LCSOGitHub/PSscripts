$servers = Get-ADComputer -Filter * -SearchBase "OU=LCSO Servers,DC=sheriffleefl,DC=org" | Select-Object -ExpandProperty name
while (condition) {
    
}
foreach -parallel 4 ($server in $servers) {
    try {
        New-PSSession $server
    }
    catch {
        Write-Host "Connection was not made to $server"
    }
}
