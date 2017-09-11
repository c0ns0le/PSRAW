<#	
    .NOTES
    
     Created with:  VSCode
     Created on:    4/26/2017 04:40 AM
     Edited on:     5/14/2017
     Created by:    Mark Kraus
     Organization: 	
     Filename:      New-RedditApplication.ps1
    
    .DESCRIPTION
        New-RedditApplication Function
#>
[CmdletBinding()]
param()

function New-RedditApplication {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseShouldProcessForStateChangingFunctions", 
        "", 
        Justification = "Creates in-memory object only."
    )]
    [CmdletBinding(
        DefaultParameterSetName = 'Script',
        ConfirmImpact = 'None',
        HelpUri = 'https://psraw.readthedocs.io/en/latest/Module/New-RedditApplication'
    )]
    [OutputType([RedditApplication])]
    param
    (
        [Parameter(ParameterSetName = 'Script',
            Mandatory = $true)]
        [switch]$Script,
        
        [Parameter(ParameterSetName = 'WebApp',
            Mandatory = $true)]
        [switch]$WebApp,
        
        [Parameter(ParameterSetName = 'Installed',
            Mandatory = $true)]
        [switch]$Installed,
        
        [Parameter(ParameterSetName = 'Installed',
            Mandatory = $False)]
        [Parameter(ParameterSetName = 'Script',
            Mandatory = $False)]
        [Parameter(ParameterSetName = 'WebApp',
            Mandatory = $False)]
        [ValidateNotNullOrEmpty()]
        [Alias('AppName')]
        [string]$Name,
        
        [Parameter(ParameterSetName = 'Installed',
            Mandatory = $true)]
        [Parameter(ParameterSetName = 'Script',
            Mandatory = $true)]
        [Parameter(ParameterSetName = 'WebApp',
            Mandatory = $true)]
        [Alias('ClientInfo')]
        [System.Management.Automation.PSCredential]$ClientCredential,
        
        [Parameter(ParameterSetName = 'Installed',
            Mandatory = $true)]
        [Parameter(ParameterSetName = 'WebApp',
            Mandatory = $true)]
        [Parameter(ParameterSetName = 'Script',
            Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [uri]$RedirectUri,
        
        [Parameter(ParameterSetName = 'Installed',
            Mandatory = $False)]
        [Parameter(ParameterSetName = 'WebApp',
            Mandatory = $False)]
        [Parameter(ParameterSetName = 'Script',
            Mandatory = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$UserAgent = 'PowerShell:PSRAW:2.0 (by /u/markekraus)',
        
        [Parameter(ParameterSetName = 'Installed',
            Mandatory = $False,
            DontShow = $true
        )]
        [Parameter(ParameterSetName = 'Script',
            Mandatory = $False,
            DontShow = $true
        )]
        [Parameter(ParameterSetName = 'WebApp',
            Mandatory = $False,
            DontShow = $true
        )]
        [RedditOAuthScope[]]$Scope = '*',
        
        [Parameter(ParameterSetName = 'Installed',
            Mandatory = $false)]
        [Parameter(ParameterSetName = 'Script',
            Mandatory = $false)]
        [Parameter(ParameterSetName = 'WebApp',
            Mandatory = $false)]
        [string]$Description,
        
        [Parameter(ParameterSetName = 'Script',
            Mandatory = $true)]
        [Parameter(ParameterSetName = 'WebApp',
            Mandatory = $false)]
        [Alias('Credential')]
        [System.Management.Automation.PSCredential]$UserCredential,
        
        [Parameter(ParameterSetName = 'Installed')]
        [Parameter(ParameterSetName = 'Script')]
        [Parameter(ParameterSetName = 'WebApp')]
        [System.Guid]$GUID = [guid]::NewGuid()
    )
    
    Process {
        switch ($PSCmdlet.ParameterSetName) {
            'Installed' {
                $AppType = [RedditApplicationType]::Installed
                $UserCredential = [System.Management.Automation.PSCredential]::Empty
                break
            }
            'WebApp' {
                $AppType = [RedditApplicationType]::WebApp
                $UserCredential = [System.Management.Automation.PSCredential]::Empty
                break
            }
            'Script' {
                $AppType = [RedditApplicationType]::Script
                break
            }
        }
       
        [RedditApplication]@{
            Name             = $Name
            Description      = $Description
            Type             = $AppType
            UserAgent        = $UserAgent
            ClientCredential = $ClientCredential
            UserCredential   = $UserCredential
            RedirectUri      = $RedirectUri
            Scope            = $Scope
            GUID             = $GUID
        }
    }
}
