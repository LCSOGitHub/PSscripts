Start-Transcript

$today = Get-Date
$slackuri = 'https://hooks.slack.com/services/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'
$limit = (Get-Date).AddDays(-1460)
$path = read-host "What directory or drive would you like to purge?"

Write-Warning "Warning you are about to delete all files and folders in the $path DIR that is older than $limit" 

#this generates a CSV if the user wants one
switch (Read-Host "Would you like to preview what you would delete? Yes or No? Default is No. IF yes I will write a CSV where you ran the script") {
    "Yes" {Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $limit} | Select-Object -ExpandProperty Name | foreach {Add-Content -path "\\lcso-rms\fdrive\Infrastructure Group\Powershell Administrative Log\abouttodelete.csv" -Value $_}}
    Default {}
}

#Require the user to type CONFIRM
$confirm = Read-Host "Warning you are about to delete all files and folders in the $path DIR that is older than $limit please enter CONFIRM"
if ("CONFIRM" -eq $confirm) {
    # Delete files older than the $limit.
    Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $limit } | Remove-Item -Force

    # Delete any empty directories left behind after deleting the old files.
    Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse
}

else {
    throw "Operation Aborted"
}

try {
    Send-SlackMessage -Uri $slackuri -Text "The dir $path Has been cleaned on $today"    
}
catch {
    Write-Host "failed to send slack msg, need module PSSlack installed to powershell use install-module PSSlack"
}


Stop-Transcript