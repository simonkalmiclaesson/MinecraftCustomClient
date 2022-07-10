#MinecraftCustomClient installer
#Author: Simon Kalmi Claesson

#Version:
$app_version = "1.0"
$app_vID = "A0122-ae3dc603-abc4-44f5-9f98-43d129e779f9"
$app_mtd = "857f@ecb93f88d52e"

#variables
$lastver_url = "https://raw.githubusercontent.com/simonkalmiclaesson/MinecraftCustomClient/main/Installer/lastVer.mt"
$lastver_name = $lastver_url | split-path -leaf
$updater_url = "https://raw.githubusercontent.com/simonkalmiclaesson/MinecraftCustomClient/main/Updater/MinecraftCustomClient_Updater.ps1"
$updater_name = $updater_url | split-path -leaf
$tempfolder_path = "$psscriptroot\MinecraftCustomClient_Installer_Temp"

#clear
cls

#Create temp folder
if (test-path $tempfolder_path) {} else {md $tempfolder_path}

#Update Section
  #Assemble mt tag
  [string]$mttag = $app_vID + ":" + $app_mtd
  #Get repo lastVer.mt
  $lastVer = curl -s "$lastver_url"
  #Check
  if ($mttag -eq $lastVer) {$isLatest = $true} else {$isLatest = $false}
  #Fix
  if ($isLatest -eq $false) {
    $curdir = get-location
    cd $tempfolder_path
    curl -s $updater_url | Out-File -file "$updater_name"
    start pwsh "-file $updater_name"
    exit
  }


#Rest of the code
"Updated!"
pause
