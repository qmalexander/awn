$currentFile = $MyInvocation.MyCommand.Definition

if(Get-ScheduledTask "TeleoptiFix" -EA SilentlyContinue)
{
    Write-Host 'Found TeleoptiFix'
}
else{
    Write-Host 'Register TeleoptiFix'
    $trigger = New-JobTrigger -AtStartup -RandomDelay 00:02:00
    Register-ScheduledJob -Trigger $trigger -FilePath $currentFile -Name TeleoptiFix    
}

if(Get-ScheduledTask "TeleoptiCheckLogs" -EA SilentlyContinue)
{
    Write-Host 'Found TeleoptiCheckLogs'
}
else{
    Write-Host 'Register TeleoptiCheckLogs'
    Start-BitsTransfer -Source https://raw.githubusercontent.com/qmalexander/awn/master/acs_checklogs.ps1 -Destination c:\acs_checklogs.ps1
    $trigger = New-JobTrigger -Daily -At "1:15 AM"
    Register-ScheduledJob -Trigger $trigger -FilePath c:\acs_checklogs.ps1 -Name TeleoptiCheckLogs   
}


if(Test-Path "c:\kb4089848.msu"){
    Remove-Item "c:\kb4089848.msu"
}

$path = "C:\k\"

if(!(test-path $path)){
    New-Item -ItemType Directory -Path $path
}

$testPath = Test-Path C:\k\hns.psm1 -PathType Leaf;
if($testPath  -eq $false){
    Start-BitsTransfer -Source https://raw.githubusercontent.com/Microsoft/SDN/master/Kubernetes/windows/hns.psm1 -Destination C:\k\hns.psm1
}
Import-Module -name C:\k\hns.psm1 -Verbose
Stop-Service docker
Stop-Service kubeproxy
Stop-Service kubelet
Get-HNSNetwork | ? Name -eq l2Bridge | Remove-HnsNetwork 
Get-HnsPolicyList | Remove-HnsPolicyList
Start-Service docker
Start-Service kubelet
Start-Service kubeproxy
