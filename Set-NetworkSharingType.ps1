#thanks microsoft...
#ProjectPatatoe
#=======admin?
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{  
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}
#=======admin? END
Get-NetConnectionProfile | Select-Object InterfaceIndex, Name,InterfaceAlias,NetworkCategory,IPv4Connectivity,IPv6Connectivity | Format-Table

$choiceNet = Read-Host -Prompt "Change which InterfaceIndex?"
$net = Get-NetConnectionProfile -InterfaceIndex $choiceNet -ErrorAction SilentlyContinue -ErrorVariable SomeError
if ($net -eq $null) {
    Write-Host "Doesnt exist!!!" -ForegroundColor red
    pause
    break
    }
Write-Host ("Changing {0}" -f $net.Name)
Write-Host "1:Public"
Write-Host "2:Private"
Write-Host "3:Domain"
$choice = Read-Host -Prompt "Type:"

Switch ($choice)
{
    1 {Set-NetConnectionProfile -NetworkCategory "Public"  -InputObject $net }
    2 {Set-NetConnectionProfile -NetworkCategory "Private" -InputObject $net }
    3 {Set-NetConnectionProfile -NetworkCategory "Domain"  -InputObject $net }
}
Get-NetConnectionProfile | Select-Object InterfaceIndex, Name,InterfaceAlias,NetworkCategory,IPv4Connectivity,IPv6Connectivity | Format-Table
Pause