Import-Module ActiveDirectory -WarningAction SilentlyContinue


# Do be aware some sections of this script are commented out, This is to avoid write operations to the org.
while ($true) {
    

$5digits = Read-Host "What is the 5 Digit(s)?"
$5digits = $5digits.Split(",")
$PresetPassword = ConvertTo-SecureString -AsPlainText "Welcome1"
foreach ($5digit in $5digits) {
    $UserSearch = Get-aduser -Filter * -Properties SamAccountName, Name, EmployeeID | Where-Object -Property EmployeeID -Match "$5digit" | Select-Object SamAccountName, Name, EmployeeID
    $resultsdisplay = $UserSearch | Format-List | Out-String
    write-host $resultsdisplay
    $SelectSamAccount = $UserSearch | Select-Object -ExpandProperty SamAccountName
    $Readhost = Read-Host " ( Y / N ) Default is  Y" 
    Switch ($ReadHost) 
     { 
       Y {Write-host "Yes, Resetting $selectSamAccount to Welcome1"; Set-ADAccountPassword -Identity $SelectSamAccount -NewPassword $PresetPassword -Reset
        Unlock-ADAccount $SelectSamAccount} 
       N {Write-Host "No, Aborting Operation"; throw "User aborted operation"} 
       Default {Write-Host "Default, Resetting $selectSamAccount to Welcome1" ; Set-ADAccountPassword -Identity $SelectSamAccount -NewPassword $PresetPassword -Reset} 
     } 
}
}

