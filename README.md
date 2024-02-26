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

## 🎥 Demo Video Link

[![3](https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/68546023/1d48b4de-2ddd-465d-b98b-ac0a735da086)](https://youtu.be/MADOLeX1loE)

<br/>

## 🪄 How to run MissingYou
### Android
- Click [here](https://drive.google.com/drive/folders/1bLgtt6Rjo8g86pfaS9yHW5ZoNOGut2EZ) to download an APK file.
- Install the "app-release.apk" file on your android device.
<br/>

## 🛠 Project Architecure

![image](https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/68546023/b1b573ab-c66c-4d10-b0f1-6a86ead06c05)

<br/>

## 📱 App Screen

### 1. Login Page

<table style="border:none;">
   <tr>
      <td width="37%">
         <b>Page</b>
      </td>
      <td width="63%">
        <b>Explanation</b>
      </td>
   </tr>
   <tr>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/787c5fe6-b0f5-4a79-ab98-325a0dc60017" width="250"/>                   
      </td>
      <td>
        Log in through Google login and use MissingYou.
      </td>
   </tr>
</table><br/>

### 2. Main Page

You can check the missing person reports around you.

<table style="border:none;">
   <tr>
      <td colspan='2' width="54%">
         <b>Page</b>
      </td>
      <td width="46%">
        <b>Explanation</b>
      </td>
   </tr>
       <td colspan='3'>
        <b>1) Latest Missing Person Reports Tab</b>
    </td>
   <tr>
      <td colspan='2'>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/75c26032-8a27-47f0-adcb-65e44fbd686f" width="250"/>
      </td>
      <td>
        Displays the missing person reports around you in the most up-to-date order.<br/>You can view brief missing person information and a photo, and click to view detailed of the report.
      </td>
   </tr>
    </tr>
        <td colspan='3'>
        <b>2) Map Tab</b>
        </td>
    <tr>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/aab2dc6b-420c-48b9-83c0-0de20fc754e7" width="250"/>
      </td>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/63602f52-519b-414f-94c7-14923fa2f1c7" width="250"/>
      <td>
       Displays the missing person reports around you as a marker on a map.<br/> Click the marker on the map to see the details of the report.
      </td>
   </tr>
</table><br/>

### 3. Report Registration Page

You can write a missing person report by clicking the 'Report' floating button on the main page.

<table style="border:none;">
   <tr>
      <td colspan='2' width="54%">
         <b>Page</b>
      </td>
      <td width="46%">
        <b>Explanation</b>
      </td>
   </tr>
   <tr>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/3c57bac6-555f-4f2d-be89-74d624c13f26" width="250"/> 
      </td>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/f55630ea-cded-4e1b-8981-250e736820fd" width="250"/>
      </td>
      <td>
        If there is a missing case, you can write a report. <br/><br/><br/> [Input Field] <br/> - photos(required*) <br/> - name (*) <br/> -gender (*), age (*) <br/> - height, weight <br/> - time of missing (*) <br/> - last location (*) <br/> - clothing at the time of missing (*) <br/> - special note
      </td>
   </tr>
      <tr>
      <td>
       <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/3ddcb845-04c7-4fb1-8641-8c8173a789fb" width="250"/>
      </td>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/e82b799c-26f5-41b1-b1a5-cd404808c434" width="250"/> 
      <td>
       (Left) The last location is entered via Google Maps. <br/><br/> (Right) When you press the registration button, an AI Image Generator creates an image of missing person’s clothing based on the provided information.
      </td>
   </tr>
</table><br/>

### 4. Report Page

You can check the details of the report and the witness comments on the report.

<table style="border:none;">
   <tr>
      <td colspan='2' width="54%">
         <b>Page</b>
      </td>
      <td width="46%">
        <b>Explanation</b>
      </td>
   </tr>
   <tr>
    <td colspan='3'>
        <b>1) Report Detail Tab</b>
    </td>
   </tr>
   <tr>
      <td colspan='2'>
         <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/71a2dad6-8726-444c-be9a-d1cf75cbef3c" width="250"/>
      </td>
      <td>
         It shows the information and photos of the missing person written by the reporter.<br>The AI-generated image is shown with the guide 'This is an AI-generated image based on the information entered'.
      </td>
   </tr>
      <tr>
    <td colspan='3'>
        <b>2) Witness Comments Tab</b>
    </td>
   </tr>
   <tr>
      <td>
         <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/4708e9ff-bbe3-43ea-bf71-1853d1bd6f0c" width="250"/> 
      </td>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/dff9d63e-43d3-459c-838d-089cbecb4776" width="250"/>
      </td>
      <td>
         This page shows the witness comments along with the map. <br/><br/> Missing locations are marked with blue markers and witness comments are marked with red markers. <br/> Click a marker to display the corresponding witness comment at the top.
      </td>
   </tr>
      <tr>
      <td>
         <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/69b11946-94a5-45cd-b417-3b02e22e2ea4" width="250"/> 
      </td>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/5ca2568a-50b6-4375-8a18-89298bf60e73" width="250"/>
      </td>
      <td>
         The reporter can filter the comments based on the matching rate between the photos uploaded by the witness and those of the missing person.
      </td>
   </tr>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/1a4ccde0-cf2d-432f-8c0e-c65a491253ae" width="250"/>
      </td>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/0f263b8a-9d91-4e32-9635-518fc39dfc31" width="250"/>
      </td>
      <td>
        (left) You can release a missing person report by clicking the 'Release' floating button.<br/><br/> (right) If you're not a reporter, you'll see a 'Write Witness Comment' floating button. You can press this to write comment. Only the reporter and the Witness who submitted the comment can view the unblurred photos.
      </td>
   </tr>
