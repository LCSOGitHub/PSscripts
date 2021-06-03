Import-Module Selenium
$Driver = Start-SeFirefox -Headless
Enter-SeUrl "https://www.opentextingonline.com/" -Driver $Driver
$phonenum = read-host "what is your phone number that you want to be texted at? In the form of (xxx)xxx-xxxx please include the parentheses and hyphens"


$websitetowatch = read-host "What is the website URL you would like to watch? (Only one please, Where the Org would post thier job postings)" 
#Useing current date as a file ext to not get overlapping files.
$dateforfileext = (get-date).ToFileTimeUtc()
Invoke-WebRequest -uri "$websitetowatch" | Select-Object -ExpandProperty rawcontent | out-file $env:temp\website$dateforfileext.txt
$website = "$env:temp\website$dateforfileext.txt"

Write-Host "Awesome, got it, I will be grabbing the content of this website every 5 min and looking for the words you want me to watch for."
$terms = Read-Host "what do you want me to look for? Comma seperated values please"
#now time to Foreach loop for every term used on the website, wait 5 min and loop again

function Loop-terms {
    foreach ($term in $terms) {
        if (Select-String $term $website) {
            #look for the string in this IF statement.
            $driver.FindElementByXPath('//*[@id="phone"]') | Send-SeKeys $phonenum
            $driver.FindElementByXPath('//*[@id="tmessage"]') | Send-SeKeys "I found something on website $websitetowatch"
        }
        else {
            #if not found loop the function again.
            Write-Host "Loop exited, starting again."
            remove-item $website -Force
            Start-Sleep -Seconds 300
            Invoke-WebRequest -uri "$websitetowatch" | Select-Object -ExpandProperty rawcontent | out-file $env:temp\website$dateforfileext.txt
        }
    }
} 
Loop-terms