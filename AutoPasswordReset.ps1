$checkforvault = Get-SecretVault ADPasswords
$checkforADpassword = get-secret ADpassword
Import-Module Microsoft.PowerShell.SecretManagement, Microsoft.PowerShell.SecretStore


if (!($checkforvault.name -eq "ADPasswords")) {
    Register-SecretVault -Name ADPasswords -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault
}
else {
    Write-Host "Vault Was Found"
}

if (!($checkforADpassword -like "System.Security.SecureString")) {
    Set-Secret -Name ADpassword -Vault ADPasswords
}
else {
    Write-Host "Encrypted AD Password found"
    Set-ADAccountPassword -Identity "cjclark" -NewPassword $checkforADpassword -OldPassword $checkforADpassword
    Set-ADAccountPassword -Identity "da-cjclark" -NewPassword $checkforADpassword -OldPassword $checkforADpassword
}


