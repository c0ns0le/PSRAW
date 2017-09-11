<#	
    .NOTES
    
     Created with: 	VSCode
     Created on:   	5/05/2017 02:27 PM
     Edited on:     5/14/2017
     Created by:   	Mark Kraus
     Organization: 	
     Filename:     	Request-RedditOAuthTokenClient.ps1
    
    .DESCRIPTION
        Request-RedditOAuthTokenClient Function
#>
[CmdletBinding()]
param()

function Request-RedditOAuthTokenClient {
    [CmdletBinding(
        HelpUri = 'https://psraw.readthedocs.io/en/latest/PrivateFunctions/Request-RedditOAuthTokenClient'
    )]
    [OutputType([RedditOAuthResponse])]
    param (
        [Parameter( 
            mandatory = $true, 
            ValueFromPipeline = $true, 
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateScript( 
            {
                If (-not ($_.Type -eq [RedditApplicationType]::Script -or $_.Type -eq [RedditApplicationType]::WebApp)) {
                    $Exception = [System.Management.Automation.ValidationMetadataException]::new(
                        "RedditApplicationType must be 'Script' or 'WebApp"
                    )
                    Throw $Exception
                }
                $true
            }
        )]
        [RedditApplication]$Application,

        [Parameter( 
            mandatory = $false, 
            ValueFromPipeline = $false, 
            ValueFromPipelineByPropertyName = $false
        )]
        [String]$AuthBaseUrl = [RedditOAuthToken]::AuthBaseURL
    )
    process {
        $Params = @{
            Uri             = $AuthBaseUrl
            Body            = @{
                grant_type = 'client_credentials'
            }
            UserAgent       = $Application.UserAgent
            Headers         = @{
                Authorization = $Application.ClientCredential | Get-AuthorizationHeader 
            }
            Method          = 'POST'
            UseBasicParsing = $true
        }
        $Response = Invoke-WebRequest @Params 
        $Null = $Params.Remove('Headers')
        [RedditOAuthResponse]@{
            Response    = $Response
            RequestDate = $Response.Headers.Date[0]
            Parameters  = $Params
            Content     = $Response.Content
            ContentType = $Response | Get-HttpResponseContentType
        }
    }
}