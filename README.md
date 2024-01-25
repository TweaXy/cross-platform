# cross-platform
## <img align= center width=30px height=30px src="https://github.com/AhmedSamy02/Adders-Mania/assets/88517271/dba75e61-02dd-465b-bc31-90907f36c93a"> Table of Contents

- [Overview](#overview)
- [Features](#feat)
- [Demo Videos](#vid)
- [Dependencies](#depend)
- [Contributors](#contributors)
- [License](#license)

## <img src="https://github.com/AhmedSamy02/Adders-Mania/assets/88517271/9ed3ee67-0407-4c82-9e29-4faa76d1ac44" width="30" height="30" /> Overview <a name = "overview"></a>
<b>Tweet, Connect, Enjoy — TweaXy Delivers the X Vibes<b/>

Discover TweaXy, the friendly X clone that keeps it simple and fun. Built with Flutter, it's your go-to for tweets on both mobile and web, making connections easy and tweets delightful.

<b>Tweet Anywhere, Anytime!<b/>

📱 Go Mobile or Web: Switch effortlessly between your phone and computer to stay in the loop.

🐦 X, but Better: Experience the joy of Twitter with some extra flair and user-friendly features.

🌈 Easy and Fun: Navigate smoothly through a clean design for a hassle-free social adventure.

## <img src="https://github.com/YaraHisham61/PersonalFinanceManager/assets/88517271/de0f35c0-2588-44a7-ba64-9143787e82c0" width="30" height="30" /> Features <a name = "feat"></a>

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

## <img src="https://github.com/YaraHisham61/AYKN-Search-Engine/assets/88517271/2783fa4c-1371-45d2-bbfa-7682bbc4b65d" width="30" height="30" /> Demo Videos <a name = "vid"></a>
### [Mobile](https://drive.google.com/file/d/1qyN3ecSbio69xsPv6Pcl7PZ_llfn3jhL/view?usp=sharing)

### [Web](https://drive.google.com/file/d/1hlKIBF9dd1S34iGNhqnxqxyr3KzL_YA2/view?usp=sharing)

## <img src="https://github.com/TweaXy/cross-platform/assets/88517271/b518548d-b17b-4353-bea0-20d6b0b5c732" width="30" height="30" /> Dependencies <a name = "depend"></a>
- Dart SDK 3.1.3

- Flutter SDK 3.13.

- tweaxy 1.0.0+1

- packages:
    - animated_snack_bar 0.4.0 [flutter]
    - blur 3.1.0 [flutter]
    - cached_network_image 3.3.0 [cached_network_image_platform_interface cached_network_image_web flutter flutter_cache_manager octo_image]
    - chatview 1.3.1 [flutter grouped_list intl flutter_linkify url_launcher emoji_picker_flutter http html any_link_preview progress_indicators image_picker audio_waveforms timeago]
    - chewie 1.7.4 [cupertino_icons flutter provider video_player wakelock_plus]
    - crypto 3.0.3 [typed_data]
    - cupertino_icons 1.0.6
    - dash_chat_2 0.0.19 [cached_network_image flutter flutter_parsed_text intl url_launcher video_player]
    - datepicker_dropdown 0.0.9 [flutter]
    - dio 5.4.0 [async http_parser meta path]
    - dotted_border 2.1.0 [flutter path_drawing]
    - dropdown_button2 2.3.9 [flutter meta]
    - dropdown_search 5.0.6 [flutter]
    - firebase_auth 4.15.3 [firebase_auth_platform_interface firebase_auth_web firebase_core firebase_core_platform_interface flutter meta]
    - firebase_core 2.24.2 [firebase_core_platform_interface firebase_core_web flutter meta]
    - firebase_messaging 14.7.9 [firebase_core firebase_core_platform_interface firebase_messaging_platform_interface firebase_messaging_web flutter meta]
    - flutter 0.0.0 [characters collection material_color_utilities meta vector_math web sky_engine]
    - flutter_bloc 8.1.3 [bloc flutter provider]
    - flutter_holo_date_picker 1.1.3 [flutter auto_size_text]
    - flutter_linkify 6.0.0 [flutter linkify]
    - flutter_speed_dial 7.0.0 [flutter]
    - flutter_spinkit 5.2.0 [flutter]
    - flutter_staggered_grid_view 0.7.0 [flutter]
    - flutter_svg 2.0.9 [flutter vector_graphics vector_graphics_codec vector_graphics_compiler]
    - flutter_typeahead 5.0.1 [flutter flutter_keyboard_visibility pointer_interceptor]
    - fluttertoast 8.2.4 [flutter flutter_web_plugins]
    - font_awesome_flutter 10.6.0 [flutter]
    - get 4.6.6 [flutter]
    - google_fonts 6.1.0 [flutter http path_provider crypto]
    - google_sign_in 6.1.6 [flutter google_sign_in_android google_sign_in_ios google_sign_in_platform_interface google_sign_in_web]     
    - hidable 1.0.6 [flutter]
    - http_parser 4.0.2 [collection source_span string_scanner typed_data]
    - icon_decoration 2.0.2 [flutter]
    - image_cropper 5.0.1 [flutter image_cropper_platform_interface image_cropper_for_web]
    - image_downloader 0.32.0 [flutter]
    - image_picker 1.0.5 [flutter image_picker_android image_picker_for_web image_picker_ios image_picker_linux image_picker_macos image_picker_platform_interface image_picker_windows]
    - infinite_scroll_pagination 4.0.0 [flutter flutter_staggered_grid_view sliver_tools]
    - intl 0.18.1 [clock meta path]
    - like_button 2.0.5 [flutter]
    - loading_indicator 3.1.1 [flutter async collection]
    - material_floating_search_bar_2 0.5.0 [flutter meta]
    - modal_progress_hud_nsn 0.4.0 [flutter flutter_web_plugins plugin_platform_interface]
    - multi_image_layout 0.0.2 [photo_view flutter]
    - multi_video_player 0.0.5 [flutter video_player preload_page_view]
    - oktoast 3.4.0 [flutter]
    - paginated_search_bar 1.1.2 [flutter endless rxdart state_property]
    - popover 0.2.8+2 [flutter]
    - popup_menu 2.0.0 [flutter]
    - provider 6.1.1 [collection flutter nested]
    - shared_preferences 2.2.2 [flutter shared_preferences_android shared_preferences_foundation shared_preferences_linux shared_preferences_platform_interface shared_preferences_web shared_preferences_windows]
    - sign_button 2.0.6 [flutter]
    - socket_io_client 2.0.3+1 [logging socket_io_common js]
    - tabbed_sliverlist 0.1.0 [flutter]
    - url_launcher 6.2.2 [flutter url_launcher_android url_launcher_ios url_launcher_linux url_launcher_macos url_launcher_platform_interface url_launcher_web url_launcher_windows]
    - video_player 2.8.1 [flutter html video_player_android video_player_avfoundation video_player_platform_interface video_player_web] 
    - web_socket_channel 2.4.0 [async crypto stream_channel]
    - webview_flutter_plus 0.3.0+2 [flutter webview_flutter mime]

## <img src="https://github.com/YaraHisham61/OS_Scheduler/assets/88517271/859c6d0a-d951-4135-b420-6ca35c403803" width="30" height="30" /> Contributors <a name = "contributors"></a>
<table>
  <tr>
   <td align="center">
    <a href="https://github.com/AhmedSamy02" target="_black">
    <img src="https://avatars.githubusercontent.com/u/96637750?v=4" width="150px;" alt="Ahmed Samy"/>
    <br />
    <sub><b>Ahmed Samy</b></sub></a>
    </td>
   <td align="center">
    <a href="https://github.com/kaokab33" target="_black">
    <img src="https://avatars.githubusercontent.com/u/93781327?v=4" width="150px;" alt="Kareem Samy"/>
    <br />
    <sub><b>Kareem Samy</b></sub></a>
    </td>
    <td align="center">
    <a href="https://github.com/Menna-Ahmed7" target="_black">
    <img src="https://avatars.githubusercontent.com/u/110634473?v=4" width="150px;" alt="Mennatallah Ahmed"/>
    <br/>
    <sub><b>Mennatallah Ahmed</b></sub></a>
    </td>
   <td align="center">
    <a href="https://github.com/nancyalgazzar" target="_black">
    <img src="https://avatars.githubusercontent.com/u/94644017?v=4" width="150px;" alt="Nancy Ayman"/>
    <br/>
    <sub><b>Nancy Ayman</b></sub></a>
    </td>
   <td align="center">
    <a href="https://github.com/YaraHisham61" target="_black">
    <img src="https://avatars.githubusercontent.com/u/88517271?v=4" width="150px;" alt="Yara Hisham"/>
    <br />
    <sub><b>Yara Hisham</b></sub></a>
    </td>
  </tr>
 </table>

 ## <img src="https://github.com/YaraHisham61/Architecture_Project/assets/88517271/c4a8b264-bf74-4f14-ba2a-b017ef999151" width="30" height="30" /> License <a name = "license"></a>
> This software is licensed under MIT License, See [License](https://github.com/TweaXy/cross-platform/blob/main/LICENSE)
