# Google Community Watch

CommunityWatch App is AI application which serves as a live alert app which reads all data, information, security alerts, local government danger alerts, warnings and mix with all neighborhood application including neighbors or community camera and other picture information shared. 

The Watch App's AI engine can process and analyze visual data from images, videos, and other sources to infer and identify security concerns, threats, or other critical information. It can then categorize this information as non-critical, alert-level, or critical, and automatically notify relevant community members through personalized alerts based on their specific interests and areas of concern.

## Author: Amit Shukla
## Connect 

[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/youtube.svg" width=40 height=50>](https://youtube.com/@Amit.Shukla)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/github.svg" width=40 height=50>](https://github.com/AmitXShukla)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/medium.svg" width=40 height=50>](https://medium.com/@Amit-Shukla)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/twitter_1.svg" width=40 height=50>](https://x.com/@ashuklax)


## [Video Demo](https://youtu.be/Rvt6muEW-ys)
## [Live App Demo](https://amitxshukla.github.io/GoogleCommunity/)
   username: shukla@duck.com
   password: Password1

## Technology stack
    UI/UX:          Flutter
    Backend:        Firebase
    AI:             Gemini
    Location API:   Google

    API KEYs : ./watchApp/api-key.dart

## Process flow

```mermaid
stateDiagram-v2
        direction LRstateDiagram-v2
        [*] --> signup
        signup --> email
        signup --> social
        email --> login
        social --> login
        login --> Settings
        dark_Mode --> Settings
        multi_Lang --> Settings
        ph_email_loc_contacts_pswd --> Settings
        devices --> Personal
        car --> devices
        cameras --> devices
        motion --> devices
        CO --> devices
        login --> Community
        login --> Personal
        Community --> Gemini
        Personal --> Gemini
        Gemini --> Alert
        Alert --> Notification
        Settings --> Notification
        
%% Define classes for coloring
    classDef red fill:#ff8,stroke:#333,stroke-width:2px;
    classDef green fill:#8fa,stroke:#333,stroke-width:2px;
    classDef blue fill:#f66,stroke:#333,stroke-width:2px;
    classDef orange fill:#f92,stroke:#333,stroke-width:2px;
    classDef danger fill:#99f,stroke:#333,stroke-width:2px;
    classDef yellow fill:#56f,stroke:#333,stroke-width:2px;
    classDef brown fill:#fe3,stroke:#333,stroke-width:2px;
    classDef neil fill:#1ff,stroke:#333,stroke-width:2px;
    classDef peil fill:#cff,stroke:#333,stroke-width:2px;

    %% Apply classes to states
    class signup green
    class email green
    class social green
    class login blue
    class Rider orange
    class Personal orange
    class Community orange
    class Gemini danger
    class Alert brown
    class dark_Mode neil
    class multi_Lang neil
    class ph_email_loc_contacts_pswd neil
    class devices neil
    class car peil
    class cameras peil
    class motion peil
    class CO peil
    class Settings brown
    class Notification green
```

## work flow
```mermaid
---
config:
  sankey:
    showValues: false
---

sankey-beta

%% source,target,value
 Temp, Weather, 25
 Flood, Weather, 25
 Air, Weather, 25
 Quake, Weather, 25
 Weather, Gemini, 35
 Smoke, Sensors, 25
 Siren, Sensors, 25
 break-in, Sensors, 25
 moisture, Sensors, 25
 Sensors, Gemini, 35
 Gemini, Alert, 100
 Cameras, Images, 20
 Water Leaks, Images, 20
 Sprinkler, Images, 20
 Littering, Images, 20
 Images, Gemini, 30
```

```mermaid
---
config:
  sankey:
    showValues: false
---

sankey-beta
%% source,target,value
 Law Enforcement, Community, 20
 Railroad Crossings, Community, 10
 Intruder, Community, 10
 Dog run, Community, 10
 Large Gathering, Community, 20
 Bridge Safety, Community, 10
 Mail is here, Community, 10
 Mail-in ballot, Community, 10
 Community, Gemini, 100
 Gemini, Alert, 100
 Thanks giving, Goodies, 10
 Recipe, Goodies, 10
 Solar, Goodies, 10
 Handyman, Goodies, 10
 Referrals, Goodies, 10
 garbage disposal, Goodies, 10
 errands, Goodies, 10
 flowers seeds, Goodies, 10
 berries fruits, Goodies, 10
 extra food, Goodies, 10
 Goodies, Gemini, 100
 Gemini, Alert, 100
```

## Planned features
- Multilanguage: add more language support
- History: delete | retain individual chat, re-generate prompt
- Media: delete | retain individual pic, re-generate prompt
- SignIn: add phone authentication
- Notification: push, email, Text, Emergency, Badge
- Gemini: feedback, auto update RAG
- Gemini: file upload (limit per user)
- Community: auto complete to current GeoLocation | google Location API
- update API key (user to upload their own keys)
- update Alert, Community Alert, Snooze, Bookmark functionality

![preview](./banner.png)