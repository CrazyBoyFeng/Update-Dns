# Update-Dns
DDNS script

## Usage
0. Log in to the DNS Service Provider Console and add a domain name resolution record.  
1. Download the script launcher `Update-Dns.Cmd` and the script `Update-Dns.PS1`.  
2. Modify `Update-Dns.PS1` with the required parameters.
3. Execute `Update-Dns.Cmd`. Default regular window mode. Pauses when finished. The launcher can be adjusted with the parameters:
* `Update-Dns.Cmd Minimized` Minimized window mode. Pauses only on error.
* `Update-Dns.Cmd Hidden` Hidden window mode. Exits when finished. The execution result can be judged by the exit code and the output file.
4. Use the Task Scheduler to create periodic execution task.