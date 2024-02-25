# 🚨 Introduction: MissingYou
![d5bfc93299dcfc9f](https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/68546023/9a944c30-dfe8-4857-925f-cc4603671baf)

In September 2021, a system was introduced in Korea to send missing person notification text to citizens when high-risk individuals, such as children, teenagers, disabled people, and dementia patients, go missing. This messaging system has proven effective, significantly reducing the average time to find missing persons in high-risk groups from 34 hours to 3 hours and 10 minutes through the sightings of the citizens. 

However, the process for transmission in this system is complex, involving passage through five organizations. Also, because they are text-based, missing person alert texts are easily forgotten by citizens and their use is limited by citizen fatigue.

Our team's app, "MissingYou", wants to help the reporter easily register a missing person report and ask as many people for help as soon as possible.

Leveraging the "Picture Superiority Effect," which suggests that visual information is easier to recognize and remember, the app is designed with a photo-oriented reporting system. The AI Image Generator can generate clothing images based on the provided information. Additionally, we provides location-based missing person reports and calculates the match rate between the sighting photos and the missing persons’ photos. Unlike one-way communication through existing systems, the app allows witnesses to check updates on the missing status through witness comments.

With "MissingYou", we want to expand beyond the existing high-risk missing persons ‘missing person notification text’ providing various types of missing reports and encouraging active sighting to involve everyone in creating a safe and peaceful community.
<br/>
## 🚩UN SDGs Goals & Target
<img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/7e8b417c-bbae-420b-9098-7047970d0d68" width="250"/><br/>
Goal 16: Peace, Justice and Strong Institutions
<br/>

## 🎥  Demo Video Link
[![3](https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/68546023/1d48b4de-2ddd-465d-b98b-ac0a735da086)](https://youtu.be/MADOLeX1loE)


<br/>

## 🪄 How to run MissingYou

<br/>

## 🛠  Project Architecure
![image](https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/68546023/b1b573ab-c66c-4d10-b0f1-6a86ead06c05)

<br/>

## 📱  App Screen
### 1. Login Page

| Page                                                                                                                                       | Explanation                                     |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------- |
| <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/787c5fe6-b0f5-4a79-ab98-325a0dc60017" width="250"/> | Log in through Google login and use MissingYou. |

### 2. Main Page

You can check the missing person reports around you.
| Page | | Explanation |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1) Latest Missing Person Reports Tab** <br/><br/> <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/75c26032-8a27-47f0-adcb-65e44fbd686f" width="250"/> | | Displays the missing person reports around you in the most up-to-date order.<br/>You can view brief missing person information and a photo, and click to view detailed of the report. |
| **2) Map Tab** <br/><br/> <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/aab2dc6b-420c-48b9-83c0-0de20fc754e7" width="250"/> | <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/63602f52-519b-414f-94c7-14923fa2f1c7" width="250"/> | Displays the missing person reports around you as a marker on a map.<br/> Click the marker on the map to see the details of the report. |

### 3. Report Registration Page

You can write a missing person report by clicking the 'Report' floating button on the main page.

| Page                                                                                                                                       |                                                                                                                                            | Explanation                                                                                                                                                                                                                                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/3c57bac6-555f-4f2d-be89-74d624c13f26" width="250"/> | <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/f55630ea-cded-4e1b-8981-250e736820fd" width="250"/> | If there is a missing case, you can write a report. <br/><br/><br/> [Input Field] <br/> - photos(required\*) <br/> - name (\*) <br/> -gender (\*), age (\*) <br/> - height, weight <br/> - time of missing (\*) <br/> - last location (\*) <br/> - clothing at the time of missing (\*) <br/> - special note |
| <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/3ddcb845-04c7-4fb1-8641-8c8173a789fb" width="250"/> | <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/e82b799c-26f5-41b1-b1a5-cd404808c434" width="250"/> | (Left) The last location is entered via Google Maps. <br/><br/> (Right) When you press the registration button, an AI Image Generator creates an image of missing person’s clothing based on the provided information.                                                                                       |

### 4. Report Page

