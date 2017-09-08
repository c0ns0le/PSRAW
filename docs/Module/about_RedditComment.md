# RedditComment
## about_RedditComment

# SHORT DESCRIPTION
Describes the RedditComment Class (experimental)

# LONG DESCRIPTION
The `RedditComment` class houses a comment returned from the Reddit API.

# Constructors
## RedditComment()
Default Constructor creates an empty `RedditComment` object.

```powershell
[RedditComment]::new()
```

## RedditComment(RedditThing RedditThing)
Creates a `RedditComment` from a `RedditThing` representing a comment returned by the reddit API.

```powershell
[RedditComment]::new([RedditThing]$RedditThing)
```


# Properties
## ApiEndpointUri
Static string containing a template URL to fetch information about comments.

```yaml
Name: ApiEndpointUri
Type: String
Hidden: False
Static: True
```

## approved_by
The moderator who approved the comment.

```yaml
Name: approved_by
Type: String
Hidden: False
Static: False
```

## archived
If true the comment is archived.

```yaml
Name: archived
Type: Boolean
Hidden: False
Static: False
```

## author
The user who wrote toe comment

```yaml
Name: author
Type: String
Hidden: False
Static: False
```

## author_flair_css_class
The CSS Class for the author's flair.

```yaml
Name: author_flair_css_class
Type: String
Hidden: False
Static: False
```

## author_flair_text
The text of the author's flair.

```yaml
Name: author_flair_text
Type: String
Hidden: False
Static: False
```

## banned_by
The moderator who banned the comment.

```yaml
Name: banned_by
Type: String
Hidden: False
Static: False
```

## body
The body of the comment

```yaml
Name: body
Type: String
Hidden: False
Static: False
```

## body_html
HTML format of the comment body.

```yaml
Name: body_html
Type: String
Hidden: False
Static: False
```

## can_gild
If true, this comment can be gilded.

```yaml
Name: can_gild
Type: Boolean
Hidden: False
Static: False
```

## controversiality
The controversiality score of the comment

```yaml
Name: controversiality
Type: Double
Hidden: False
Static: False
```

## created
A `RedditDate` containing the date the comment was created.

```yaml
Name: created
Type: RedditDate
Hidden: False
Static: False
```

## created_utc
A `RedditDate` containing the date the comment was created in UTC.

```yaml
Name: created_utc
Type: RedditDate
Hidden: False
Static: False
```

## depth
The depth of the comment in the thread.

```yaml
Name: depth
Type: Int64
Hidden: False
Static: False
```

## distinguished
If the comment is distinguished this will be either `admin` or `moderator`. If this is empty then the comment is not distinguished.

```yaml
Name: distinguished
Type: String
Hidden: False
Static: False
```

## downs
The number of downvotes. (includes own)

```yaml
Name: downs
Type: Int64
Hidden: False
Static: False
```

## edited
If true then the comment has been edited.

```yaml
Name: edited
Type: Boolean
Hidden: False
Static: False
```

## gilded
The number of times the comment has been gilded.

```yaml
Name: gilded
Type: Int64
Hidden: False
Static: False
```

## id
The comment ID

```yaml
Name: id
Type: String
Hidden: False
Static: False
```

## Kind
The `RedditThingKind` of the instance. this should always be `t1`

```yaml
Name: Kind
Type: RedditThingKind
Hidden: False
Static: False
```


## likes
`true` if comment is liked (upvoted) by the user, `false` if comment is disliked (downvoted), null if the user has not voted or you are not logged in.

```yaml
Name: likes
Type: String
Hidden: False
Static: False
```

## link_id
ID of the link this comment is in

```yaml
Name: link_id
Type: String
Hidden: False
Static: False
```

## mod_reports
Collection of reports made by moderators on this comment.

```yaml
Name: mod_reports
Type: RedditModReport[]
Hidden: False
Static: False
```

## MoreObject
If the comment had a `more` object in the replies this will hold the `RedditMore` and is used to determine if the comment has more replies than were returned by the API.

```yaml
Name: MoreObject
Type: RedditDataObject
Hidden: True
Static: False
```


## name
Fullname of comment, e.g. `t1_c3v7f8u`

```yaml
Name: name
Type: String
Hidden: False
Static: False
```

## num_reports
How many times this comment has been reported, null if not a mod

```yaml
Name: num_reports
Type: String
Hidden: False
Static: False
```

## parent_id
ID of the thing this comment is a reply to, either the link or a comment in it

```yaml
Name: parent_id
Type: String
Hidden: False
Static: False
```

## ParentObject
The Parent Object of the `RedditComment` this may be either the parent comment if this is a reply or the `RedditThing`, `RedditMore`, or `RedditListing` this comment was a child of.

```yaml
Name: ParentObject
Type: System.Management.Automation.PSObject
Hidden: False
Static: False
```


## Prefix
The Reddit "Thing" type prefix. Should always be `t1`

```yaml
Name: Prefix
Type: RedditThingPrefix
Hidden: False
Static: False
```

## RedditThingKind
The `Kind` of Reddit Thing. Should always be `t1`.

