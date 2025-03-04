# Please go to the console and add an A record or/and AAAA record and then fill in the following parameters:
$domain = "your.domain"
$key = "your.key"
# The above fields are required

$check_ip_url = ""
# If not set, skip detection of current IP
# Only support services where the response is plaintext and the content is IP only, for example:
# https://ipecho.net/plain
# https://ip.atomo.cn

Set-Location -Path $PSScriptRoot
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function Get-DomainIP {
    Param($Domain)
    Write-Host "Domain name: $Domain"
    $ip = [System.Net.Dns]::GetHostAddresses($Domain)[0].IPAddressToString
    If (!$ip) {
        Write-Error "Can not get the IP of $Domain"
        Exit 11
    }
    Write-Host "Domain IP: $ip"
    Return $ip
}

function Get-CurrentIP {
    try {
        $response = Invoke-WebRequest -UseBasicParsing -Uri "https://ip.atomo.cn"
        $ip = $response.Content
        Write-Host "Current IP: $ip"
        Return $ip
    }
    catch {
        Write-Error $_.Exception.Message
        Exit 21
    }
}

function Update-IP {
    Param($IP)
    $url = "https://dyn.dns.he.net/nic/update?hostname=$domain&password=$key"
    If ($IP) {
        $url = $url + "&myip=$IP"
    }
    try {
        $response = Invoke-WebRequest -UseBasicParsing -Uri "$url"
        Write-Host $response.Content
    }
    catch {
        Write-Error $_.Exception.Message
        Exit 31
    }
    Exit 0
}

$ip = Get-DomainIP $domain
If ($check_ip_url) {
    $current = Get-CurrentIP
    If ($ip -eq $current) {
        Exit 1
    }
    Update-IP $current    
}
Else {
    Update-IP
}
