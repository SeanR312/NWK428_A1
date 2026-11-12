#=====================================
# Module Name: os_info_module.psm1
# Author: Sean Reschke 000846800
# Unit: ICTNWK428
# Purpose:
# Contains reusable functions for the 
# OS Information Assessment 1 tool.
#=====================================

#
# Function: Check-InputExists
# Purpose:
#
#
#
# Input:
#
#
# Output:
#
#

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

#
# Function: Check-Whitespace
# Purpose:
#
#
#
# Input:
#
#
# Output:
#
#

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

#
# Function: Convert-ToInteger
# Purpose:
# Converts user input to an Interger and 
# validates that the value is a whole number.
#
# Input:
# UserChoice
#
# Output:
# Interger Value or False
#

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

#
# Function: Validate-MenuRange
# Purpose:
#
#
#
# Input:
#
#
# Output:
#
#

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

#
# Function: Validate-UserChoice
# Purpose:
#
#
#
# Input:
#
#
# Output:
#
#

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

#
# Function: Get-OperatingSystem
# Purpose:
# Retrieves operating system information
# from local computer
#
# Input:
# None
#
# Output:
# Operating System information
#

function Get-OperatingSystem {

}

#
# Function: Get-WinRMStatus
# Purpose:
# 
#  
#
# Input:
# 
#
# Output:
# 
#

function Get-WinRMStatus {

}

#
# Function: Get-ManufacturerModel
# Purpose:
#
#
#
# Input:
#
#
# Output:
#
#

function Get-ManufacturerModel {

}

#
# Function: Get-ComputerName
# Purpose:
# Retrieves the the Computer Name
# from the local Computer
#
# Input:
# none
#
# Output:
# Computer Name
#

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

#
# Function: Get-DomainName
# Purpose:
#
#
#
# Input:
#
#
# Output:
#
#

function Get-DomainName {

}

#
# Function: Get-TrustedHosts
# Purpose:
#
#
#
# Input:
#
#
# Output:
#
#

function Get-TrustedHosts {

}

#
# Function: Get-OSArchitecture
# Purpose:
#
#
#
# Input:
#
#
# Output:
#
#

function Get-OSArchitecture {

}

#
# Function: Get-AllInformation
# Purpose:
#
#
#
# Input:
#
#
# Output:
#
#

function Get-AllInformation {

}

#
# Function:
# Purpose:
#
#
#
# Input:
#
#
# Output:
#
#

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