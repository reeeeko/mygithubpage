Instructions: Place a 'servers.txt' file on your desktop with a list of the remote target servers. No delimiters are needed, just list them such as:

ProdServer1
ProdServer2

Also: IF YOU ARE SENDING COMMANDS TO A REMOTE MACHINE IN A DIFFERENT DOMAIN, YOU WILL NEED TO CREATE TRUST BETWEEN THE TWO, WITH THE FOLLOWING COMMANDS:
 

== On both remote machine/server, run Powershell as administrator, and enter the following command:

Enable-PSRemoting -Force

== On both remote machine/server, enter the command:

winrm set winrm/config/client '@{TrustedHosts="<Computername or IP address of other computer"}'

== Then, restart the WinRM service on both machines:

Restart-Service WinRM

== To make sure things went smooth, on the local machine, test the WinRM connection between to the remote server: 

Test-WsMan <RemoteCOMPUTERName>

