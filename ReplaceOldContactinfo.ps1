



# $Alias = "GrubbChrisAlphaPageVerizon"
# $replacementSMTP = "2398410596@vtext.com"


Import-Csv -Path '\\lcso-rms\fdrive\Infrastructure Group\PSScripts\vzemagbizReplacement.csv' | foreach-object {set-mailcontact -identity $_.Alias -ExternalEmailAddress $_.replacementSMTP -ForceUpgrade}