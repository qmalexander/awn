Get-Service docker | Stop-Service -PassThru | Set-Service -StartupType manual
$testPath = Test-Path C:\hns.psm1 -PathType Leaf;
if($testPath  -eq $false){
  Start-BitsTransfer -Source https://raw.githubusercontent.com/Microsoft/SDN/master/Kubernetes/windows/hns.psm1 -Destination C:\hns.psm1
}
Import-Module -name C:\hns.psm1 -Verbose
Stop-Service kubeproxy
Stop-Service kubelet
Get-HNSNetwork | ? Name -eq l2Bridge | Remove-HnsNetwork 
Get-HnsPolicyList | Remove-HnsPolicyList
Start-Service docker
Start-Service kubelet
Start-Service kubeproxy
