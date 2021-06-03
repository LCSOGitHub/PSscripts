$servers = get-adcomputer -Filter * -SearchBase "OU=LCSO Servers,DC=sheriffleefl,DC=org" | Select-Object -ExpandProperty Name

foreach ($server in $servers) {
    Invoke-Command $server { Get-WindowsFeature ADFS-Federation | where "installstate" -eq "Installed"} -ErrorAction SilentlyContinue
    # if ($test.pingsucceeded -eq $false) {
    #     $test.ComputerName  | Add-Content -Path "N:\Infrastructure Group\Powershell Administrative Log\badservers.txt"
    #     Write-Host "$server failed to connect"
    # }
}