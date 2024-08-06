# Google Community Watch

CommunityWatch App is AI application which serves as a live alert app which reads all data, information, security alerts, local government danger alerts, warnings and mix with all neighborhood application including neighbors or community camera and other picture information shared. 

The Watch App's AI engine can process and analyze visual data from images, videos, and other sources to infer and identify security concerns, threats, or other critical information. It can then categorize this information as non-critical, alert-level, or critical, and automatically notify relevant community members through personalized alerts based on their specific interests and areas of concern.

## Author: Amit Shukla
## Connect 

[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/youtube.svg" width=40 height=50>](https://youtube.com/@Amit.Shukla)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/github.svg" width=40 height=50>](https://github.com/AmitXShukla)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/medium.svg" width=40 height=50>](https://medium.com/@Amit-Shukla)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/twitter_1.svg" width=40 height=50>](https://x.com/@ashuklax)


## [Video Demo](https://youtube.com/@Amit.Shukla)
## [Live App Demo](https://youtube.com/@Amit.Shukla)

## Technology stack
    UI/UX:          Flutter
    Backend:        Firebase
    AI:             Gemini
    Location API:   Google

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
        devices --> Settings
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

## TODO
- process flow
- UI/UX
- Firebase Rules Doc
- Google Location API