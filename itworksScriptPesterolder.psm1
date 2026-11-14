<#
.SYNOPSIS
Operating System Information Module

.DESCRIPTION
Contains reusable functions used by the 
operating System Information Tool for 
ICTNWK428 Assessment 1.

The module provides input validation
functions and information retrieval
functions can be called by the
controller script.

.NOTES
Author: Sean Reschke
Unit: ICTNWK428
Assessment: Assessment 1 - Gather Operating System Information

#>

<#
.SYNOPSIS
Validates that input has been supplied 

.DESCRIPTION
Checks whether the user entered a
menu selection. Rejects null or
empty input.

PARAMETER UserChoice
The menu option entered by the user

.OUTPUTS
Boolean

.EXAMPLE
Test-InputExists -UserChoiec "1"

Returns True.

.EXAMPLE
Test-InputExists -UserChoice ""

Returns False.
#>

function Test-InputExists {

    param(
        [string]$UserChoice
    )

    try {

        if ([string]::IsNullOrEmpty($UserChoice)) {

            Write-Host "Invalid input. A menu selection is required."

            return $false
        }

        return $true
    }
    catch {

        Write-Host "Unable to validate input."

        return $false

    }
}

<#
.SYNOPSIS
Validates that input does not contain only whitespace.

.DESCRIPTION
Checks whether the supplied menu selection
contains only whitespace characters and
returns True when the value is valid.

.PARAMTER UserChoice
The menu option entered by the user

.OUTPUTS
Boolean

.EXAMPLE
Test-Whitespace -UserChoice "1"

Returns True.

.EXAMPLE
Test-Whitespace -UserChoice " "

Returns False.
#>

function Test-Whitespace {

    param(
        [string]$UserChoice
    )

    try {

        if ([string]::IsNullOrWhiteSpace($UserChoice)) {
    
            Write-Host "Invalid input. A menu selection is required."
    
            return $false

        }

        return $true

    }
    catch {

        Write-Host "Unable to validate whitespace."

        return $false    
    
    }
}

<#
.SYNOPSIS
Converts user input to an interger.

.DESCRIPTION
Validates that the supplied menu selection
contains only the whole numbers and converts
the value to an Integer

.PARAMETER UserChoice
The menu option entered by the user.

.OUTPUTS
Integer or Null

.EXAMPLE
Convert-ToInteger -UserChoice "1"

Returns 1.

.EXAMPLE
Convert-ToInteger -UserChoice "abc"

Returns Null.
#>

function Convert-ToInteger {

    param(
        [string]$UserChoice
    )

    try {

        # Validate that the input contains
        # Whole numbers only

        if ($UserChoice -notmatch '^\d+$') {    
    
            Write-Host "Invalid input. Menu selections must be whole numbers."
    
            return $null

        }

        # Convert validated input to an Interger

        return [int]$UserChoice

    }
    catch{
    
        Write-Host "Unable to convert input to an integer."

        return $null

    }

}

<#
.SYNOPSIS
Validates that a menu selection is within range.

.DESCRIPTION
Checks whether the supplied menu selection
is between 1 and 9 inclusive.

.PARAMETER UserChoice
The menu option entered by the user.

.OUTPUTS
Boolean

.EXAMPLE
Test-MenuRange -UserChoice 4

Returns True.

.EXAMPLE
Test-MenuRange -UserChoice 15

Returns False.
#>

function Test-MenuRange {

    param(
        [int]$UserChoice
    )

    try {

        if ($UserChoice -lt 1 -or $UserChoice -gt 9) {
    
            Write-Host "Invalid input. Please enter a number between 1 and 9."
    
            return $false
        }

        return $true

    }
    catch {
        
        Write-Host "Unable to validate input."

        return $false

    }

}

<#
.SYNOPSIS
Validates a menu selection.

.DESCRIPTION
Validates the user menu selection using
the required business rules. Checks that
input exists, is not whitespace, can be
converted to an Integer and falls within
the valid menu range

.PARAMETER UserChoice
The menu option entered by the user.

.OUTPUTS
Boolean

.EXAMPLE
Validate-UserChoiece -UserChoice "4"

Returns True.

.EXAMPLE
Validate-UserChoiece -UserChoice "15"

Returns False.
#>

