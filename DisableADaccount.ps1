#Requires -Module ActiveDirectory


# Do be aware some sections of this script are commented out, This is to avoid write operations to the org. noted by the (DISABLED)
#Static and gobal vars.

$Year = (Get-Date).Year
$slackuri = 'https://hooks.slack.com/services/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'
$5digits = Read-Host "What is the 5 Digit(s)?"
$5digits = $5digits.Split(",")


foreach ($5digit in $5digits) {
    $UserSearch = Get-aduser -Filter * -Properties SamAccountName, Name, EmployeeID | Where-Object -Property EmployeeID -Match "$5digit" | Select-Object SamAccountName, Name, EmployeeID
    $UserSearch 
    $SelectSamAccount = $UserSearch | Select-Object -ExpandProperty SamAccountName
    $enumerateGroups = Get-ADPrincipalGroupMembership -Identity $SelectSamAccount | Select-Object SamAccountName | Where-Object -Property SamAccountName -NotContains "Domain Users"
    $enumerateGroups 
    Move-ADObject -Identity $SelectSamAccount -TargetPath "OU=$year,OU=Disabled Employees,DC=sheriffleefl,DC=org" 
    Disable-ADAccount -Identity $SelectSamAccount 

    #This fuction selects random characters from the peramter -characters
function Get-RandomCharacters($length, $characters) {
    $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length }
    $private:ofs=""
    return [String]$characters[$random]
}

#this function scrables a string using Get-Random
function Scramble-String([string]$inputString){     
    $characterArray = $inputString.ToCharArray()   
    $scrambledStringArray = $characterArray | Get-Random -Count $characterArray.Length     
    $outputString = -join $scrambledStringArray
    return $outputString 
}
 
$password = Get-RandomCharacters -length 10 -characters 'abcdefghiklmnoprstuvwxyz'
$password += Get-RandomCharacters -length 3 -characters 'ABCDEFGHKLMNOPRSTUVWXYZ'
$password += Get-RandomCharacters -length 3 -characters '1234567890'
$password += Get-RandomCharacters -length 3 -characters '!"$%&/()=?}][{@#*+'

#random password output is $password
$password = Scramble-String $password
    Set-ADAccountPassword -Identity $SelectSamAccount -NewPassword $password 
}

Start-Job -ScriptBlock {
    #send slack notice as i cannot get send-mailmessage after 24 hours of a user being disabled to stript runner to notify 24 hours have passed and user is ready to removed from the email thing.
    Start-Sleep -Seconds 86400
    Send-SlackMessage -Uri $slackuri -Text "The user $selectsamaccount is ready to have its mailbox removed from Exchange"    
}

#Need to research Send-mailmessege as the line below does not work.
#Send-MailMessage -SmtpServer outlook.sheriffleefl.org -To cjclark@sheriffleefl.org  -From cjclark@sheriffleefl.org -Subject "Greetings from the mailserver" -Credential (Get-Credential) -Port 443 -UseSsl -WarningAction Ignore

Get-Random -InputObject $upperletters 


