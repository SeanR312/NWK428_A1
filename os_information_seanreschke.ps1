<#
.SYNOPSIS
Operating System Information Tool.

.DESCRIPTION
Menu Driven controller script used to retrieve
operating system and computer information.

.NOTES
Author: Sean Reschke
Unit: ICTNWK428
Assessment: Assessment 1 - Gather Operating System Information

This script imports functions from
os_info_module.psm1 and provides a menu-driven
interface for users.
#>

# Import required module
Import-Module .\os_info_module.psm1 -Force

<#
.SYNOPSIS
Display menu options.

.DESCRIPTION
Displays all available menu options for the
Operating System Information Tool.

.OUTPUTS
None

.EXAMPLE
Show-Menu

Displays the menu
#>

function Show-Menu {

    Write-Host ""
    Write-Host "================================="
    Write-Host "Operating System Information Tool"
    Write-Host "================================="
    Write-Host "1. Operating System"
    Write-Host "2. Windows Remote Service Status"
    Write-Host "3. Manufacturer and Model"
    Write-Host "4. Computer Name"
    Write-Host "5. Domain Name"
    Write-Host "6. Trusted Hosts"
    Write-Host "7. OS Architecture"
    Write-Host "8. Get All Information"
    Write-Host "9. Quit"
    Write-Host ""
}

<#
.SYNOPSIS
Runs the main application loop.

.DESCRIPTION
Displays the menu, validates user selections,
calls the information retrieval functions and
continues running until the user selects Quit.

.OUTPUTS
None

.EXAMPLE
Start-MainFunction

Starts the application.
#>

function Start-MainFunction {

    $loopCounter = 0
    
    do {

        $loopCounter++
        if ($loopCounter -gt 20) {
            throw "Safety stop triggered"
        }


        #Display the menu
        Show-Menu

        # Prompt user for menu selection
        $UserChoice = Read-Host "Enter Selection"

        #Validate user input
        if (Validate-UserChoice $UserChoice) {
    
            $result = $null
        
            switch ([int]$UserChoice) {
        
            1 {
                Write-Host ""
                Write-Host "Operating System"
                Write-Host "----------------"
                
                $result = Get-ComputerInformation -PropertyName "WindowsProductName"

                Write-Host $result
            }

            2 {
                Write-Host ""
                Write-Host "Windows Remote Service Status"
                Write-Host "-----------------------------"
        
                $result = Get-WinRMStatus

                Write-Host $result
            }

            3 {
                Write-Host ""
                Write-Host "Manufacturer and Model"
                Write-Host "----------------------"
        
        
                $result = Get-ManufacturerModel

                Write-Host $result
            }

            4 {
                Write-Host ""
                Write-Host "Computer Name"
                Write-Host "-------------"

                $result = Get-ComputerInformation -PropertyName "CsName"

                Write-Host $result
            }

            5 {
                Write-Host ""
                Write-Host "Domain Name"
                Write-Host "-----------"
        
                $result = Get-ComputerInformation -PropertyName "CsDomain"

                Write-Host $result
            }

            6 {
                Write-Host ""
                Write-Host "Trusted Hosts"
                Write-Host "-------------"
        
                $result = Get-TrustedHosts

                Write-Host $result
            }

            7 {
                Write-Host ""
                Write-Host "OS Architecture"
                Write-Host "---------------"
        
                $result = Get-ComputerInformation -PropertyName "OsArchitecture"

                Write-Host $result
            }

            8 {
                Write-Host ""
                Write-Host "Get All Information"
                Write-Host "-------------------"
        
                $result = Get-AllComputerInformation

                Write-Host $result
            }

            9 {Write-Host "Exiting Program"}
        
            }
    
        }

    } while ($UserChoice -ne "9")

}

# Start application
# When running Pester tests, comment out the line below
# and uncomment the debug/testing block.

#Start-MainFunction

# Pester / debugging execution
if ($MyInvocation.InvocationName -ne '.') {
    Start-MainFunction
}