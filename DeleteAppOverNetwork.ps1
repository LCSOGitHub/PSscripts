#define Part Name of the App
$AppName = "Java"
#define minimum version that should stay
[version]$TargetVersion = "3.0"

# x64 HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
# x86 HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall

$reg32 = Get-ChildItem -Path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall
$reg64 = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall

# gather x86 installations
foreach ($app32 in $reg32) {
    Set-Location HKLM:
    if (Get-ItemProperty -Path $app32 | Where-Object {
            $_.Displayname -like "*$AppName*" -and [version]$_.DisplayVersion -lt $TargetVersion
        }) {
        Set-Location c:
        Start-Process -FilePath "$env:SystemRoot\System32\msiexec.exe" -ArgumentList "/x $($app32.PsChildName) /qn /noreboot" -Wait
    }

}
# gather x64 installations
foreach ($app64 in $reg64) {
    Set-Location HKLM:
    if (Get-ItemProperty -Path $app64 | Where-Object {
            $_.Displayname -like "*$AppName*" -and [version]$_.DisplayVersion -lt $TargetVersion
        }) {
        Set-Location c:
        Start-Process -FilePath "$env:SystemRoot\System32\msiexec.exe" -ArgumentList "/x $($app64.PsChildName) /qn /noreboot" -Wait
    }

}