<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    Example of how to use this cmdlet
.EXAMPLE
    Another example of how to use this cmdlet
.INPUTS
    Inputs to this cmdlet (if any)
.OUTPUTS
    Output from this cmdlet (if any)
.NOTES
    General notes
.COMPONENT
    The component this cmdlet belongs to
.ROLE
    The role this cmdlet belongs to
.FUNCTIONALITY
    The functionality that best describes this cmdlet
.LINK
    https://campus.barracuda.com/product/webapplicationfirewall/api/9.1.1
#>
function Update-SystemEnergizeUpdatesInformation {
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    Param (
        # SecurityDefinitionsAutoUpdate help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('security-definitions-auto-update')]
        [ValidateSet('On', 'Off')]
        [String]
        $SecurityDefinitionsAutoUpdate,

        # GeoipDefinitionsAutoUpdate help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('geoip-definitions-auto-update')]
        [ValidateSet('On', 'Off')]
        [String]
        $GeoipDefinitionsAutoUpdate,

        # VirusDefinitionsAutoUpdate help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('virus-definitions-auto-update')]
        [ValidateSet('On', 'Off')]
        [String]
        $VirusDefinitionsAutoUpdate,

        # VirusDefinitionsAutoUpdate help description
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [Alias('attack-definitions-auto-update')]
        [ValidateSet('On', 'Off')]
        [String]
        $AttackDefinitionsAutoUpdate
    )

    process {
        try {
            $PSBoundParameters |
                ConvertTo-Post |
                    Invoke-API -Path '/restapi/v3/system/energize-updates' -Method Put
        } catch {
            if ($_.Exception -is [System.Net.WebException]) {
                Write-Verbose "ExceptionResponse: `n$($_ | Get-ExceptionResponse)`n"
                if ($_.Exception.Response.StatusCode -ne 404) {
                    throw
                }
            } else {
                throw
            }
        }
    }
}