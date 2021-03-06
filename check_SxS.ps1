﻿echo ""
echo "YOU NEED A .TXT FILE ON YOUR DESKTOP NAMED 'servers.txt'"
echo "WITH A LIST OF THE SERVERS YOU INTEND ON QUERYING WITH FOR THIS SCRIPT TO WORK"
echo "==="


# Set your username below
$LocalUsername = Read-Host "Enter your PC's username (local)"

echo "==="


# Set the domain in which the server(s) is located
$RemoteDomain = Read-Host 'Enter the domain of the remote target'


echo "==="
echo ""

$CheckPath = "C:\Windows\WinSxS"

ForEach ($ServerName in (get-content C:\Users\$LocalUsername\Desktop\servers.txt))
{

# Hacky way to get periods added into the FQDN, because I was too lazy to Google how to do it
$DOT = "."
$COM = "com"
$FQDN = $ServerName+$DOT+$RemoteDomain+$DOT+$COM
 
$cred = Get-Credential -Credential $ServerName\Administrator
$SourceSession = New-PSSession -Credential $cred -ComputerName $ServerName
Enter-PSSession $SourceSession

echo $FQDN
echo ""

function Get-Size
{
 param([string]$pth)
 "{0:n2}" -f ((gci -path $pth -recurse | measure-object -property length -sum).sum /1gb) + " gb"
}

Get-Size $CheckPath

Exit-PSSession
Remove-PSSession $SourceSession

}