# FitnessTracker
 - Configurations:
   - Flutter SDK Installation (Latest Version)
   - VSCode or Intellij IDE
   - Emulator: Pixel 7 API 30 (Download using Android Studio)
   - Ensure Stable Connectivity
   - Target Platform (Anroid Studio to Emulate an Android Device)
   - Firebase API Key (More details in firebase_options.dart)(AIzaSyAI8K2u3pfF6EpO-zmitUEsDgJiyoYYoWk)\
   - To test Apple Sign In and Google Sign In, will require an account for both services. 
   - Run flutter application though main.dart (run using main() function) whilst having Emulator available and connected to IDE
   - Pubspec Yaml list dependencies of the project (libraries, packages, images (assets)) --> All are up-to-date

  - Project Breakdown:
    - Auth
      - Google Sign In handler functions 
      - Apple Sign In handler functions
        - Allows user to sign in through Sign In and Register Pages
    
    - Data
      - flutterfire database: interactions with firebase console
      - hive_database: interactions with Hive database (Workouts and Exercises)
      - workout_data: functions required to sort formatting of lists etc for storage in the above databases
    
    - Datetime
      - Posseses abilities for future expansion e.g., use of a heatmap
      - Also, functions for storage of the date for particular commits to the databases 

    - fitnesssImage:
      - Possesses the assets that are referenced in the pubspec yaml
      - Images of google icons, apple icons and company icon

    - models:
      - Possess the fundamental classes of the objects stored in the database
      - e.g., exercises, workout 
      - profileCalc produces function models of statistics calculated for the profile.
    
    - pages:
      - about-us 
      - auth_page : snapshot identifies previous data 
      - home_page : main fitness tacker application feature
      - profile 
      - register_page
      - user_details : form for profile page
      - work_out_page : form for the main page (Exercise Details or Workout Details)

    - ui_components:
      - UI features for reducing complexities for code page
    
    - firebase_options : configurations for firebase API
    - main : runs the application and page to designate the  user initially

