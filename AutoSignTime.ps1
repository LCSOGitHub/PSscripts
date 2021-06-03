#guide https://adamtheautomator.com/getting-started-in-web-automation-with-powershell-and-selenium/
#script sould be set to run at second and 4th Monday of every month at 12:00 AM EST
Start-Transcript 
#Requires -Module "selenium"
$VCSURL = "https://login.vcssoftware.com/sdefault?ReturnUrl=%2fposshome"
$driver = Start-SeFirefox -StartURL $VCSURL
# get-command * -Module Selenium

#login process need to setup var to maintain my AD password for login.
$driver.FindElementByXPath('//*[@id="txtSiteCode"]').SendKeys("lcsfl")
$driver.FindElementByXPath('//*[@id="txtUserName"]').SendKeys("2020103")
$driver.FindElementByXPath('//*[@id="txtPassword"]').SendKeys("$env:mypassword")
$driver.FindElementByXPath('//*[@id="btnSubmit_input"]').click()
#Click "Employee"
$driver.FindElementByXPath('/html/body/form/div[6]/div[1]/div[2]/ul/li[4]/span').click()
#Click "Review Timesheets"
$driver.FindElementByXPath('/html/body/form/div[6]/div[3]/table/tbody/tr[2]/td[1]/div[2]/div/div[3]/div/ul/li/div/ul/li[4]/div/ul/li/a/span[1]').click()
#Get hours worked.
$getTotalhours = $driver.FindElementByXPath('/html/body/form/div[6]/div[3]/table/tbody/tr[2]/td[2]/div/div[2]/div/div/div/table[5]/tbody/tr/td[2]/table/tbody/tr[2]/td[1]')
$Totalhours = $getTotalhours | Select-Object -ExpandProperty Text
#get Overtime entered
$getTotalOT = $driver.FindElementByXPath('/html/body/form/div[6]/div[3]/table/tbody/tr[2]/td[2]/div/div[2]/div/div/div/table[5]/tbody/tr/td[2]/table/tbody/tr[2]/td[3]')
$TotalOT = $getTotalOT | Select-Object -ExpandProperty Text


#click "Sign"
# $driver.FindElementByXPath('/html/body/form/div[6]/div[3]/table/tbody/tr[2]/td[2]/div/div[2]/div/div/div/table[9]/tbody/tr/td[2]/button/span').click()
Send-MailMessage -To "cjclark@sheriffleefl.org" -From "cjclark@sheriffleefl.org" -SmtpServer "mail.sheriffleefl.org" -Subject "Time has been submited" -Body "I submitted a total hours of $totalhours and submitted $totalOT hours of OT."
$driver.Quit()
