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
#>
function ConvertTo-PostData {
    [CmdletBinding()]
    [OutputType([Hashtable])]
    Param (
        # InputObject help description
        [Parameter(
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Hashtable]
        $InputObject,

        # ConcatChar help description
        [Parameter(
            Mandatory = $false
        )]
        [ValidateNotNullOrEmpty()]
        [String]
        $ConcatChar = '-',

        # IgnoreProperty help description
        [Parameter(
            Mandatory = $false
        )]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $IgnoreProperty = @()
    )
    
    process {
        $postData = @{}

        $keys = $InputObject.Keys | Sort-Object
        foreach ($key in $keys) {
            if (-not $IgnoreProperty.Contains($key)) {
                $postData.$(($key -creplace '(?<=[a-z])([A-Z])', ('{0}$0' -f $ConcatChar)).ToLower()) = $InputObject.$key
            } else {
                $postData.$($key.ToLower()) = $InputObject.$key
            }
        }

        foreach ($commonParameter in (Get-CommonParameter)) {
            $postData.Remove($commonParameter) | Out-Null
        }

        $postData
    }
}