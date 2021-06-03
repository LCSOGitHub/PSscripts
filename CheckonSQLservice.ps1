if ((Get-Service -Name MSSQLSERVER).Status -eq 'Stopped') {
    Start-Service MSSQLSERVER   
    Start-Sleep 60
    Send-MailMessage -To "systems@sheriffleefl.org" -From "cjclark@sheriffleefl.org" -Subject "MSSQLSERVER was stopped when I checked at 6:00AM EST" -SmtpServer "mail.sheriffleefl.org" -Body "I have also started the service" -UseSsl -Priority Low -Cc "cjclark@sheriffleefl.org"
}