```yaml
Name: RedditThingKind
Type: RedditThingKind
Hidden: False
Static: True
```


## removal_reason
Reason provided by moderator for removal of the comment.

```yaml
Name: removal_reason
Type: String
Hidden: False
Static: False
```

## replies
A collection of child comments for this comment.

```yaml
Name: replies
Type: PSObject[]
Hidden: False
Static: False
```

## report_reasons
A string array containing report reasons supplied by users.

```yaml
Name: report_reasons
Type: String[]
Hidden: False
Static: False
```

## saved
True if this post is saved by the logged in user.

```yaml
Name: saved
Type: Boolean
Hidden: False
Static: False
```

## score
The net-score of the comment

```yaml
Name: score
Type: Int64
Hidden: False
Static: False
```

## score_hidden
Whether the comment's score is currently hidden.

```yaml
Name: score_hidden
Type: Boolean
Hidden: False
Static: False
```

## stickied
True if the Comment is set as the sticky in its thread.

```yaml
Name: stickied
Type: Boolean
Hidden: False
Static: False
```

## subreddit
Subreddit of comment excluding the `r/` prefix. "pics"

```yaml
Name: subreddit
Type: String
Hidden: False
Static: False
```

## subreddit_id
The id of the subreddit in which the comment is located

```yaml
Name: subreddit_id
Type: String
Hidden: False
Static: False
```

## subreddit_name_prefixed
Subreddit of comment including the `r/` prefix. "pics"

```yaml
Name: subreddit_name_prefixed
Type: String
Hidden: False
Static: False
```

## subreddit_type
The subreddit's type - one of "public", "private", "restricted", or in very special cases "gold_restricted" or "archived"

```yaml
Name: subreddit_type
Type: String
Hidden: False
Static: False
```

## ups
the number of upvotes. (includes own)

```yaml
Name: ups
Type: Int64
Hidden: False
Static: False
```

## user_reports
A collection of reports made against this post by other users.

```yaml
Name: user_reports
Type: RedditUserReport[]
Hidden: False
Static: False
```


# Methods
## _initReplies(Object Replies)
Hidden method responsible for populating the `replies` with `RedditComment` objects from `RedditThings` supplied by the API.

```yaml
Name: _initReplies
Return Type: Void
Hidden: True
Static: False
Definition: hidden Void _initReplies(Object Replies)
```


## GetApiEndpointUri()
Returns the API endpoint URL for the comment.

```yaml
Name: GetApiEndpointUri
Return Type: String
Hidden: False
Static: False
Definition: String GetApiEndpointUri()
```

## GetFullName()
Retrieves the Reddit Fullname ID for the comment.

```yaml
Name: GetFullName
Return Type: String
Hidden: False
Static: False
Definition: String GetFullName()
```

## HasMoreReplies()
Returns true the the comment has more replies than are populated. I cases where the replies are too deep or scored poorly, the API will return an empty `more` indicating that there are replies that were not returned.

```yaml
Name: HasMore
Return Type: Boolean
Hidden: False
Static: False
Definition: Boolean HasMoreReplies()
```


## ToString()
Overrides `ToString()` to return the contents of the the `Body` property.

```yaml
Name: ToString
Return Type: String
Hidden: False
Static: False
Definition: String ToString()
```


# EXAMPLES

## Example 1

```powershell
$result = Invoke-RedditRequest -Uri 'https://oauth.reddit.com/api/info?id=t1_dl8o3mb'
$Comment = [RedditComment]::New($Token,$Result.ContentObject.data.children[0])
```

# NOTES

Experimental: This is an experimental feature. Expect radical changes between versions. Do not write production code against this until it has been marked stable.


# DERIVED FROM

[RedditDataObject](https://psraw.readthedocs.io/en/latest/Module/about_RedditDataObject)

# SEE ALSO

[about_RedditComment](https://psraw.readthedocs.io/en/latest/Module/about_RedditComment)

[about_RedditDataObject](https://psraw.readthedocs.io/en/latest/Module/about_RedditDataObject)

[about_RedditDate](https://psraw.readthedocs.io/en/latest/Module/about_RedditDate)

[about_RedditLink](https://psraw.readthedocs.io/en/latest/Module/about_RedditLink)

[about_RedditListing](https://psraw.readthedocs.io/en/latest/Module/about_RedditListing)

[about_RedditModReport](https://psraw.readthedocs.io/en/latest/Module/about_RedditModReport)

[about_RedditMore](https://psraw.readthedocs.io/en/latest/Module/about_RedditMore)

[about_RedditThing](https://psraw.readthedocs.io/en/latest/Module/about_RedditThing)

[about_RedditUserReport](https://psraw.readthedocs.io/en/latest/Module/about_RedditUserReport)

[https://www.reddit.com/wiki/api](https://www.reddit.com/wiki/api)

[https://github.com/reddit/reddit/wiki/JSON](https://github.com/reddit/reddit/wiki/JSON)

[https://psraw.readthedocs.io/](https://psraw.readthedocs.io/)