function Validate-UserChoice {

    param(
        [string]$UserChoice
    )

    try {

        if (-not (Test-InputExists $UserChoice)) {
            return $false
        }

        if (-not (Test-Whitespace $UserChoice)) {
            return $false
        }

        $ConvertedChoice = Convert-ToInteger $UserChoice

        if ($null -eq $ConvertedChoice) {
            return $false
        }

        if (-not (Test-MenuRange $ConvertedChoice)) {
            return $false
        }

        return $true

    }
    catch {
    
        Write-Host "Unable to validate menu selection"

        return $false
    }
}

<#
.SYNOPSIS
Retrieves system information.

.DESCRIPTION
Uses Get-ComputerInfo to retrieve system
information from the local computer

.OUTPUTS
Microsoft.PowerShell.Commands.ComputerInfo
#>

function Get-SystemInformation {

    try {
        return Get-ComputerInfo -ErrorAction Stop

    }
    catch {
        return $
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
        $computerInfo = Get-SystemInformation -ErrorAction Stop
        return "Manufacturer: $($computerInfo.CsManufacturer)`
       Model: $($computerInfo.CsModel)"
    }
    catch{
        return "Unable to retrieve manufacturer and model information." 
    }
}

<#
.SYNOPSIS
Retrieves a requested computer information property.

.DESCRIPTION
Uses the system information object returned by
Get-System Information and returns the requested property.

.PARAMETER PropertyName
The computer information property to retrieve.

.OUTPUTS
String

.EXAMPLE
Get-ComputerInformation `
    -PropertyName "CsName"

Returns the computer name.

,EXAMPLE
Get-ComputerInformation `
    -PropertyName "CsDomain"

Returns the computer domain name.
#>

function Get-ComputerInformation {

    param(
        [Parameter(Mandatory)]
        [ValidateSet(
            'WindowsProductName',
            'CsName',
            'CsDomain',
            'OsArchitecture'
            )]
        [string]$PropertyName
    )

    try{
        $computerInfo = Get-SystemInformation
        return $computerInfo.$PropertyName
    }
    catch{
        return "Error: Unable to retrieve requested property."
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
Retrieves all required computer information.

.DESCRIPTION
Calls information retrieval functions and
returns all required Assessment 1 information.

.OUTPUTS
String

.EXAMPLE
Get-AllComputerInformation

Returns all avalable operating system information
#>

function Get-AllComputerInformation {

    try{
        $allInformation = ""

        $allInformation += "Operating System: "
        $allInformation += Get-ComputerInformation `
            -PropertyName "WindowsProductName"
        $allInformation += "`n`n"
        
        $allInformation += "Windows Remote Service Status: "
        $allInformation += Get-WinRMStatus
        $allInformation += "`n`n"

        $allInformation += "Manufacturer: "
        $allInformation += Get-SystemInformation |
            -Select-Object -ExpandProperty CsManufacturer
        $allInformation += "`n`n"

        $allInformation += "Model: "
        $allInformation += Get-SystemInformation |
            -Select-Object -ExpandProperty CsModel
        $allInformation += "`n`n"

        $allInformation += "Computer Name: "
        $allInformation += Get-ComputerInformation `
            -PropertyName "CsName"
        $allInformation += "`n`n"

        $allInformation += "Domain Name: "
        $allInformation += Get-ComputerInformation `
            -PropertyName "CsDomain"
        $allInformation += "`n`n"

        $allInformation += "Trusted Hosts: "
        $allInformation += Get-TrustedHosts
        $allInformation += "`n`n"

        $allInformation += "OS Architecture: "
        $allInformation += Get-ComputerInformation `
            -PropertyName "OsArchitecture"

        return $allInformation
    }
    catch{
        return "Unable to retrieve all information."
    }
}

<#
.SYNOPSIS
Exports module functions.

.DESCRIPTION
Makes selected functions avalable to
scripts that import os_info_module.psm1

Functions that are not exported remain
private to the module and cannot be
called directly by external scripts

.OUTPUTS
None

.EXAMPLE
Import-Module .\os_info_module.psm1

Allows exported functions to be used by
the controller script
#>

Export-ModuleMember -Function @(
    'Validate-UserChoice',
    'Get-ComputerInformation',
    'Get-WinRMStatus',
    'Get-ManufacturerModel',,
    'Get-TrustedHosts',
    'Get-AllComputerInformation'
)