$testPath = Test-Path C:\hns.psm1 -PathType Leaf;
if($testPath  -eq $false){
  Start-BitsTransfer -Source https://raw.githubusercontent.com/Microsoft/SDN/master/Kubernetes/windows/hns.psm1 -Destination C:\hns.psm1
}
Import-Module -name C:\hns.psm1 -Verbose
Stop-Service kubelet
Stop-Service kubeproxy
Get-HNSNetwork | ? Name -eq l2Bridge | Remove-HnsNetwork 
Get-HnsPolicyList | Remove-HnsPolicyList
Start-Service kubelet
Start-Service kubeproxy
