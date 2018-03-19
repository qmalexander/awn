if(Test-Path C:\acs_fix_external_communication_docker_start.ps1 -PathType Leaf)
{
  Remove-Item C:\acs_fix_external_communication_docker_start.ps1
}
Start-BitsTransfer -Source https://raw.githubusercontent.com/qmalexander/awn/master/acs_fix_external_communication_docker_start.ps1 -Destination C:\acs_fix_external_communication_docker_start.ps1
Start-Process -filepath C:\acs_fix_external_communication_docker_start.ps1
