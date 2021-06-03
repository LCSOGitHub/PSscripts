Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "d:\ds"
import-mdtdriver -path "DS001:\Out-of-Box Drivers\HP\HP EliteDesk 800 G6 Mini" -SourcePath "\\hdq-mdt\DS\Working\HP EliteDesk 800 G6 Desktop Mini PC\Networking" -Verbose
