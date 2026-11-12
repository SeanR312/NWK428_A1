#=====================================
# ICTNWK428 Assessment 1
# Gather Operating System Information
#
# Author: Sean Reschke
#
# Controller Script
#
# This script displays a menu-drive
# interface allowing users to retrive 
# operating system and computer
# information
#=====================================

Import-Module .\os_info_module.psm1 -Force

do {

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

    # Prompt user for menu selection
    $UserChoice = Read-Host "Enter Selection"

    #Validate user input
    if (Validate-UserChoice $UserChoice) {
    
        switch ([int]$UserChoice) {
        
        1 {
            Write-Host ""
            Write-Host "Operating System"
            Write-Host "----------------"
                
            $result = Get-OperatingSystem

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
        
        
            $result = Get-ManufactureModel

            Write-Host $result
        }

        4 {
            Write-Host ""
            Write-Host "Computer Name"
            Write-Host "-------------"

            $result = Get-ComputerName

            Write-Host $result
        }

        5 {
            Write-Host ""
            Write-Host "Domain Name"
            Write-Host "-----------"
        
            $result = Get-DomainName

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
        
            $result = Get-OSArchitecture

            Write-Host $result
        }

        8 {
            Write-Host ""
            Write-Host "Get All Information"
            Write-Host "-------------------"
        
            $result = Get-AllInformation

            Write-Host $result
        }

        9 {Write-Host "Exiting Program"}
        
        }
    
    }

} while ($UserChoice -ne "9")