$currentFile = $MyInvocation.MyCommand.Definition

if(Get-ScheduledTask "TeleoptiFix" -EA SilentlyContinue)
{
    Write-Host 'Found TeleoptiFix'
}
else{
    Write-Host 'Register TeleoptiFix'
    $trigger = New-JobTrigger -AtStartup -RandomDelay 00:00:30
    Register-ScheduledJob -Trigger $trigger -FilePath $currentFile -Name TeleoptiFix    
}

if(Get-HotFix | Where-Object HotFixID -Match "KB4089848"){
    Write-Host 'Found KB4089848'

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
}
else {
    Write-Host 'Installing KB4089848'
    Invoke-WebRequest http://download.windowsupdate.com/d/msdownload/update/software/updt/2018/03/windows10.0-kb4089848-x64_db7c5aad31c520c6983a937c3d53170e84372b11.msu -Out c:\kb4089848.msu
    wusa.exe c:\kb4089848.msu /quiet /forcerestart
}
