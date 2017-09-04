# RedditOAuthToken
## about_RedditOAuthToken

# SHORT DESCRIPTION
Describes the RedditOAuthToken Class

# LONG DESCRIPTION
The `RedditOAuthToken` Class represents the OAuth Access Token used for authentication to the Reddit API. `RedditOAuthToken` objects are required by the majority of functions in this module. `Invoke-RedditRequest` uses the Access Token in `RedditOAuthToken` objects as a `bearer` Authorization header when making requests to Reddit. This way Reddit knows what level of access the application has in the API as well as under which user context the application is acting.

Access Tokens are considering temporary secrets and are valid for 60 minutes. Some Access Tokens are also issued with Refresh Tokens. Refresh Tokens are permanent secrets and are valid until the user or application revokes them. `RedditOAuthToken` objects house the Access Token and Refresh Token as a secure strings in a `PSCredential` objects.

`RedditOAuthToken` objects are returned from the `Request-RedditOAuthToken` function. They can be "renewed" using the `Update-RedditOAuthToken` function.

`RedditOAuthToken` objects can be imported and exported to XML files using `Import-RedditOAuthToken` and `Export-RedditOAuthToken`. Doing so provides a secure way to store the Access Token, Refresh Token, Client Secret, and Reddit user password so that it can later be imported by other scripts or in a later console session. This provides the means for automation of authenticated access to the Reddit API.

The same `RedditOAuthToken` should not be used in parallel PowerShell sessions. It is important that the `RedditOAuthToken` only be used within the same session state or else the token may be updated in another session and thus invalidate the `RedditOAuthToken` in the current session causing Access Denied errors. Concurrency where the same session is available should be fine, but you will still be bound by Reddit's Rate Limiting of `60` API calls per minute. It is recommended that if you need concurrency, you request multiple Tokens on behalf of multiple users. Otherwise, you should obey the rules and guidelines for accessing the Reddit API and code responsibly.

The functions in this module will automatically enforce rate limiting when the the limits for the current Access Token have been reached. this will result in the functions sleeping until the rate limit has been lifted. While it is possible to circumvent these measures, doing so may result in your application or Reddit account being banned.

# Constructors
## RedditOAuthToken()
Creates an empty `RedditOAuthToken` object.

```powershell
[RedditOAuthToken]::new()
```

## RedditOAuthToken(RedditOAuthGrantType GrantType, RedditApplication Application, RedditOAuthResponse Response)

# Properties
## Application
The `RedditApplication` representing the application for which this Access Token is valid.

```yaml
Name: Application
Type: RedditApplication
Hidden: False
Static: False
```

## AuthBaseURL
This static property is defines the Reddit URL where Access Tokens are requested.

```yaml
Name: AuthBaseURL
Type: String
Hidden: False
Static: True
```

## DeviceId
Certain grant flows require a Device ID be send to identify the device that is connecting. If a Device ID is provided it will be visible here. Most grant flows do not require a device ID and for those grant type this will be empty.

```yaml
Name: DeviceId
Type: String
Hidden: False
Static: False
```

## ExpireDate
A `DateTime` representing the time the Access Token will expire. If the Access Token is expired, the functions in this module will attempt to automatically renew the token upon the next API call.

```yaml
Name: ExpireDate
Type: DateTime
Hidden: False
Static: False
```

## ExportPath
This is the path the `RedditOAuthToken` was last imported from or where you wish to export it to. It is provided for interaction with `Import-RedditOAuthToken` and `Export-RedditOAuthToken`. This should be the literal path of the file.

```yaml
Name: ExportPath
Type: String
Hidden: False
Static: False
```

## GrantType
`RedditOAuthGrantType` representing the grant flow method used to request this Access Token. This will be used to determine the update method.

```yaml
Name: GrantType
Type: RedditOAuthGrantType
Hidden: False
Static: False
```

## GUID
A `Guid` used to help identify the Access Token. This is provided for convenience and is not sent to or required by the API. In situations where multiple Access Tokens may be in use, this GUID can be used to distinguish between them. This GUID will not change when a Token is updated, even for methods which require a fresh grant flow. The purpose is to identify a specific initial grant for the Access Token.

```yaml
Name: GUID
Type: Guid
Hidden: False
Static: False
```

## IssueDate
The date this current Access Token was issued. When an Access Token is updated this will be updated to reflect the date that the new token was issued.

```yaml
Name: IssueDate
Type: DateTime
Hidden: False
Static: False
```

## LastApiCall
This is a `DateTime` representing the last time this Access Token was used to call the API. This will be updated automatically every time a request is made to the reddit API.

```yaml
Name: LastApiCall
Type: DateTime
Hidden: False
Static: False
```

## Notes
This `String` property is provided for convenience to module users. this can be used to store session information, a description, a ticket ID, or whatever information the module user may deem valuable to associate with the Access Token.

```yaml
Name: Notes
Type: String
Hidden: False
Static: False
```

## RateLimitRemaining
This is the number of API requests remaining before this Access Token will be rate limited. Reddit allows for `60` API calls per minute. If this reaches `0`, then the Access Token is rate limited and functions will sleep until the Rate Limit period is reset.

```yaml
Name: RateLimitRemaining
Type: Int32
Hidden: False
Static: False
```

## RateLimitRest
This is the amount of time in seconds from the time in `LastApiCall` until the Rate Limit period is reset. If `RateLimitRemaining` is `0`, this Access Token is rate limited until  `LastApiCall` plus `RateLimitRest` and the functions in this module will sleep until that time.

```yaml
Name: RateLimitRest
Type: Int32
Hidden: False
Static: False
```

## RateLimitUsed
This is the number of API calls that have been made since the that Rate Limit reset period. This will be `0` when the rate limit period has reset and `60` if the Access Token has been Rate Limited.

