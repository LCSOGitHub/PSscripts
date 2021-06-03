Remove-Item "\\lcso-rms\fdrive\Infrastructure Group\Certificates\Servercerts.csv" -Force

$computers = get-adcomputer -Filter * -SearchBase "OU=LCSO Servers,DC=sheriffleefl,DC=org" | Select-Object -ExpandProperty Name

foreach ($computer in $computers) {
    $certs = Invoke-Command $computer {Get-ChildItem "Cert:\LocalMachine\My"}
    $hostname = Invoke-Command $computer {HOSTNAME.EXE}

  

  $Inventory = @(

  "$certs","$hostname"
  
  )

  $Inventory | foreach { Add-Content -Path  "\\lcso-rms\fdrive\Infrastructure Group\Certificates\Servercerts.csv" -Value $_ }
  Write-Host "$computer added to excel sheet"
}
