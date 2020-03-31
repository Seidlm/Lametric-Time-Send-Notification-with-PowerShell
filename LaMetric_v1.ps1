########################################################
# Name: LaMetric.ps1                              
# Creator: Michael Seidl aka Techguy                    
# CreationDate: 28.12.2018
# LastModified: 28.12.2018
# Version: 1.0
# Doc: http://www.techguy.at/tag/LaMetric/
# PSVersion tested: 3 and 4
#
# Version 1.0 - RTM
########################################################
#
# www.techguy.at                                        
# www.facebook.com/TechguyAT                            
# www.twitter.com/TechguyAT                             
# michael@techguy.at 
########################################################

# PowerShell Self Service Web Portal at www.au2mator.com/PowerShell

#Api Settings
$LametricIP="192.168.1.199"
$ApiKey="#####"

#Alert settings
$Priority="info" #"info, warning, critical
$Icon="25675" #25674 = au2mator, 25675=Techguy
$Text="www.techguy.at is my favorite Blog"
 
$SoundCategory="notifications" #notifications, alarms
$SoundId="notification4"
$SoundRepeat="2"

$DisplayCount=1


#Code
#Build JSon
$json=@"
{
   "priority":"$Priority",
   "model": {
        "frames": [
            {
               "icon":$Icon,
               "text":"$Text"
    
            }
        ],
        "sound": {
            "category": "$SoundCategory",
            "id": "$SoundId",
            "repeat":$SoundRepeat
        },
        "cycles":$DisplayCount
    }
    
}
"@

$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("dev:$ApiKey"))) 
$header = @{ 
    Authorization=("Basic {0}" -f $base64AuthInfo) 
} 

Invoke-RestMethod -Method POST -Uri ("http://"+$LametricIP+":8080/api/v2/device/notifications") -ContentType "application/json" -Headers $header -UseBasicParsing -Body $json

