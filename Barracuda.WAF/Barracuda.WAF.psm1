[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$Script:DEFAULT_HEADERS = @{
    'Content-Type' = 'application/json'
    'Accept' = 'application/json'
}

$Script:ACCESS_TOKEN = $null
$Script:BWAF_URI = "http://192.168.0.1:8000/"

$Paths = @(
    'Public',
    'Private'
)

foreach ($p in $Paths) {
    "$(Split-Path -Path $MyInvocation.MyCommand.Path)\$p\*.ps1" | Resolve-Path | ForEach-Object {
        if ($_.ProviderPath -notlike '*_TEMPLATE*') {
            Write-Host $_.ProviderPath
            . $_.ProviderPath
        }
    }
}

Export-ModuleMember -Function (Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1").BaseName