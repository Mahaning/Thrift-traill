# Thrift-Trail

Thrift-Trail is an Android app developed using Flutter and Firebase, aimed at providing users with a comprehensive solution for personal finance management, task organization, and seamless bill splitting among friends.

## Features

- **User Authentication:** Secure sign up and sign in functionality using Firebase Authentication.
- **Transaction Management:** Add, view, and manage credited and debited transactions with ease.
- **To-Do Task Management:** Organize tasks, set priorities, and never miss a deadline.
- **Bill Splitting:** Effortlessly split bills among friends and keep track of payment history.
- **Friend Management:** Add friends from your contact list or manually, and manage your friends list efficiently.

## Screenshots

![Home Page](![WhatsApp Image 2024-05-28 at 10 41 41_4dda9dcf](https://github.com/Mahaning/Thrift-traill/assets/92427624/62d1c5e9-bd29-449b-bddc-0353832e9160)
)
![Screenshot 2](https://github.com/Mahaning/Thrift-traill/assets/screenshots/screenshot2.jpg)
![Screenshot 3](https://github.com/Mahaning/Thrift-traill/assets/screenshots/screenshot3.jpg)
![Screenshot 4](https://github.com/Mahaning/Thrift-traill/assets/screenshots/screenshot4.jpg)
![Screenshot 5](https://github.com/Mahaning/Thrift-traill/assets/screenshots/screenshot5.jpg)
![Screenshot 6](https://github.com/Mahaning/Thrift-traill/assets/screenshots/screenshot6.jpg)
![Screenshot 7](https://github.com/Mahaning/Thrift-traill/assets/screenshots/screenshot7.jpg)
![Screenshot 8](https://github.com/Mahaning/Thrift-traill/assets/screenshots/screenshot8.jpg)
![Screenshot 9](https://github.com/Mahaning/Thrift-traill/assets/screenshots/screenshot9.jpg)
![Screenshot 10](https://github.com/Mahaning/Thrift-traill/assets/screenshots/screenshot10.jpg)
![Screenshot 11](https://github.com/Mahaning/Thrift-traill/assets/screenshots/screenshot11.jpg)
![Screenshot 12](https://github.com/Mahaning/Thrift-traill/assets/screenshots/screenshot12.jpg)

## Getting Started

To get started with Thrift-Trail, follow these steps:

1. Clone this repository: `git clone https://github.com/yourusername/thrift-trail.git`
2. Navigate to the project directory: `cd thrift-trail`
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

