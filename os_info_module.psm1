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

function Check-InputExists {

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

function Check-Whitespace {

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
#
#
#
# Input:
#
#
# Output:
#
#

function Convert-ToInteger {

    param(
        [string]$UserChoice
    )

    try {
    
        return [int]$UserChoice

    }
    catch {
    
        Write-Host "Invalid input. Menu selections must be whole numbers."
    
        return $false

    }


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

function Validate-MenuRange {

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

    if (-not (Check-InputExists $UserChoice)) {
        return $false
    }

    if (-not (Check-Whitespace $UserChoice)) {
        return $false
    }

    $ConvertedChoice = Convert-ToInteger $UserChoice

    if ($ConvertedChoice -eq $false) {
        return $false
    }

    if (-not (Validate-MenuRange $ConvertedChoice)) {
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
#
#
#
# Input:
#
#
# Output:
#
#

function Get-ComputerName {

    try {
    
        # Retrive computer information
        $conputerInfo = Get-ComputerInfo

        #Display computer name
        $computerInfo.CsName
    }
    catch {
    
        #Display user friendly error message
        Write-Host "Unable to retrieve computer name."
    }
}

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