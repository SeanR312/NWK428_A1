<#
.SYNOPSIS


.DESCRIPTION

.NOTES
Author: Sean Reschke
Unit: ICTNWK428
Assessment: Assessment 1 - Gather Operating System Information

#>

<#
.SYNOPSIS

.DESCRIPTION

.OUTPUTS

.EXAMPLE

Returns
#>

function Test-InputExists {

    param(
        [string]$UserChoice
    )

    if ([string]::IsNullOrEmpty($UserChoice)) {

        Write-Host "Invalid input. A menu selection is required."

        return $false
    }

    return $true
}

<#
.SYNOPSIS

.DESCRIPTION

.OUTPUTS

.EXAMPLE

Returns
#>

function Test-Whitespace {

    param(
        [string]$UserChoice
    )

    if ([string]::IsNullOrWhiteSpace($UserChoice)) {
    
        Write-Host "Invalid input. A menu selection is required."
    
        return $false

    }

    return $true

}

<#
.SYNOPSIS

.DESCRIPTION

.OUTPUTS

.EXAMPLE

Returns
#>

function Convert-ToInteger {

    param(
        [string]$UserChoice
    )

    # Validate that the input contains
    # Whole numbers only

    if ($UserChoice -notmatch '^\d+$') {    
    
        Write-Host "Invalid input. Menu selections must be whole numbers."
    
        return $null

    }

    # Converted validated input to Interger

    return [int]$UserChoice

}

<#
.SYNOPSIS

.DESCRIPTION

.OUTPUTS

.EXAMPLE

Returns
#>

function Test-MenuRange {

    param(
        [int]$UserChoice
    )

    if ($UserChoice -lt 1 -or $UserChoice -gt 9) {
    
        Write-Host "Invalid input. Please enter a number between 1 and 9."
    
        return $false
    }

    return $true

}

<#
.SYNOPSIS

.DESCRIPTION

.OUTPUTS

.EXAMPLE

Returns
#>

function Validate-UserChoice {

    param(
        [string]$UserChoice
    )

    if (-not (Test-InputExists $UserChoice)) {
        return $false
    }

    if (-not (Test-Whitespace $UserChoice)) {
        return $false
    }

    $ConvertedChoice = Convert-ToInteger $UserChoice

    if ($ConvertedChoice -is [bool] -and $ConvertedChoice -eq $false) {
        return $false
    }

    if (-not (Test-MenuRange $ConvertedChoice)) {
        return $false
    }


    return $true
}

<#
.SYNOPSIS
Retrives operating system information.

.DESCRIPTION
User Get-ComputerInfo to retrieve the
operating system information from the
local computer

.OUTPUTS
String

.EXAMPLE
Get-Operating System

Returns the operating system name.
#>

function Get-OperatingSystem {

    try {
        # Retrive computer information
        $computerInfo = Get-ComputerInfo -ErrorAction Stop
        return $computerInfo.WindowsProductName
    }
    catch{
        #Display user friendly error message
        return "Unable to retrieve operating system information"
    
    }
}

<#
.SYNOPSIS
Retrieves WinRM service status.

.DESCRIPTION
Uses Get-Service to retrieve the
Windows Remote Management service status.

.OUTPUTS
String

.EXAMPLE
Get-WinRMStatus

Returns the WinRM service status.
#>

function Get-WinRMStatus {

    try{
        $serviceInfo = Get-Service -Name WinRM -ErrorAction Stop
        return $serviceInfo.Status
    }
    catch{
        return "Unable to retrieve WinRM service status."
    }
}

<#
.SYNOPSIS
Retrieves manufacturer and model information.

.DESCRIPTION
Uses Get-ComputerInfo to retrieve the
manufacturer and model of the local computer.

.OUTPUTS
String

.EXAMPLE
Get-ManufacturerModel

Returns manufacturer and model information
#>

function Get-ManufacturerModel {

    try{
        $computerInfo = Get-ComputerInfo -ErrorAction Stop
        return "Manufacturer: $($computerInfo.CsManufacturer)`
       Model: $($computerInfo.CsModel)"
    }
    catch{
        return "Unable to retrieve manufacturer and model information." 
    }
}

<#

.SYNOPSIS
Retrives the computer name from the local computer

