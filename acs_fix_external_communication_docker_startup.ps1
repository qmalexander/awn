if(Test-Path C:\acs_fix_external_communication_docker_start.ps1 -PathType Leaf)
{
  Remove-Item C:\acs_fix_external_communication_docker_start.ps1
}
$random = Get-Random -Maximum 100
Invoke-Expression "Start-BitsTransfer -Source https://raw.githubusercontent.com/qmalexander/awn/master/acs_fix_external_communication_docker_start.ps1?${random} -Destination C:\acs_fix_external_communication_docker_start.ps1"
C:\acs_fix_external_communication_docker_start.ps1
