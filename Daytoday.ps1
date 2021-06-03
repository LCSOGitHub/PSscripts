#secret mangement!
#https://devblogs.microsoft.com/powershell/secretmanagement-and-secretstore-are-generally-available/


throw {
  "you are not supposed to run this, failsafe triggered"
}


Install-Module Microsoft.PowerShell.SecretManagement, Microsoft.PowerShell.SecretStore

Install-Module importexcel
Set-Location C:\Users\cjclark\Documents
$servers = Import-Excel "OldMcafeeInstalls.xlsx" | Where-Object Tags -eq Server
$Servernames = Import-Excel "OldMcafeeInstalls.xlsx" | Where-Object Tags -eq Server | Export-Excel | Select-Object -ExpandProperty "system Name" 

# Import-Excel "OldMcafeeInstalls.xlsx" | Where-Object "system name" -eq $null | Set-Row -

$slackuri = 'https://hooks.slack.com/services/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'


Send-MailMessage -To "jr@sheriffleefl.org" -Cc "rfsmith@sheriffleefl.org" -From "cjclark@sheriffleefl.org" -Subject (get-date) -SmtpServer "mail.sheriffleefl.org" -Body "This email was sent by my computer on the time of the subject line."

cd "N:\Infrastructure Group\Documentation\Inventory\Inventory Photos"
$lenghts = dir | Select-Object -ExpandProperty Length 
($lenghts | measure-object -Average).Average
$lenghts.Count

#this is how you check last boot up time on a system
Get-CimInstance Win32_OperatingSystem | Select-Object LastBootUpTime


#Start OMS website with IE.
$IE=new-object -com internetexplorer.application
$IE.navigate("http://hdq-apache.sheriffleefl.org/OMS")
$IE.visible=$true


$computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

foreach ($computer in $computers) {
    $make = Invoke-Command $computer {Get-WmiObject  win32_bios | Select-Object -ExpandProperty Manufacturer}
    $Serial = Invoke-Command $computer {Get-WmiObject  win32_bios | Select-Object -ExpandProperty SerialNumber}
    $hostname = Invoke-Command $computer {HOSTNAME.EXE}
    $user = Invoke-Command $computer {(Get-WMIObject -class Win32_ComputerSystem | Select-Object username).username}
    # Export-Csv -path "\\lcso-rms\fdrive\Infrastructure Group\Documentation\Inventory\WhatIFound.csv" -InputObject "$makeandSerial, $hostname, $user" -Append
    Add-Content -Path "\\lcso-rms\fdrive\Infrastructure Group\Documentation\Inventory\WhatIFound.csv"  -Value '"Make","Serial","Hostname","UserName"'

  

  $Inventory = @(

  "$make","$Serial","$hostname","$user"
  
  )

  $Inventory | foreach { Add-Content -Path  "\\lcso-rms\fdrive\Infrastructure Group\Documentation\Inventory\WhatIFound.csv" -Value $_ }
  Write-Host "$computer added to excel sheet"
}


#Resize a Volume!
$size = (Get-PartitionSupportedSize -DriveLetter C)
Resize-Partition -driveletter C -Size $size.SizeMax


New-ScheduledTask 

