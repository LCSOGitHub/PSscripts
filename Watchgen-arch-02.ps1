while ($true) {
    Start-Sleep -Seconds 320
    $status = Get-Service GenetecServer | Select-Object status
        if ($status.Status -eq 'Stopped') {
            Send-MailMessage -SmtpServer "mail.sheriffleefl.org" -To "cjclark@sheriffleefl.org" -Cc "JR@sheriffleefl.org","JQuaintance@sheriffleefl.org","Wgoble@sheriffleefl.org" -Subject "eoc-gne-arch-02 detecteds as service down, restarting server in 30 seconds." -from "cjclark@sheriffleefl.org"
            shutdown /r /t 30
        }
}