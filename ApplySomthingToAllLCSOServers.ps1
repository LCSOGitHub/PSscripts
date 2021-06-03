$computers = get-adcomputer -Filter * -SearchBase "OU=LCSO Servers,DC=sheriffleefl,DC=org" | Select-Object -ExpandProperty Name

# foreach ($computer in $computers) {
#     invoke-command $computer -scriptblock {
#         $module = Get-Module pswindowsupdate | Select-Object -ExpandProperty Name
#         if("pswindowsupdate" -contains $module){
#             Write-Host "I $env:COMPUTERNAME have PS windows update"
#         }
#         else {
#             install-module pswindowsupdate -Force -Confirm
#             Write-Host "I $env:COMPUTERNAME have installed pswindowsupdate"
#         }
#     }
# }
foreach ($computer in $computers) 
{
    $Servername = invoke-command $computer -scriptblock {"Data from $env:COMPUTERNAME"}
    $updates = invoke-command $computer -scriptblock {Get-CimInstance Win32_OperatingSystem | select-object Caption,Version,BuildNumber,OSArchitecture} || Get-WmiObject $computer -Property *


    $caption = $updates | Select-Object -ExpandProperty Caption
    $Version = $updates | Select-Object -ExpandProperty Version
    $BuildNumber = $updates | Select-Object -ExpandProperty BuildNumber
    $OSArch = $updates | Select-Object -ExpandProperty OSArchitecture

    $Inventory = @(

        "$Computer","$caption","Version $version","Build Number $buildnumber","CPU Type $OSArch","$OS",""
        
        )
      
        $Inventory | foreach { Add-Content -LiteralPath "\\lap-11755\public\Currentserverversion.csv" -Value $_ }
        Write-Host "$Computer added to excel sheet"  
}