$servers = get-adcomputer -Filter * -SearchBase "OU=LCSO Servers,DC=sheriffleefl,DC=org" | Select-Object -ExpandProperty Name | ForEach-Object {Invoke-Command $_ {Get-ChildItem "Cert:\LocalMachine\My" | Format-Table Subject, FriendlyName, Thumbprint -AutoSize | export-csv "\\lcso-rms\fdrive\Infrastructure Group\PSScripts\Servercerts.csv" -Append}


Get-ExchangeServer | "\\lcso-rms\fdrive\Infrastructure Group\PSScripts\Test-ProxyLogon.ps1" -OutPath $home\desktop\logs


# 172.24.108.0    255.255.255.192 172.24.108.1         internal         1      4051     ISIS 0   IBSV 200
# 172.24.108.64   255.255.255.192 172.24.108.65        internal         1      4051     ISIS 0   IBSV 200
# 172.24.108.192  255.255.255.192 172.24.108.193       internal         1      4051     ISIS 0   IBSV 200
# 172.24.109.0    255.255.255.192 172.24.109.1         internal         1      4051     ISIS 0   IBSV 200
# 172.24.110.0    255.255.255.192 EOC_CAB13_7400B_CORE internal         40     4051     ISIS 0   IBSV 200
# 172.24.110.192  255.255.255.192 EOC_CAB13_7400B_CORE internal         40     4051     ISIS 0   IBSV 200
# 172.24.112.0    255.255.240.0   172.24.112.1         internal         1      4051     ISIS 0   IBSV 200
# 172.24.200.0    255.255.255.0   172.24.200.1         internal         1      4051     ISIS 0   IBSV 200


# Port Tagging and VLAN
# In ExtremeXOS, there are tagged ports and untagged ports. A tagged port will send and receive 802.1Q
# tagged packets to or from a specific VLAN. An untagged port will send untagged traffic to or from a
# specific VLAN.
# You can choose from one of the following options:
# • Untagged Ports — Because there’s no way to distinguish between VLANs when using untagged
# traffic, a port can be assigned as an untagged port to only one VLAN at a time. If you want
# untagged traffic to go to a different VLAN, you have to delete the port from the old VLAN before
# you can add it to the new one as an untagged port. If you do not specify whether the port should be
# added as tagged or untagged, untagged is assumed.
# • Tagged Ports — Because traffic can be distinguished based on the 802.1Q tag value, a port can be
# assigned as tagged to multiple VLANs at a time. The 802.1Q tag value assigned to the VLAN
# determines which tag value is used.
# • Mixing Tagged and Untagged Traffic — ExtremeXOS fully supports mixing tagged and untagged
# traffic. A port can be an untagged member of one VLAN and a tagged member of several other
# VLANs simultaneously.


# How to I-SID for 400$ Alex
# vlan create 500 name "Nimble_Replication" type port-mstprstp 0 
# vlan i-sid 500 210500
# interface Vlan 500
# vrf internal
#                 ip address 172.24.250.1 255.255.255.192
#                 ip rsmlt
#                 ip rsmlt holdup-timer 9999
#                 exit

# vlan create 500 name "Nimble_Replication" type port-mstprstp 0 
# vlan i-sid 500 210500
# interface Vlan 500
# vrf internal
                # ip address 172.24.250.2 255.255.255.192
                # ip rsmlt
                # ip rsmlt holdup-timer 9999
                # exit


#While it is something they can do, scheduled tasks are not intended for launching startup programs for the user to interact with.
#They are for performing maintenance/administrative tasks.
#I don't know if thats the cause of the issue but I would advise that for your startup programs, you putt a link to the program in
#%appadata%\Microsoft\Windows\Start Menu\Programs\Startup
#You could also just put a link to powershell calling the script that opens programs in there if you prefer to manage the list via paths in the script file over managing the contents of a folder.

# How to install “PS2EXE GUI” PS1 to EXE converter
# 1. Run “powershell.exe”
# 2. Execute the following:

# Install-Module -Name ps2exe
# 3. While, you can use “ps2exe” switches while scripting automations, I prefer the GUI. For GUI, execute in powershell.exe: "win-ps2exe"

# The source PS1 script can be decompiled back from the EXE using the “-extract” switch on the executable:

# Executable.exe -extract:C:\Source.ps1
# So, make sure you don’t store any sensitive data in your script.!!!


Set-ReceiveConnector -RemoteIPRanges '205.139.111.40-205.139.111.49','207.211.30.40-207.211.30.49','63.128.21.0(255.255.255.0)','216.205.24.0(255.255.255.0)','205.139.111.0(255.255.255.0)','205.139.110.0(255.255.255.0)','207.211.30.0(255.255.255.0)','207.211.31.0(255.255.255.128)','170.10.130.0(255.255.255.0)','170.10.131.0(255.255.255.0)','170.10.129.0(255.255.255.0)','170.10.128.0(255.255.255.0)','170.10.133.0(255.255.255.0)','172.10.132.0(255.255.255.0)' -Identity 'EOC-CAS1\Default EOC-CAS1'

# lastLogon                            : 132651428484289920
# LastLogonDate                        : 5/10/2021 1:12:33 PM
# lastLogonTimestamp                   : 132651403537059961

get-aduser -Filter * -Properties * -SearchBase 'OU=LCSO Users,DC=sheriffleefl,DC=org' | where {($_.passwordexpired -eq "$True") -and ($_.LastLogonDate -gt (get-date).AddDays(-120))} | select -ExpandProperty name | FT
$expiredusers.count
if ($timetobeat -ine $mytime) {
  Write-Host "cond is true!"
}
$mytime = get-aduser cjclark -Properties LastLogonDate | select LastLogonDate


$Direction = Read-Host “Ingrese IMCEAEX”
$Remplazo= @(@("_","/"), @("\+20"," "), @("\+28","("), @("\+29",")"), @("\+2C",","), @("\+3F","?"), @("\+5F", "_" ), @("\+40", "@" ), @("\+2E", "." ))
$Remplazo | ForEach { $Direccion = $Direccion -replace $_[0], $_[1] }
$Direccion = “X500:$Direccion” -replace “IMCEAEX-“,”” -replace “@.*$”, “”
Write-Host $Direction
