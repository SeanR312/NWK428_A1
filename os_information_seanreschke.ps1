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

Import-Module .\os_info_module.psm1

do {

    Display Menu

    Get UserChoice

    Validate UserChoice

    if UserChoice is valid {

        switch(UserChoice) {

            1 { Get-OperatingSystem }

            2 { Get-WinRMStatus }

            3 { Get-ManufacturerModel }

            4 { Get-ComputerName }

            5 { Get-DomainName }

            6 { Get-TrustedHosts }

            7 { Get-OSArchitecture }

            8 { Get-AllInformation }

            9 { Exit Program }

        }

    }

} while (UserChoice is not 9)