# RedditApplicationType
## about_RedditApplicationType

# SHORT DESCRIPTION
Describes the RedditApplicationType Enum

# LONG DESCRIPTION
The `RedditApplicationType` enumerator represents the available option for applications registered in Reddit. To register an application go to https://ssl.reddit.com/prefs/apps . `RedditApplicationType` is used by the Type property of the `RedditApplication` class.

For more information on Reddit OAuth App Types see https://github.com/reddit/reddit/wiki/OAuth2-App-Types


# Fields
## Installed
An app intended for installation, such as on a mobile phone.

## Script
Script for personal use. Will only be able to act on behalf of the developer who registered the application.

## WebApp
A Web base application. Can also be used in scripts to act on behalf of other users.

# EXAMPLES

## WebApp
```powershell
$WebApp = [RedditApplicationType]::WebApp
```

## Script
```powershell
$Script = [RedditApplicationType]::Script
```

## installed
```powershell
$Installed= [RedditApplicationType]::Installed
```

# SEE ALSO

[about_RedditApplicationType](https://psraw.readthedocs.io/en/latest/Module/about_RedditApplicationType)

[about_RedditApplication](https://psraw.readthedocs.io/en/latest/Module/about_RedditApplication)

[New-RedditApplication](https://psraw.readthedocs.io/en/latest/Module/New-RedditApplication)

[https://ssl.reddit.com/prefs/apps](https://ssl.reddit.com/prefs/apps)

[https://github.com/reddit/reddit/wiki/OAuth2-App-Types](https://github.com/reddit/reddit/wiki/OAuth2-App-Types)

[https://github.com/reddit/reddit/wiki/API](https://github.com/reddit/reddit/wiki/API)

[https://github.com/reddit/reddit/wiki/OAuth2](https://github.com/reddit/reddit/wiki/OAuth2)

[https://www.reddit.com/prefs/apps](https://www.reddit.com/prefs/apps)

[https://www.reddit.com/wiki/api](https://www.reddit.com/wiki/api)

[https://psraw.readthedocs.io/](https://psraw.readthedocs.io/)
