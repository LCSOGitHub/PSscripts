# $servers

# foreach ($server in $Servers) {
#     Invoke-Command $Server -Scriptblock {     
#         Write-Host "Installing Sophos"
    
#         Start-Process "\\lcso-rms\fdrive\Infrastructure Group\Software\Sophos Server Installer" -ArgumentList "/quiet" -Wait
    
#         Write-Host "Sophos Installed" 
#     }
# }

Invoke-Command hdq-orion-poll -Scriptblock {     
    Write-Host "Installing Sophos"

    Start-Process "\\lcso-rms\fdrive\Infrastructure Group\Software\Sophos Server Installer\SophosSetup.exe" -ArgumentList "/quiet" -Wait

    Write-Host "Sophos Installed" 
}

$secpasswd = ConvertTo-SecureString "Wailntard!" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ("$env:USERDOMAIN\da-cjclark", $secpasswd)
invoke-command -ComputerName "hdq-orion-poll" -ScriptBlock {Start-proccess "\\lcso-rms\fdrive\Infrastructure Group\Software\Sophos Server Installer\SophosSetup.exe" -ArgumentList "/quiet" -Wait -Credential $using:mycreds}