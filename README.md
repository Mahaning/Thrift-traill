# Thrift-Trail

Thrift-Trail is an Android app developed using Flutter and Firebase, aimed at providing users with a comprehensive solution for personal finance management, task organization, and seamless bill splitting among friends.

## Features

- **User Authentication:** Secure sign up and sign in functionality using Firebase Authentication.
- **Transaction Management:** Add, view, and manage credited and debited transactions with ease.
- **To-Do Task Management:** Organize tasks, set priorities, and never miss a deadline.
- **Bill Splitting:** Effortlessly split bills among friends and keep track of payment history.
- **Friend Management:** Add friends from your contact list or manually, and manage your friends list efficiently.

## Video :
here you can find vedio clip in my linked in post:
```
https://www.linkedin.com/posts/mahaning-hubballi-76b796222_flutter-firebase-appdevelopment-activity-7201135194005782528-Kh_f?utm_source=share&utm_medium=member_desktop
```

## Screenshots
***Home Page***<br/><br/>
![WhatsApp Image 2024-05-28 at 10 41 41_4dda9dcf](https://github.com/Mahaning/Thrift-traill/assets/92427624/62d1c5e9-bd29-449b-bddc-0353832e9160)<hr/>

<br/><br/>***Add transction Page***<br/><br/>
![WhatsApp Image 2024-05-28 at 10 41 40_4a8eba9b](https://github.com/Mahaning/Thrift-traill/assets/92427624/0208a3eb-a3eb-4b3c-b7d1-c18536668e66)<hr/>

<br/><br/> ***transction Page*** <br/><br/> 
![WhatsApp Image 2024-05-28 at 10 41 40_54c6525a](https://github.com/Mahaning/Thrift-traill/assets/92427624/8e5ff7a7-63b1-4ed1-b316-b6398fd92987) <hr/>
<br/><br/>***transction Page***<br/><br/>
![WhatsApp Image 2024-05-28 at 10 41 40_4d689bb4](https://github.com/Mahaning/Thrift-traill/assets/92427624/aa03edc6-f132-414a-9cf8-dd5f57c80330)<hr/>
<br/><br/>***transction Page***<br/><br/>
![WhatsApp Image 2024-05-28 at 10 41 39_4581f7ab](https://github.com/Mahaning/Thrift-traill/assets/92427624/cfbca6a5-f516-4161-96aa-ce188a54e0d7)<hr/>
<br/><br/>***Add transction Page***<br/><br/>
![WhatsApp Image 2024-05-28 at 10 41 39_bbaf0f7f](https://github.com/Mahaning/Thrift-traill/assets/92427624/d52a9f94-999e-4b3a-bc39-3bb0fadcb033)<hr/>
<br/><br/>***To DO Task List Page***<br/><br/>
![WhatsApp Image 2024-05-28 at 10 41 38_f4588dd2](https://github.com/Mahaning/Thrift-traill/assets/92427624/d14423e6-e0bd-46a4-a474-8e5f7f9d81e7)<hr/>
<br/><br/>***Add To DO Task Page***<br/><br/>
![WhatsApp Image 2024-05-28 at 10 41 38_c5dd58cd](https://github.com/Mahaning/Thrift-traill/assets/92427624/b473ec5c-255a-44b9-bf86-70c536b7d5c1)<hr/>
<br/><br/>***Split the Bill: calculate bill***<br/><br/>
![WhatsApp Image 2024-05-28 at 10 41 38_6d06d79f](https://github.com/Mahaning/Thrift-traill/assets/92427624/eaacad65-e458-43cc-9b41-985ad72835dd)<hr/>
<br/><br/>***Split the Bill: split bill add frinds***<br/><br/>
![WhatsApp Image 2024-05-28 at 10 41 36_2529454a](https://github.com/Mahaning/Thrift-traill/assets/92427624/a7de6989-073f-42a4-885d-dcdbb657921b)<hr/>
<br/><br/>***Split the Bill:  bills list***<br/><br/>
![WhatsApp Image 2024-05-28 at 10 41 37_15cda42b](https://github.com/Mahaning/Thrift-traill/assets/92427624/9293470a-2882-40c6-b9a2-ef43849674b9)<hr/>
<br/><br/>***Split the Bill:  bills Details***<br/><br/>
![WhatsApp Image 2024-05-28 at 10 41 36_c4e87a79](https://github.com/Mahaning/Thrift-traill/assets/92427624/ef0aee7d-77c2-433a-ae12-641c9110b089)<hr/>



## Getting Started

To get started with Thrift-Trail, follow these steps:

1. Clone this repository: `git clone https://github.com/Mahaning/Thrift-traill.git`
2. Navigate to the project directory: `cd thrift-trail` remove firbase.json and add your firbase.json with required data(if it is not auto genrated means)
3. Install dependencies: `flutter pub get`
4. Connect your app to Firebase by following the instructions [here](https://firebase.google.com/docs/flutter/setup).
5. Create a `firebase_options.dart` file in the `lib` directory with the following Commands:

   ```
   firebase login
   
   dart pub global activate flutterfire_cli

   flutterfire configure
   ```
   Initialize Firebase in your app in website or in cmd :
   ```
     flutter pub add firebase_core

     flutterfire configure
   ```
   In your lib/main.dart file, import the Firebase core plugin and the configuration file you generated earlier:
```
    import 'package:firebase_core/firebase_core.dart';
    import 'firebase_options.dart';
```
    Also in your lib/main.dart file, initialize Firebase using the DefaultFirebaseOptions object exported by the configuration file:
    
    ```
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    ```
```
    Rebuild your Flutter application:
    ```
    ```
    flutter run
```

7. Run the app on your device or emulator: `flutter run`

## Contributing

Contributions are welcome! If you'd like to contribute to Thrift-Trail, please follow these steps:

1. Fork the repository and create your branch: `git checkout -b feature/new-feature`
2. Make your changes and commit them: `git commit -am 'Add new feature'`
3. Push to your branch: `git push origin feature/new-feature`
4. Submit a pull request detailing your changes.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgements

- This app was built using [Flutter](https://flutter.dev/) and [Firebase](https://firebase.google.com/).
- Special thanks to the Flutter and Firebase communities for their support and resources.
- refrence and Motivation:- Bright Infonet youtube channel[https://www.youtube.com/@brightinfonet]

## Contact

Have any questions or suggestions? Feel free to contact me at [hmaning45@gmail.com] or at [https://www.linkedin.com/in/mahaning-hubballi-76b796222/].

