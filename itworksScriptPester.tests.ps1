
# To Do: Change this
#. "$PSScriptRoot\assessment_one.ps1"

# ICTNWK428 Assessment 1
# Pester Test File

Import-Module "$PSScriptRoot\os_info_module.psm1" -Force

# Private helper function Get-SystemInformation
# is tested indirectly through the exported
# information retrieval functions.


Describe "Get-ComputerName" {

    BeforeAll {

        Mock Get-SystemInformation {

            return @{
                CsName = 'SERVER1'
            }

        }

    }

    It "Returns computer name" {

        $result = Get-ComputerName

        $result | Should -Be 'SERVER1'

    }

}


Describe "Get-DomainName" {

    BeforeAll {

        Mock Get-SystemInformation {

            return @{
                CsDomain = 'W2K22AD.local'
            }

        }

    }

    It "Returns domain name" {

        $result = Get-DomainName

        $result | Should -Be 'W2K22AD.local'

    }

}


Describe "Get-OperatingSystem" {

    BeforeAll {

        Mock Get-SystemInformation {

            return @{
                WindowsProductName = 'Windows Server 2022'
            }

        }

    }

    It "Returns operating system information" {

        $result = Get-OperatingSystem

        $result | Should -Be 'Windows Server 2022'

    }

}


Describe "Get-OSArchitecture" {

    BeforeAll {

        Mock Get-SystemInformation {

            return @{
                OsArchitecture = '64-bit'
            }

        }

    }

    It "Returns operating system architecture" {

        $result = Get-OSArchitecture

        $result | Should -Be '64-bit'

    }

}


Describe "Get-ManufacturerModel" {

    BeforeAll {

        Mock Get-SystemInformation {

            return @{
                CsManufacturer = 'VMware, Inc.'
                CsModel        = 'VMware7,1'
            }

        }

    }

    It "Returns manufacturer and model information" {

        $result = Get-ManufacturerModel

        $result | Should -Match 'VMware'

    }

}


Describe "Get-WinRMStatus" {

    BeforeAll {

        Mock Get-Service {

            [PSCustomObject]@{
                Status = 'Running'
            }

        }

    }

    It "Returns WinRM status" {

        $result = Get-WinRMStatus

        $result | Should -Be 'Running'

    }

}


Describe "Get-TrustedHosts" {

    BeforeAll {

        Mock Get-Item {

            [PSCustomObject]@{
                Value = 'No Trusted Hosts configured.'
            }

        }

    }

    It "Returns Trusted Hosts information" {

        $result = Get-TrustedHosts

        $result | Should -Not -BeNullOrEmpty

    }

}


Describe "Get-AllInformation" {

    BeforeAll {

        Mock Get-OperatingSystem { 'Windows Server 2022' }

        Mock Get-WinRMStatus { 'Running' }

        Mock Get-ManufacturerModel {
            'Manufacturer: VMware, Inc.
Model: VMware7,1'
        }

        Mock Get-ComputerName { 'SERVER1' }

        Mock Get-DomainName { 'W2K22AD.local' }

        Mock Get-TrustedHosts { 'No Trusted Hosts configured.' }

        Mock Get-OSArchitecture { '64-bit' }

    }

    It "Returns all information" {

        $result = Get-AllInformation

        $result | Should -Not -BeNullOrEmpty

    }

}


Describe "Validate-UserChoice" {

    It "Accepts valid input" {

        Validate-UserChoice "4" | Should -Be $true

    }

    It "Rejects alphabetic input" {

        Validate-UserChoice "abc" | Should -Be $false

    }

    It "Rejects out of range input" {

        Validate-UserChoice "15" | Should -Be $false

    }

}

<#

Describe "getClientComputerInformation" {
    BeforeAll {
        Mock Get-ComputerInfo {
            return @{ OsName = 'Windows 11' }
        }
    }

    It "Returns computer property when valid parameter provided" {
		# To Do: Change <getClientComputerInformation> to the name of your function  
        $result = getClientComputerInformation -propertyName 'OsName'
        $result | Should -Not -BeNullOrEmpty
    }

    It "Calls Get-ComputerInfo with correct property" {
		# To Do: Change <getClientComputerInformation> to the name of your function  
        getClientComputerInformation -propertyName 'OsName'
        Assert-MockCalled Get-ComputerInfo -ParameterFilter { $Property -eq 'OsName' } -Times 1
    }

    It "Returns error when exception occurs" {
        Mock Get-ComputerInfo { throw 'Failure' }
		# To Do: Change <getClientComputerInformation> to the name of your function  
        $result = getClientComputerInformation -propertyName 'OsName'
        $result | Should -Match 'Error:'
    }
}

Describe "getAllClientsComputerInformation" {
    BeforeAll {
        Mock Get-ComputerInfo {
            return @{ OsName = 'Windows 11'; OsArchitecture = '64-bit' }
        }
    }

    It "Returns formatted computer information" {
		# To Do: Change <getClientComputerInformation> to the name of your function  
        $result = getAllClientsComputerInformation
        $result | Should -Not -BeNullOrEmpty
    }

    It "Calls Get-ComputerInfo once" {
		# To Do: Change <getClientComputerInformation> to the name of your function  
        getAllClientsComputerInformation
        Assert-MockCalled Get-ComputerInfo -Times 1
    }

    It "Returns error string on failure" {
        Mock Get-ComputerInfo { throw 'Failure' }
		# To Do: Change <getClientComputerInformation> to the name of your function  
        $result = getAllClientsComputerInformation
        $result | Should -Match 'Error:'
    }
}

Describe "ShowMenu" {
    It "Displays menu options" {
        Mock Write-Output {}
		# To Do: Change <ShowMenu> to the name of your function  
        ShowMenu
        Assert-MockCalled Write-Output -Times 10
    }
}

Describe "mainFunction" {
    BeforeEach {
		# To Do: Change <ShowMenu> to the name of your function 
        Mock ShowMenu {}
        Mock Write-Output {}
        Mock Write-Host {}
		# To Do: Change <getClientComputerInformation> to the name of your function  
        Mock getClientComputerInformation { return 'MockedValue' }
		# To Do: Change <getClientComputerInformation> to the name of your function  
        Mock getAllClientsComputerInformation { return 'AllInfo' }
    }

    Context "Valid selections" {
        It "Handles option 1" {
            Mock Read-Host { return '1' }
			# To Do: Change <mainFunction> to the name of your function  
            mainFunction
			# To Do: Change <getClientComputerInformation> to the name of your function  
            Assert-MockCalled getClientComputerInformation -Times 1
        }

        It "Handles option 8" {
            Mock Read-Host { return '8' }
			# To Do: Change <mainFunction> to the name of your function 
            mainFunction
			# To Do: Change <getAllClientsComputerInformation> to the name of your function 
            Assert-MockCalled getAllClientsComputerInformation -Times 1
        }
    }

    Context "Invalid selection greater than 8" {
        It "Prompts again on invalid high input" {
            $calls = 0
            Mock Read-Host {
                $calls++
                if ($calls -eq 1) { return '10' } else { return '9' }
            }
			# To Do: Change <mainFunction> to the name of your function 
            mainFunction
            Assert-MockCalled ShowMenu -Times 2
        }
    }

    Context "Exit condition" {
        It "Exits when user selects 9" {
            Mock Read-Host { return '9' }
			# To Do: Change <mainFunction> to the name of your function 
            { mainFunction } | Should -Not -Throw
        }
    }
}


#>