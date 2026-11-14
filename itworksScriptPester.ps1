
# To Do: Change this
. "$PSScriptRoot\os_information_seanreschke.ps1"

Describe "Get-ComputerInformation" {
    InModuleScope os_info_module {
        BeforeAll {
            Mock Get-ComputerInfo {
                return @{ 
                WindowsProductName = 'Windows 11' }
            }
        }

        It "Returns computer property when valid parameter provided" {
            $result = Get-ComputerInformation `
                 -propertyName 'WindowsProductName'
            $result | Should -Not -BeNullOrEmpty
        }

        It "Returns the requested property value" { 
            $result = Get-ComputerInformation `
                -propertyName 'WindowsProductName'
            $result | Should -Be "Windows 11"
        }

        It "Returns error when exception occurs" {
            Mock Get-SystemInformation { throw 'Failure' } 
            $result = Get-ComputerInformation `
                -propertyName 'WindowsProductName'
            $result | Should -Match 'Error:'
        }
    }
}

Describe "Get-AllComputerInformation" {
    InModuleScope os_info_module {
        BeforeAll {
            Mock Get-ComputerInfo {
                return [PSCustomObject]@{
                    WindowsProductName = 'Windows 11'
                    OsArchitecture = '64-bit'
                    CsName = 'SERVER1'
                    CsDomain = 'W2K22AD.local'
                    CsManufacturer = 'VMware, Inc.'
                    CsModel = 'WMware7,1'
                }
            }
            Mock Get-SystemInformation {
                return [PSCustomObject]@{
                    WindowsProductName = 'Windows 11'
                    OsArchitecture = '64-bit'
                    CsName = 'SERVER1'
                    CsDomain = 'W2K22AD.local'
                    CsManufacturer = 'VMware, Inc.'
                    CsModel = 'WMware7,1'
                }
            }
        }

        It "Returns formatted computer information" {
            $result = Get-AllComputerInformation
            $result | Should -Match "Windows 11"
        }

        It "Calls Get-ComputerInfo through Get-SystemInformation" {
            Get-AllComputerInformation
            Should -Invoke Get-SystemInformation
        }

        It "Returns error string on failure" {
            Mock Get-SystemInformation { throw 'Failure' } 
            $result = Get-AllComputerInformation
            $result | Should -Match 'Unable to retrieve all information'
        }

    }
}

Describe "Show-Menu" {
    It "Displays menu options" {
        Mock Write-Host {}
		# To Do: Change <ShowMenu> to the name of your function  
        Show-Menu
        Should -Invoke Write-Host
    }
}


Describe "Start-MainFunction" {
    BeforeEach {
        $script:calls = 0
        Mock Show-Menu {}
        #Mock Write-Host {} 
        Mock Get-ComputerInformation { return 'MockedValue' } 
        Mock Get-AllComputerInformation { return 'AllInfo' }
    }
        Context "Valid selections" {
            It "Handles option 1" {
                    Mock Read-Host {
                        $script:calls++
                        if ($script:calls -eq 1) {
                            return '1'
                        }
                        else{
                            return '9'
                        }
                } 
                Start-MainFunction
                Should -Invoke Get-ComputerInformation -Times 1
        
            }

            It "Handles option 8" {
                    Mock Read-Host {
                        $script:calls++
                        if ($script:calls -eq 1) {
                            return '8'
                        }
                        else{
                            return '9'
                        }
                    }
                Start-MainFunction
                Should -Invoke Get-AllComputerInformation -Times 1
            }
        }
        Context "Invalid selection greater than 8" {
            It "Prompts again on invalid high input" {
                    Mock Read-Host {
                        $script:calls++
                        if ($script:calls -eq 1) {
                            return '10'
                        }
                        else{
                            return '9'
                        }
                }
                Start-MainFunction
                Should -Invoke Show-Menu -Times 2
            }
        }

        Context "Exit condition" {
            It "Exits when user selects 9" {
                Mock Read-Host { return '9' }
                { Start-MainFunction } | Should -Not -Throw
            }
        }
}