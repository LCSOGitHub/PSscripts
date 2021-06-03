$emaillog = Import-Csv -Path "N:\Infrastructure Group\Powershell Administrative Log\BIGBOY.CSV"
$distgroups = Import-Csv -Path "N:\Infrastructure Group\Powershell Administrative Log\distgroups.csv"

$distgroups | Where-Object -Property grouptype -eq "Universal, SecurityEnabled" | Select-Object PrimarySmtpAddress 
$smtpdistgroups = Import-Csv -path "N:\Infrastructure Group\Powershell Administrative Log\smtpdistgroups.csv"

$Recipients = Import-Csv -Path "N:\Infrastructure Group\Powershell Administrative Log\BIGBOY.CSV" | Select-Object Recipients

foreach ($email in $emaillog) {
    if ($Recipients -contains $smtpdistgroups) {
        Export-Csv -path "N:\Infrastructure Group\Powershell Administrative Log\verifiedemails.csv" -Append
    }
}