<#
	.NOTES

	 Created with: 	VSCode
	 Created on:   	4/23/2017
     Edited on:     4/23/2017
	 Created by:   	Mark Kraus
	 Organization:
	 Filename:     	build.ps1

	.DESCRIPTION
		Build Initialization
#>
param ($Task = 'Default')

Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

$ModuleInstallScope = 'CurrentUser'
if ($ENV:BHBuildSystem -eq 'AppVeyor') {
    $ModuleInstallScope = 'Global'
}


Install-Module -Scope $ModuleInstallScope Psake, PSDeploy, BuildHelpers, platyPS, PSScriptAnalyzer -force
Install-Module -Scope $ModuleInstallScope Pester -Force -SkipPublisherCheck
Import-Module Psake, BuildHelpers, platyPS, PSScriptAnalyzer
Import-Module $PSScriptRoot/../build.psm1




Set-BuildEnvironment -ErrorAction SilentlyContinue

Invoke-psake -buildFile .\BuildTools\psake.ps1 -taskList $Task -nologo
exit ([int](-not $psake.build_success))