```yaml
Name: RateLimitUsed
Type: Int32
Hidden: False
Static: False
```

## Scope
An array of `RedditOAuthScope` objects representing the OAuth scopes for which this Access Token is valid.

```yaml
Name: Scope
Type: RedditOAuthScope[]
Hidden: False
Static: False
```

## Session
Used to track the web session for `Invoke-GraphRequest` when calls are made to Reddit's API. This property will not be imported from `Import-RedditOAuthToken` and instead a new `Microsoft.PowerShell.Commands.WebRequestSession` will be created. This is primarily used to house Reddit's tracking cookies which provide a persistent CDN experience.

```yaml
Name: Session
Type: Microsoft.PowerShell.Commands.WebRequestSession
Hidden: True
Static: False
```

## TokenCredential
A `PSCredential` object to house the OAuth Access Token.

```yaml
Name: TokenCredential
Type: System.Management.Automation.PSCredential
Hidden: True
Static: False
```

## TokenType
This is the token type returned by Reddit. It should always be `bearer`.

```yaml
Name: TokenType
Type: String
Hidden: False
Static: False
```


# Methods
## GetAccessToken()
Retrieves the plain-text OAuth Access Token from the `TokenCredential` property.

```yaml
Name: GetAccessToken
Return Type: String
Hidden: False
Static: False
Definition: String GetAccessToken()
```

## GetRateLimitReset()
Retrieves the time that the Rate Limit period will be be reset. (`LastApiCall` plus `RateLimitRest`)

```yaml
Name: GetRateLimitReset
Return Type: DateTime
Hidden: False
Static: False
Definition: DateTime GetRateLimitReset()
```

## IsExpired()
Returns `$True` if the token is expired
Returns `$False` if the token is not expired.

```yaml
Name: IsExpired
Return Type: Boolean
Hidden: False
Static: False
Definition: Boolean IsExpired()
```

## IsRateLimited()
Returns `$True` if the access token is Rate Limited
Returns `$False` if the access token is not Rate Limited

```yaml
Name: IsRateLimited
Return Type: Boolean
Hidden: False
Static: False
Definition: Boolean IsRateLimited()
```

## Refresh(RedditOAuthResponse Response)

## Reserialize(Object Object)
Used to reserialize a deserialized `RedditOAuthToken` object. This is called by `Import-RedditOAuthToken` after the object has been imported from XML.

```yaml
Name: Reserialize
Return Type: RedditOAuthToken
Hidden: False
Static: True
Definition: static RedditOAuthToken Reserialize(Object Object)
```

## ToString()
Returns a string representation of the `RedditOAuthToken` object.

```yaml
Name: ToString
Return Type: String
Hidden: False
Static: False
Definition: String ToString()
```

## UpdateRateLimit(Object Response)
Updates the `RateLimitReset`, `RateLimitUsed`, `RateLimitRemaining`, and `LastApiCall` properties. This is called after every successful call to the Reddit API by `Invoke-RedditRequest`.

```yaml
Name: UpdateRateLimit
Return Type: Void
Hidden: False
Static: False
Definition: Void UpdateRateLimit(Object Response)
```

# EXAMPLES

## Create New Instance With Constructor
```powershell
$Application = Import-RedditApplication -Path 'c:\MyApp.xml'
$Params = @{
    Uri             = [RedditOAuthToken]::AuthBaseURL
    UserAgent       = $Application.UserAgent
    Method          = 'POST'
    UseBasicParsing = $true
    Body            = @{
        grant_type = 'https://oauth.reddit.com/grants/installed_client'
        device_id  = [guid]::NewGuid().ToString()
    }
    Headers         = @{
        Authorization = 'Basic {0}' -f (
            [System.Convert]::ToBase64String(
                [System.Text.Encoding]::ASCII.GetBytes(
                    ('{0}:{1}' -f $Application.ClientCredential.UserName,
                    $Application.ClientCredential.GetNetworkCredential().Password)
                )
            )
        )
    }
}
$Result = Invoke-WebRequest @Params
$Token =  [RedditOAuthToken]::New('Installed', $Application, $Result)
```

This example shows how to manually request an OAuth Access Token from Reddit using the `installed_client` grant method and use the result to create a `RedditOAuthToken` object.

## Sleep Until Rate Limit Period Reset.
```powershell
While ($Token.IsRateLimited()){
    Start-Sleep -Seconds 1
}
```

This example demonstrates how to sleep until the the Rate Limit period has been reset.

# SEE ALSO

[about_RedditApplication](https://psraw.readthedocs.io/en/latest/Module/about_RedditApplication)

[about_RedditOAuthGrantType](https://psraw.readthedocs.io/en/latest/Module/about_RedditOAuthGrantType)

[about_RedditOAuthScope](https://psraw.readthedocs.io/en/latest/Module/about_RedditOAuthScope)

[Export-RedditOAuthToken](https://psraw.readthedocs.io/en/latest/Module/Export-RedditOAuthToken)

[Import-RedditOAuthToken](https://psraw.readthedocs.io/en/latest/Module/Import-RedditOAuthToken)

[Invoke-RedditRequest](https://psraw.readthedocs.io/en/latest/Module/Import-RedditRequest)

[Request-RedditOAuthToken](https://psraw.readthedocs.io/en/latest/Module/Request-RedditOAuthToken)

[Update-RedditOAuthToken](https://psraw.readthedocs.io/en/latest/Module/Update-RedditOAuthToken)

[https://github.com/reddit/reddit/wiki/OAuth2](https://github.com/reddit/reddit/wiki/OAuth2)

[https://psraw.readthedocs.io/](https://psraw.readthedocs.io/)