You can check the details of the report and the witness comments on the report.
| Page | | Explanation |
|---|---|---|
| **1) Report Detail Tab** <br/> <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/71a2dad6-8726-444c-be9a-d1cf75cbef3c" width="250"/> | | It shows the information and photos of the missing person written by the reporter.<br>The AI-generated image is shown with the guide 'This is an AI-generated image based on the information entered'. |
| **2) Witness Comments Tab** <br/> <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/4708e9ff-bbe3-43ea-bf71-1853d1bd6f0c" width="250"/> | <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/dff9d63e-43d3-459c-838d-089cbecb4776" width="250"/> | This page shows the witness comments along with the map. <br/><br/> Missing locations are marked with blue markers and witness comments are marked with red markers. <br/> Click a marker to display the corresponding witness comment at the top.
| <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/69b11946-94a5-45cd-b417-3b02e22e2ea4" width="250"/> | <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/5ca2568a-50b6-4375-8a18-89298bf60e73" width="250"/> | The reporter can filter the comments based on the matching rate between the photos uploaded by the witness and those of the missing person. <br/> |
| <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/1a4ccde0-cf2d-432f-8c0e-c65a491253ae" width="250"/> | <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/0f263b8a-9d91-4e32-9635-518fc39dfc31" width="250"/> | (left) You can release a missing person report by clicking the 'Release' floating button.<br/><br/> (right) If you're not a reporter, you'll see a 'Write Witness Comment' floating button. You can press this to write comment. Only the reporter and the Witness who submitted the comment can view the unblurred photos. |

### 5. Witness Comment Registration Page

| Page                                                                                                                                       |                                                                                                                                            | Explanation                                                                                                                                                                                                                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/61613c0c-5bfb-4258-a8bf-562760b5c913" width="250"/> | <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/6a7459ce-14d2-48fe-87a3-8cd2a49ad309" width="250"/> | If you spotted a missing person, you can write a witness comment. <br/><br/> [Input Field] <br/> - photos of witnessing (required\*) <br/> - the time of witnessing (\*) <br/> - the location of witnessing (\*) <br/> - clothing at the time of witnessing <br/> - the situation at the time of the witnessing |

### 6. My Info Page

| Page                                                                                                                                                                                      | Explanation                                                                                                                                                                                                                                                                  |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/86f82b40-69d7-4722-b064-c4f356557286" width="250"/>                                                | You can view user information set up the app. <br/><br/> - User Infomation <br/><br/> - Manage writing <br/> 1) Written missing person reports <br/> 2) Written witness comments <br/>3) bookmarked missing person reports <br/><br/> - Set up <br/> Logout <br/> Withdrawal |
| **1) Written missing person reports** <br/> <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/3e310d68-9b08-414e-8a9c-0b05dde671f1" width="250"/>    | You can check and delete the missing person reports you have written.                                                                                                                                                                                                        |
| **2) Written witness comments** <br/> <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/ac6377ad-e7d5-40ec-a974-18a519cf7c75" width="250"/>          | You can check and delete the witness comments you have written.                                                                                                                                                                                                              |
| **3) bookmarked missing person reports** <br/> <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/3be56a43-b421-4959-976e-347581ed6b6d" width="250"/> | You can check the bookmarked missing person reports.                                                                                                                                                                                                                         |
<br/>

## 👯‍♀️  People of IRIS
|Name|[김희서]() <br/> (Heeseo Kim)|[이주은](https://github.com/lizuAg) <br/> (Jueun Lee)|[이혜린]() <br/> (Hyerin Lee)|[최예나]() <br/> (Yena Choi)|
|:---:|---|---|---|---|
|Role|- Deploy spring server with GCP Virtual Machine<br/>- Manage MySql DB with GCP SQL<br/>- Server APIs|- Deploy spring server with GCP Virtual Machine<br/>- Manage MySql DB with GCP SQL<br/>- Server APIs|- Deploy spring server with GCP Virtual Machine<br/>- Manage MySql DB with GCP SQL<br/>- Server APIs|- Deploy spring server with GCP Virtual Machine<br/>- Manage MySql DB with GCP SQL<br/>- Server APIs|
|GitHub<br/>Repository|[<img src="https://github.com/lizuAg.png">](https://github.com/lizuAg)|<img src="https://github.com/lizuAg.png">|<img src="https://github.com/lizuAg.png">|<img src="https://github.com/lizuAg.png">|
