$users = get-aduser -Filter * | Where-Object enabled -eq true
$userfolders = Get-ChildItem -Path "\\eoc-qumulo01\Home-P-Drive\Home\cjclark"

