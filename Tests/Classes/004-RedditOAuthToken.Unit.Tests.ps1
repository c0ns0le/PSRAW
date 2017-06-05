<#	
    .NOTES
    
     Created with:  VSCode
     Created on:    5/10/2017 04:09 PM
     Edited on:     5/20/2017
     Created by:    Mark Kraus
     Organization: 	
     Filename:     RedditOAuthToken.Unit.Tests.ps1
    
    .DESCRIPTION
        Unit Tests for RedditOAuthToken Class
#>

$projectRoot = Resolve-Path "$PSScriptRoot\..\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psd1")
$moduleName = Split-Path $moduleRoot -Leaf
Remove-Module -Force $moduleName  -ErrorAction SilentlyContinue
Import-Module (Join-Path $moduleRoot "$moduleName.psd1") -force

$Class = 'RedditOAuthToken'

$ClientId = '54321'
$ClientSecret = '12345'
$SecClientSecret = $ClientSecret | ConvertTo-SecureString -AsPlainText -Force 
$ClientCredential = [pscredential]::new($ClientId, $SecClientSecret)

$InstalledId = '54321'
$SecInstalledSecret = [System.Security.SecureString]::new()
$InstalledCredential = [pscredential]::new($InstalledId, $SecInstalledSecret)

$UserId = 'reddituser'
$UserSecret = 'password'
$SecUserSecret = $UserSecret | ConvertTo-SecureString -AsPlainText -Force 
$UserCredential = [pscredential]::new($UserId, $SecUserSecret)

$TokenId = 'access_token'
$TokenSecret = '34567'
$SecTokenSecret = $TokenSecret | ConvertTo-SecureString -AsPlainText -Force 
$TokenCredential = [pscredential]::new($TokenId, $SecTokenSecret)

$RefreshId = 'refresh_token'
$RefreshSecret = '76543'
$SecRefreshSecret = $RefreshSecret | ConvertTo-SecureString -AsPlainText -Force 
$RefreshCredential = [pscredential]::new($RefreshId, $SecRefreshSecret)

$ApplicationWebApp = [RedditApplication]@{
    Name             = 'TestApplication'
    Description      = 'This is only a test'
    RedirectUri      = 'https://localhost/'
    UserAgent        = 'windows:PSRAW-Unit-Tests:v1.0.0.0'
    Scope            = 'read'
    ClientCredential = $ClientCredential
    Type             = 'WebApp'
}
$ApplicationScript = [RedditApplication]@{
    Name             = 'TestApplication'
    Description      = 'This is only a test'
    RedirectUri      = 'https://localhost/'
    UserAgent        = 'windows:PSRAW-Unit-Tests:v1.0.0.0'
    Scope            = 'read'
    ClientCredential = $ClientCredential
    UserCredential   = $UserCredential
    Type             = 'Script'
}
$ApplicationInstalled = [RedditApplication]@{
    Name             = 'TestApplication'
    Description      = 'This is only a test'
    RedirectUri      = 'https://localhost/'
    UserAgent        = 'windows:PSRAW-Unit-Tests:v1.0.0.0'
    Scope            = 'read'
    ClientCredential = $InstalledCredential
    Type             = 'Installed'
}

$ResponseObject = [pscustomobject]@{
    Content = '{"access_token": "34567", "token_type": "bearer", "device_id": "MyDeviceID", "expires_in": 3600, "scope": "*"}'
    Headers = @{
        'Content-Type' = 'application/json'
    }
}

$ResponseObjectCode = [pscustomobject]@{
    Content = '{"access_token": "34567", "token_type": "bearer", "expires_in": 3600, "refresh_token": "76543", "scope": "read"}'
    Headers = @{
        'Content-Type' = 'application/json'
    }
}

$ResponseObjectRefresh = [pscustomobject]@{
    Content = '{"access_token": "AABBCC", "token_type": "bearer", "expires_in": 3600, "scope": "*"}'
    Headers = @{
        'Content-Type' = 'application/json'
    }
}

$ResponseUri = [System.Uri]('https://localhos/#access_token=34567&token_type=bearer&state=MyState&expires_in=3600&scope=read')
$ResponseUriRefresh = [System.Uri]('https://localhos/#access_token=DDEEFF&token_type=bearer&state=MyState&expires_in=3600&scope=read')

$TestHashes = @(
    @{
        Name = 'Token'
        Hash = @{
            Application        = $ApplicationWebApp
            IssueDate          = Get-Date
            ExpireDate         = (Get-Date).AddHours(1)
            LastApiCall        = Get-Date
            ExportPath         = 'c:\temp\AccessToken.xml'
            Scope              = 'read'
            GUID               = [guid]::NewGuid()
            Notes              = 'This is a test token'
            TokenType          = 'bearer'
            GrantType          = 'Authorization_Code'
            RateLimitUsed      = 0
            RateLimitRemaining = 60
            RateLimitRest      = 60
            TokenCredential    = $TokenCredential
            RefreshCredential  = $RefreshCredential
        }
    }
)


