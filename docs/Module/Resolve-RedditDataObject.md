---
external help file: PSRAW-help.xml
Module Name: PSRAW
online version: https://psraw.readthedocs.io/en/latest/Module/Resolve-RedditdataObject
schema: 2.0.0
---

# Resolve-RedditDataObject

## SYNOPSIS
Resolves a `RedditDataObject` from another object

## SYNTAX

### RedditAPIResponse
```
Resolve-RedditDataObject [-RedditApiResponse] <RedditApiResponse> [-WhatIf] [-Confirm]
```

### RedditThing
```
Resolve-RedditDataObject [-RedditThing] <RedditThing> [-WhatIf] [-Confirm]
```

### PSObject
```
Resolve-RedditDataObject [-PSObject] <PSObject> [-WhatIf] [-Confirm]
```

## DESCRIPTION
This function is used by return the appropriate `RedditDataObject` (i.e. `RedditComment`) from various objects. This is used to raise a `RedditDataObject` up from the `RedditThing` meta-class that Reddit uses to encapsulate all objects such as comments, links, subreddits, lists, and mores. It is made public due to implementation limitations, but is not intended for public consumption. Do not call this function directly.

## EXAMPLES

### Example 1
```
$Response = Invoke-RedditRequest -uri $uri
$RedditComment = Resolve-RedditDataObject -RedditAPIResponse $Response
```

Assuming `$uri` is a comment endpoint, this will convert the response from `Invoke-RedditRequest` into a `RedditComment` object.

### Example 2
```
$Response = Invoke-RedditRequest -uri $uri
$RedditComment = Resolve-RedditDataObject -PSObject $Response.ContentObject
```

Assuming `$uri` is a comment endpoint, this will convert the `ContentObject` from `Invoke-RedditRequest` into a `RedditComment` object.

### Example 2
```
$Response = Invoke-RedditRequest -uri $uri
$RedditThing = [RedditThing]$Response.ContentObject
$RedditComment = Resolve-RedditDataObject -RedditThing $RedditThing
```

Converting a `RedditThing` into a `RedditComment`.

## PARAMETERS

### -PSObject
A PSObject of a `Thing` returned from the Reddit API and converted from JSON.

```yaml
Type: PSObject
Parameter Sets: PSObject
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -RedditApiResponse
A `RedditApiResponse` object returned from `Invoke-RedditRequest`

```yaml
Type: RedditApiResponse
Parameter Sets: RedditAPIResponse
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -RedditThing
An existing `RedditThing` object.

```yaml
Type: RedditThing
Parameter Sets: RedditThing
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### RedditApiResponse
### RedditThing
### System.Management.Automation.PSObject


## OUTPUTS

### RedditDataObject


## NOTES

## RELATED LINKS

[https://psraw.readthedocs.io/en/latest/Module/Resolve-RedditdataObject](https://psraw.readthedocs.io/en/latest/Module/Resolve-RedditdataObject)

[about_RedditDataObject](https://psraw.readthedocs.io/en/latest/Module/about_RedditdataObject)

[about_RedditAPIResponse](https://psraw.readthedocs.io/en/latest/Module/about_RedditAPIResponse)

[https://www.reddit.com/wiki/api](https://www.reddit.com/wiki/api)

[https://psraw.readthedocs.io/](https://psraw.readthedocs.io/)