.DESCRIPTION
Uses Get-ComputerInfo to retrieve the computer name of the local system.

.OUTPUTS
String

.EXAMPLE
Get-ComputerName

Returns the computer name of the local computer

#>

function Get-ComputerName {


    try {
        # Retrive computer information
        $computerInfo = Get-ComputerInfo -ErrorAction Stop
        return $computerInfo.CsName
    }
    catch{
        #Display user friendly error message
        return "Unable to retrieve computer name."
    }
}


<#
function Get-ComputerName {

    try {
    
        # Retrive computer information
        $computerInfo = Get-ComputerInfo -ErrorAction Stop

        #Display computer name
        Write-Host "Computer Name:"
        Write-Host $computerInfo.CsName
    }
    catch {
    
        #Display user friendly error message
        Write-Host "Unable to retrieve computer name."
    }
}
#>

<#
.SYNOPSIS
Retrieves domain name information

.DESCRIPTION
Users Get-ComputerInfo to retrieve the
domain name from the local computer.

.OUTPUTS
String

.EXAMPLE
Get-DomainName

Returns the domain name.
#>

function Get-DomainName {

    try{
        $computerInfo = Get-ComputerInfo -ErrorAction Stop
        return $computerInfo.CsDomain
    }
    catch{
        return "Unable to retrieve domain name"
    }
}

<#
.SYNOPSIS
Retrieves Trusted Hosts information

.DESCRIPTION
Uses the WSMan provider to retrieve the
Trusted Hosts configuration from the 
local computer.

.OUTPUTS
String

.EXAMPLE
Get-TrustedHosts

Returns the Trusted Hosts configuration
#>

function Get-TrustedHosts {

    try{
        $trustedHosts = Get-Item `
        WSMan:\localhost\Client\TrustedHosts `
        -ErrorAction Stop

        # Check whether any Trusted Hosts
        # have been configured

        if ([string]::IsNullOrWhiteSpace($trustedHosts.Value)){
            return "No Trusted Hosts configured"
        }

        return $trustedHosts.Value
    }
    catch{
        return "Unable to retrieve Trusted Hosts information."
    }
}

<#
.SYNOPSIS
Retrieves operating system architecture information.

.DESCRIPTION
Uses Get-ComputerInfo to retrieve the
operating system architecture from the 
local computer.

.OUTPUTS
String

.EXAMPLE
Get-OSArchitecture

Returns the operating system architecture
#>

function Get-OSArchitecture {

    try{
        $computerInfo = Get-ComputerInfo -ErrorAction Stop
        return $computerInfo.OsArchitecture
    }
    catch{
        return "Unable to retrieve operating system architecture."
    }
}

<#
.SYNOPSIS
Retrieves all operating system information.

.DESCRIPTION
Calls all information retrieval functions
and returns their results.

.OUTPUTS
String

.EXAMPLE
Get-AllInformation

Returns all avalable operating system information
#>

function Get-AllInformation {

    try{
        $allInformation = ""

        $allInformation += "Operating System: "
        $allInformation += Get-OperatingSystem
        $allInformation += "`n`n"
        
        $allInformation += "Windows Remote Service Status: "
        $allInformation += Get-WinRMStatus
        $allInformation += "`n`n"

        $allInformation += Get-ManufacturerModel
        $allInformation += "`n`n"

        $allInformation += "Computer Name: "
        $allInformation += Get-ComputerName
        $allInformation += "`n`n"

        $allInformation += "Domain Name: "
        $allInformation += Get-DomainName
        $allInformation += "`n`n"

        $allInformation += "Trusted Hosts: "
        $allInformation += Get-TrustedHosts
        $allInformation += "`n`n"

        $allInformation += "OS Architecture: "
        $allInformation += Get-OSArchitecture

        return $allInformation
    }
    catch{
        return "Unable to retrieve all information."
    }
}

<#
.SYNOPSIS

.DESCRIPTION

.OUTPUTS

.EXAMPLE

Returns
#>

Export-ModuleMember -Function @(
    'Validate-UserChoice',
    'Get-OperatingSystem',
    'Get-WinRMStatus',
    'Get-ManufacturerModel',
    'Get-ComputerName',
    'Get-DomainName',
    'Get-TrustedHosts',
    'Get-OSArchitecture',
    'Get-AllInformation'
)