</table><br/>

   </tr>
      <td>
      </td>
      <td>
      </td>
      <td>
      </td>
   </tr>

### 5. Witness Comment Registration Page

<table style="border:none;">
   <tr>
      <td colspan='2' width="54%">
         <b>Page</b>
      </td>
      <td width="46%">
        <b>Explanation</b>
      </td>
   </tr>
   <tr>
      <td>
         <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/61613c0c-5bfb-4258-a8bf-562760b5c913" width="250"/>
      </td>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/6a7459ce-14d2-48fe-87a3-8cd2a49ad309" width="250"/> 
      </td>
      <td>
        If you spotted a missing person, you can write a witness comment. <br/><br/> [Input Field] <br/> - photos of witnessing (required*) <br/> - the time of witnessing (*) <br/> - the location of witnessing (*) <br/> - clothing at the time of witnessing <br/> - the situation at the time of the witnessing
      </td>
   </tr>
</table><br/>

### 6. My Info Page

<table style="border:none;">
   <tr>
      <td width="37%">
         <b>Page</b>
      </td>
      <td width="63%">
        <b>Explanation</b>
      </td>
   </tr>
   <tr>
      <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/86f82b40-69d7-4722-b064-c4f356557286" width="250"/>                      
      </td>
      <td>
        You can view user information set up the app. <br/><br/> - User Infomation <br/><br/> - Manage writing <br/> 1) Written missing person reports <br/> 2) Written witness comments <br/>3) bookmarked missing person reports <br/><br/> - Set up <br/> Logout <br/> Withdrawal
      </td>
   </tr>
    <tr>
    <td colspan='3'>
        <b>1) Written missing person reports</b>
    </td>
   </tr>
   <tr>
    <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/3e310d68-9b08-414e-8a9c-0b05dde671f1" width="250"/> 
    </td>
     <td>
        You can check and delete the missing person reports you have written.
    </td>
   </tr>
     <tr>
    <td colspan='3'>
        <b>2) Written witness comments</b>
    </td>
   </tr>
   <tr>
    <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/ac6377ad-e7d5-40ec-a974-18a519cf7c75" width="250"/>
    </td>
     <td>
        You can check and delete the witness comments you have written.
    </td>
   </tr>
    <tr>
    <td colspan='3'>
        <b>3) bookmarked missing person reports</b>
    </td>
   </tr>
   <tr>
    <td>
        <img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/76986589/3be56a43-b421-4959-976e-347581ed6b6d" width="250"/>
    </td>
     <td>
        You can check the bookmarked missing person reports.
    </td>
   </tr>
</table><br/>    

## 👯‍♀️  People of IRIS
|Name|[김희서](https://github.com/hap6v6) <br/> (Heeseo Kim)|[이주은](https://github.com/lizuAg) <br/> (Jueun Lee)|[이혜린](https://github.com/2hyerin) <br/> (Hyerin Lee)|[최예나]() <br/> (Yena Choi)|
|:---:|---|---|---|---|
|Role|- UI Design (Main Page, Report Registration Page, Witness Comment Registration Page)<br/>- Implement Google Map API (Google Map Widget, Geocoding)<br/>- Implement API Communication: Main Page, Report Registration Page,  Witness Comment Registration Page, My Page, Bookmark)<br/>- Manage MySql DB with GCP SQL<br/>- Server APIs|- Deploy spring server with GCP Virtual Machine<br/>- Manage MySql DB with GCP SQL<br/>- Server APIs|- Deploy FastAPI with GCP virtual machine<br/>- Calculate similarity between faces<br/>- Generate clothing image<br/>- Train models to face detection and verification |- Deploy spring server with GCP Virtual Machine<br/>- Manage MySql DB with GCP SQL<br/>- Server APIs|
|GitHub<br/>Repository|[<img src="https://avatars.githubusercontent.com/u/76986589?v=4">](https://github.com/hap6v6)|[<img src="https://github.com/lizuAg.png">](https://github.com/lizuAg)|[<img src="https://github.com/dsc-sookmyung/2024-IRIS-SolutionChallenge/assets/88357058/e24a0b1d-232f-474e-8135-f14fcb9397ea">](https://github.com/2hyerin)|<img src="https://github.com/lizuAg.png">|
