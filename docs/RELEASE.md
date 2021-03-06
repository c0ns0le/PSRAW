# Version 2.0.0.0 (2017-08-13)
## Module Manifest

* All `RequiredAssemblies` have been removed

## Root Module

* Added `$PSDefaultParameterValues` for `Invoke-WebRequest` to set `-SkipHeaderValidation` if available (for backwards compatibility with 5.1)
* Added `$PsrawSettings` module scope hashtable variable to house settings such as the session default OAuth token.

## Public Functions

### Connect-Reddit

* Added to Streamline and simplify the initial OAUth process.

### Export-RedditOAuthToken

* All parameters are no longer mandatory to accommodate exporting the default token to its default path

### Get-RedditDefaultOAuthToken

* Added to retrieve the Default token for the session

### Import-RedditOAuthToken

* Now returns nothing by default. Use `-PassThru` to return the imported token
* Sets the imported token as the session default Token.

### Invoke-RedditRequest

* Now has `irr` alias to mimic `iwr` and `irm` aliases.
* `Invoke-WebRequest` error handling logic reworked to support 5.1 and 6.0
* Access token is no longer mandatory and uses the session default AccessToken if one is not supplied

### New-RedditApplication

* Default Parameter Set changed to `Script`
* `Name` parameter is no longer Mandatory to simplify connecting
* `Scope` parameter  has been deprecated and is no longer Mandatory
* `UserAgent` no longer mandatory. default is now `PowerShell:PSRAW:2.0 (by /u/markekraus)`


### Request-RedditOAuthToken

* Now returns nothing by default. Use `-PassThru` to return the token
* Sets the retrieved token as the session default token.
* `Code` and `Implicit` parameter sets have been removed.
* `Code` and `Implicit` parameters have been removed
* `Code` and `Implicit` grants flows have been removed
* `State` parameter has been removed (was only required for Implicit grants)

### Set-RedditDefaultOAuthToken

* Added to set the session default token

### Update-RedditOAuthToken

* `-AccessToken` is no longer mandatory and the default is the session default token
* `Code` and `Implicit` grants flows have been removed
* `-SetDefault` switch added to set the updated token as the session default token.

## Private Functions

### Get-HttpResponseContentType

* Added `Get-HttpResponseContentType` to get API response `Content-Type` as 6.0 and 5.1 currently house this in different locations.

### Request-RedditOAuthCode

* Removed `Request-RedditOAuthCode` as it is no needed without Code grant flow

### Request-RedditOAuthTokenClient

* Now returns a `RedditOAuthResponse`

### Request-RedditOAuthTokenCode

* Removed `Request-RedditOAuthTokenCode` as it is not needed without Code grant flow

### Request-RedditOAuthTokenImplicit

* Removed `Request-RedditOAuthTokenImplicit` as it is not needed without Implicit grant flow

### Request-RedditOAuthTokenInstalled

* Now returns a `RedditOAuthResponse`

### Request-RedditOAuthTokenPassword

* Now returns a `RedditOAuthResponse`

### Request-RedditOAuthTokenRefresh

* Removed `Request-RedditOAuthTokenRefresh` as it is no longer needed without Code grant flow

### Show-RedditOAuthWindow

* Removed `Show-RedditOAuthWindow` as it is not compatible with Core (this is why Code and Implicit grant flows are no longer available)

## Classes

### RedditApplication

* `Scope` is now hidden as it serves no purpose without Code grant flows.
* Removed `GetAuthorizationUrl()` and `_GetAuthorizationUrl()` as they depended on `System.Web` (not available in Core) and are not needed without the Code or Implicit grant flows.

### ReditOAuthCode

* This class has been deleted as it is not needed without the Code grant flow.

### RedditOAuthResponse

* Created `RedditOAuthResponse` class to abstract the OAuth response from Reddit.

### RedditOAuthToken

* Removed RefreshCredential (not needed without Code grant flow)
* Constructors now take a `RedditOAuthResponse` instead of a `PSobject` and the code adjusted to use its properties
* `GetRefreshToken()` Removed (not needed without Code grant flow)
* `Refresh()` now takes a `RedditOAuthResponse`
* `UpdateRateLimit()` adjusted to support both 5.1 and 6.0 style headers dictionaries.
* Default constructor now sets the GUID to `[GUID]:Empty`

### RedditApiResponse

* `Response` and `ContentObject` are now appropriately typed
* Added `ContentType`property to hold the `Content-Type` information

### RedditDate

* Added `RedditDate` class to handle unix-to-date and date-to-unix translations for dates returned from the API.

### RedditThing

* Added `RedditThing` class to work with "Reddit Things" returned from the Reddit API

### RedditModReport

* Added `RedditModReport` to house moderator reports

### RedditUserReport

* Added `RedditUserReport` to house user reports

### RedditComment

* Added `RedditComment` to house comments.

## Enums

### RedditOAuthGrantType

* Removed `Authorization_Code`, `Refresh_Token`, and `Implicit` which are not needed without Code and Implicit grant flows

### RedditThingKind

* Added `RedditThingKind` to Define "Reddit Thing" "Kind" (their terms, not mine)

### RedditThingPrefix

* Added `RedditThingPrefix` to define valid prefixes for "Reddit Things"