Describe "[$Class] Tests" -Tag Unit, Build {
    foreach ($TestHash in $TestHashes) {
        It "Converts the '$($TestHash.Name)' hash" {
            {[RedditOAuthToken]$TestHash.Hash} | should not throw
        }
    }
    It "Has a working Constructor for response objects." {
        {
            [RedditOAuthToken]::new(
                'Installed',
                $ApplicationInstalled,
                $ResponseObject
            )
        } | should not throw
    }
    It "Has a working Constructor for URI objects." {
        {
            [RedditOAuthToken]::new(
                'Implicit',
                $ApplicationInstalled,
                $ResponseUri
            )
        } | should not throw
    }
    It "Fails if the URI is missing a Fragment" {
        {
            [RedditOAuthToken]::new(
                'Implicit',
                $ApplicationInstalled,
                [system.uri]'https://badurl/'
            )
        } | should throw "Response does not include Fragment"
    }
    It "Fails if the Object is not an application/json response" {
        {
            [RedditOAuthToken]::new(
                'Implicit',
                $ApplicationInstalled,
                [pscustomobject]@{Headers = @{'Content-type' = 'invalid'}}
            )
        } | should throw "Response Content-Type is not 'application/json'"
    }
    $CodeToken = [RedditOAuthToken]::new(
        'Authorization_Code',
        $ApplicationScript,
        $ResponseObjectCode
    )
    It "Has a working GetRateLimitReset() method" {
        $CodeToken.GetRateLimitReset() | should -BeOfType system.datetime
        $CodeToken.GetRateLimitReset() | should -BeGreaterThan (get-date)
    }
    It "Has a working IsRateLimited() method" {
        $CodeToken.IsRateLimited() | should BeOfType System.Boolean
        $CodeToken.IsRateLimited() | should be $false
        $tempval = $CodeToken.LastApiCall.PSObject.copy()
        $CodeToken.LastApiCall = (get-date).AddHours(-3)
        $CodeToken.IsRateLimited() | should be $false
        $CodeToken.LastApiCall = $tempval
        $tempval = $CodeToken.RateLimitRemaining
        $CodeToken.RateLimitRemaining = 0
        $CodeToken.IsRateLimited() | should be $true
    }
    It "Has a working IsExpired() method" {
        $CodeToken.IsExpired() | should BeOfType System.Boolean
        $CodeToken.IsExpired() | should be $false
    }
    it "Has a working GetAccessToken() method" {
        $CodeToken.GetAccessToken() | should be 34567
    }
    it "Has a working GetRefreshToken() method" {
        $CodeToken.GetRefreshToken() | should be 76543
    }
    It "Has a working ToString() method" {
        $CodeToken.ToString() | should -Match 'GUID: '
        $CodeToken.ToString() | should -Match 'Expires: '
    }
    It "Has a working Refresh() method" {
        $OldToken = @{
            IssueDate  = $CodeToken.IssueDate.psobject.copy()
            ExpireDate = $CodeToken.ExpireDate.psobject.copy()
            GUID       = $CodeToken.GUID.psobject.copy()
        }
        {
            $CodeToken.Refresh(
                [pscustomobject]@{Headers = @{'Content-type' = 'invalid'}}
            )
        } | should throw "Response Content-Type is not 'application/json'"
        {
            $CodeToken.Refresh(
                [system.uri]'https://badurl/'
            )
        } | should throw "Response does not include Fragment"
        {$CodeToken.Refresh($ResponseObjectRefresh)} | Should Not throw
        $CodeToken.GUID | should be  $OldToken.GUID
        $CodeToken.GetAccessToken() | should be 'AABBCC'
        $CodeToken.IssueDate | Should BeGreaterThan $OldToken.IssueDate
        $CodeToken.ExpireDate | Should BeGreaterThan $OldToken.ExpireDate
        {$CodeToken.Refresh($ResponseUriRefresh)} | should Not throw
        $CodeToken.GetAccessToken() | should be 'DDEEFF'
    }
    It "Has a working Reserialize() static method" {
        $Object = [PSCustomObject]@{
            Application        = $ApplicationWebApp
            IssueDate          = Get-Date
            ExpireDate         = (Get-Date).AddHours(1)
            LastApiCall        = Get-Date
            ExportPath         = 'c:\temp\AccessToken.xml'
            Scope              = 'read'
            GUID               = [guid]::NewGuid()
            Notes              = 'This is a test token'
            TokenType          = 'bearer'
            GrantType          = 'Authorization_Code'
            RateLimitUsed      = 0
            RateLimitRemaining = 60
            RateLimitRest      = 60
            TokenCredential    = $TokenCredential
            RefreshCredential  = $RefreshCredential
        }
        $Token = [RedditOAuthToken]::Reserialize($Object)
        foreach ($Property in $Object.psobject.Properties.Name) {
            $token.$Property | should be $Object.$Property
        }
    }
    It "has a working UpdateRateLimit() method" {
        $Response = [PSCustomObject]@{
            Headers = @{
                Date                    = Get-Date '2017/05/20'
                'x-ratelimit-remaining' = 59
                'x-ratelimit-used'      = 1
                'x-ratelimit-reset'     = 30
            }
        }
        $CodeToken.UpdateRateLimit($Response)
        $CodeToken.RateLimitRemaining | should be 59
        $CodeToken.RateLimitUsed | should be 1
        $CodeToken.RateLimitRest | should be 30
        $CodeToken.LastApiCall | should be $(Get-Date '2017/05/20')
    }
}