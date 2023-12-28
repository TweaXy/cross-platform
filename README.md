# cross-platform
# Features

### Authentication & Registration

- Login
- Register new user with captcha
- send/resend email verification
- verify email
- Update username
- forget/reforget Password
- reset password using UUID
- Get user basic profile data using ID
- Google sign in

### Users Profile

- Search for matching users using their username or screen name (or part of them)
- Search on tweet of specific users
- Delete/Add a profile banner (restores the default one)
- Update a profile picture given the new picture.
- Delete a profile picture (restores the default one)
- Get/Update the profile of a specific user.
    
    eg:
    
    - username
    - name
    - bio
    - birthday
    - etc..

### User Interactions

- Get a list of users that follow the username.
- Get a list of users that are followed by the username.
- Follow a certain user using their username.
- Unfollow a certain user using their username.
- add/delete get blocks
- Un/Mute a certain user using his username.*
- Get a list of muted users.

### Tweets

- Add tweets
- Delete interactions (tweet | retweet | comment)
- Add, remove likes on tweets
- Get list of likers
- Add, Delete, Get tweets
- Get replies of a certain tweet
- Add, Delete retweet
- Add, remove likes on tweets
- Get list of retweeters
- Get list of likers
- Search tweets / or part of the tweet (*Relevance suggestions*)

### Timeline & Trends

- Get a list of tweets in the home page of the user. (Timeline) (ranked by likes, comments, retweets)
- Get a list of tweets in the profile of a user
    - & search on them
- Get list of retweets in the profile of a user
- Get tweets that the user mentioned in it
- Get tweets liked by the user
- Get a list of tweets that matches (either fully or partially) the sent string. **relevance suggestions **
- Get a list of available trends
- Get a list of tweets in a given trend.
- Search hashtags

### Media

- Add, get media

### Direct Messages

- get conversations of user
- get messages of conversation
- add new message
- get number of unseen conversation (with unseen messages count)
- utilizing handshake authentication with socket connection

### Notification

- Get notifications list
- Get notifications unseen count
- push notification using firebase service ⇒ when:
    - user follow me
    - user liked on any of my interactions
    - user commented on any of my interactions
    - user retweeted  on any of my interactions
    - user get mentioned

