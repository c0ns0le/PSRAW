# RedditApplication
## about_RedditApplication

# SHORT DESCRIPTION
Describes the RedditApplication Class

# LONG DESCRIPTION
The `RedditApplication` class is used to define the parameters of an application which access the Reddit API. The `RedditApplication` class becomes embedded in the `RedditOAuthToken` class after an OAuth Access token is requested. A single application may be used by multiple users or by a single user multiple times. Each user requires their own Access Token and a single user can have multiple Access Token. The `RedditApplication` class makes it possible to define an application’s parameters once and then reuse it multiple times in multiple Access Tokens for multiple users. 

A `RedditApplication` class houses the Client ID and Client Secret as defined at https://ssl.reddit.com/prefs/apps . The `Name` and `Description` of the `RedditApplication` do not need to match what is registered with Reddit. They are provided along with the `GUID` property as a convenience to identify your applications.

A `RedditApplication` is required to request an OAuth Access Token with `Request-RedditOAuthToken`.

You can create `RedditApplication` objects using the `New-RedditApplication` function

The `RedditApplication` class is imported automatically when you import the PSRAW module.


# Constructors
## RedditApplication()
The default constructor will always throw an `System.NotImplementedException` exception. It is included because PowerShell v5 classes behave oddly when a default constructor is missing when other constructors are defined. This constructor cannot be used to create an instance of the class.

```powershell
[RedditApplication]::new()
```

## RedditApplication(Object Object)
This constructor converts the provided `Object` to a `HashTable` and passes it to the `_init` method. This constructor provides `Object` to `RedditApplication` conversion.

```powershell
[RedditApplication]::new([Object]$Object)
```

## RedditApplication(System.Management.Automation.PSObject PSObject)
This constructor converts the provided `PSObject` to a `HashTable` and passes it to the `_init` method. This constructor provides `PSObject` to `RedditApplication` conversion.

```powershell
[RedditApplication]::new([System.Management.Automation.PSObject]$PSObject)
```

## RedditApplication(System.Collections.Hashtable InitHash)
This constructor passes the provided `HashTable` to the `_init` method. This constructor provides `HashTable` to `RedditApplication` conversion.

```powershell
[RedditApplication]::new([System.Collections.Hashtable]$InitHash)
```

## RedditApplication(String Name, String Description, Uri RedirectUri, String UserAgent, RedditApplicationType Type, Guid GUID, String ExportPath, RedditOAuthScope[] Scope, System.Management.Automation.PSCredential ClientCredential, System.Management.Automation.PSCredential UserCredential)
This constructor converts the arguments to a `HashTable` and passes them to the `_init` method. 

```powershell
[RedditApplication]::new(
    [String]$Name, 
    [String]$Description, 
    [Uri]$RedirectUri, 
    [String]$UserAgent, 
    [RedditApplicationType]$Type, 
    [Guid]$GUID, 
    [String]$ExportPath, 
    [RedditOAuthScope[]]$Scope, 
    [System.Management.Automation.PSCredential]$ClientCredential, 
    [System.Management.Automation.PSCredential]$UserCredential
)
```


# Properties
## AuthBaseURL
The `AuthBaseURL` static property is default base URL used to request authorization codes from reddit.

```yaml
Name: AuthBaseURL
Type: String
Hidden: False
Static: True
```

## ClientCredential
The `ClientCredential` property contains a `PSCredential` object where the Username is the Application's Client ID and the password is the Client Secret as configured in reddit. For `Installed` applications, the password should be empty.

```yaml
Name: ClientCredential
Type: System.Management.Automation.PSCredential
Hidden: True
Static: False
```

## ClientID
The `ClientID` property is the Client ID as provided by reddit when the application is registered. This should match the username of the `ClientCredential`. Changing this is not recommended.

```yaml
Name: ClientID
Type: String
Hidden: False
Static: False
```

## Description
A description for the application used for convenience of identifying and documenting the `RedditApplication` object only.

```yaml
Name: Description
Type: String
Hidden: False
Static: False
```

## ExportPath
This is the path the `RedditApplication` was last imported from or where you wish to export it to. It is provided for interaction with `Import-RedditApplication` and `Export-RedditApplication`. This should be the literal path of the file.

```yaml
Name: ExportPath
Type: String
Hidden: False
Static: False
```

## GUID
A `Guid` used to help identify the application. This is provided for convenience and is not sent to or required by the API. In situations where multiple Applications may be in use, this GUID can be used to identify if the same applications is in use on separate `RedditOAuthToken` objects.

```yaml
Name: GUID
Type: Guid
Hidden: False
Static: False
```

## Name
The name of the application used for convenience of identifying the `RedditApplication` object only.

```yaml
Name: Name
Type: String
Hidden: False
Static: False
```

## RedirectUri
The Redirect URI for the application. This must match the Redirect URI registered for the application on Reddit. This is required byt Reddit's OAuth to request both Authorization codes and Access Tokens.

```yaml
Name: RedirectUri
Type: Uri
Hidden: False
Static: False
```

## Scope
The Scope property is an array of `RedditOAuthScope` objects which list the scopes for which the Application will request access to. To get all valid scopes use `Get-RedditOAuthScope`. For more information see the help topic for `Get-RedditOAuthScope`.

