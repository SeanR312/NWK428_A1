# itworksScriptAnalyzer.tests.ps1

Import-Module PSScriptAnalyzer
Invoke-ScriptAnalyzer .\os_info_module.psm1
Invoke-ScriptAnalyzer .\os_information_seanreschke.ps1
Invoke-ScriptAnalyzer .\itworksScriptPester.ps1
