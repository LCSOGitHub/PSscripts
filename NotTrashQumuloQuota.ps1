
$qumulohost = "eoc-qumulo01"
$qumulouser = "admin"
$qumulopwd = "T@c05mel1"
# $qumuloshare = "Home-P-Drive"
# $qumulopath = "\\eoc-qumulo01\Home-P-Drive\users"
$userfiles = Get-ChildItem "\\eoc-qumulo01\Home-P-Drive\home" | Select-Object name
$quota = 5GB
# $qqpath = "C:\Users\blackbeard\AppData\Local\Programs\Python\Python39\Scripts\qq.exe"

python qq.exe --host $qumulohost login --user $qumulouser --password $qumulopwd
foreach ($userfile in $userfiles)
{
	python qq.exe --host $qumulohost quota_create_quota --path "\\eoc-qumulo01\Home-P-Drive\home\$userfile" --limit $quota
}