```yaml
Name: Scope
Type: RedditOAuthScope[]
Hidden: False
Static: False
```

## ScriptUser
The `ScriptUser` property is the Reddit username used for Script Applications. This should match the username in the `UserCredential` property

```yaml
Name: ScriptUser
Type: String
Hidden: False
Static: False
```

## Type
The `Type` property is one of the available `RedditApplicationType` enumerator options. This should match the application type registered on Reddit. for more information see `about_RedditApplicationType`

```yaml
Name: Type
Type: RedditApplicationType
Hidden: False
Static: False
```

## UserAgent
The `UserAgent` property contains the text that will be sent as the `User-Agent` header to the Reddit API. Reddit requires applications accessing their API provide a meaningful user agent. The following convention is what they recommend.

```
<platform>:<app ID>:<version string> (by /u/<reddit username>)
```

Example:

```
windows:MyPSRAW-App:v1.2.3 (by /u/markekraus)
```

For more details see https://github.com/reddit/reddit/wiki/API#rules

```yaml
Name: UserAgent
Type: String
Hidden: False
Static: False
```

## UserCredential
The `UserCredential` property contains a `PSCredential` object where the username and passwords are the Reddit Username and password used for `Script` Applications. For `WebApp` and `Installed` apps, this is not required and will be ignored.

```yaml
Name: UserCredential
Type: System.Management.Automation.PSCredential
Hidden: True
Static: False
```


# Methods

## _init(System.Collections.Hashtable InitHash)
The `_init` hidden method is used by the constructors to initialize the class. This way class initialization code can be maintained in a single method instead of each individual constructor. It performs several checks to ensure that required properties are provided and will throw `System.ArgumentException` exceptions if the requirements are not met.

```yaml
Name: _init
Return Type: Void
Hidden: True
Static: False
Definition: hidden Void _init(System.Collections.Hashtable InitHash)
```

## GetClientSecret()
The `GetClientSecret` method is used to retrieve the plaintext Client Secret which is stored as the password of the `ClientCredential`. This is used in various functions to retrieve the Client Secret in order to authenticate the application with OAuth.

```yaml
Name: GetClientSecret
Return Type: String
Hidden: False
Static: False
Definition: String GetClientSecret()
```

## GetUserPassword()
The `GetUserPassword` method is used to retrieve the plaintext user password which is stored as the password of the `UserCredential`. This is used in various functions to retrieve the user password in order to authenticate script applications with OAuth.

```yaml
Name: GetUserPassword
Return Type: String
Hidden: False
Static: False
Definition: String GetUserPassword()
```


# EXAMPLES

## Create WebApp RedditApplication
```powershell
Import-Module PSRAW
$ClientCredential = Get-Credential
$App = [RedditApplication]@{
     Name = 'TestApplication'
     Description = 'This is only a test'
     RedirectUri = 'https://localhost/'
     UserAgent = 'windows:PSRAW-Unit-Tests:v1.0.0.0'
     Scope = 'read'
     ClientCredential = $ClientCredential
     Type = 'WebApp'
 }
```

## Create Script RedditApplication
```powershell
Import-Module PSRAW
$UserCredential = Get-Credential
$ClientCredential = Get-Credential
$App = [RedditApplication]@{
    Name = 'TestApplication'
    Description = 'This is only a test'
    RedirectUri = 'https://localhost/'
    UserAgent = 'windows:PSRAW-Unit-Tests:v1.0.0.0'
    Scope = 'read'
    ClientCredential = $ClientCredential
    UserCredential = $UserCredential
    Type = 'Script'
}
```

## Create Installed RedditApplication
```powershell
Import-Module PSRAW
$ClientCredential = Get-Credential
$App = [RedditApplication]@{
     Name = 'TestApplication'
     Description = 'This is only a test'
     RedirectUri = 'https://localhost/'
     UserAgent = 'windows:PSRAW-Unit-Tests:v1.0.0.0'
     Scope = 'read'
     ClientCredential = $ClientCredential
     Type = 'Installed'
 }
```

# SEE ALSO

[about_RedditApplicationType](https://psraw.readthedocs.io/en/latest/Module/about_RedditApplicationType)

[about_RedditOAuthDuration](https://psraw.readthedocs.io/en/latest/Module/about_RedditOAuthDuration)

[about_RedditOAuthResponseType](https://psraw.readthedocs.io/en/latest/Module/about_RedditOAuthResponseType)

[about_RedditOAuthScope](https://psraw.readthedocs.io/en/latest/Module/about_RedditOAuthScope)

[about_RedditOAuthToken](https://psraw.readthedocs.io/en/latest/Module/about_RedditOAuthToken)

[New-RedditApplication](https://psraw.readthedocs.io/en/latest/Module/New-RedditApplication)

[Request-RedditOAuthToken](https://psraw.readthedocs.io/en/latest/Module/New-RedditApplication)

[https://github.com/reddit/reddit/wiki/API](https://github.com/reddit/reddit/wiki/API)

[https://github.com/reddit/reddit/wiki/OAuth2](https://github.com/reddit/reddit/wiki/OAuth2)

[https://www.reddit.com/prefs/apps](https://www.reddit.com/prefs/apps)

[https://www.reddit.com/wiki/api](https://www.reddit.com/wiki/api)

[https://psraw.readthedocs.io/](https://psraw.readthedocs.io/)