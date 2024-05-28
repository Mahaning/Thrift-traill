# Thrift-Trail

Thrift-Trail is an Android app developed using Flutter and Firebase, aimed at providing users with a comprehensive solution for personal finance management, task organization, and seamless bill splitting among friends.

## Features

- **User Authentication:** Secure sign up and sign in functionality using Firebase Authentication.
- **Transaction Management:** Add, view, and manage credited and debited transactions with ease.
- **To-Do Task Management:** Organize tasks, set priorities, and never miss a deadline.
- **Bill Splitting:** Effortlessly split bills among friends and keep track of payment history.
- **Friend Management:** Add friends from your contact list or manually, and manage your friends list efficiently.

## Screenshots

![WhatsApp Image 2024-05-28 at 10 41 36_2529454a](https://github.com/Mahaning/Thrift-traill/assets/92427624/395d6366-912a-431b-b54b-23441bb0379e)
![WhatsApp Image 2024-05-28 at 10 41 36_c4e87a79](https://github.com/Mahaning/Thrift-traill/assets/92427624/eb8934d9-1498-4d11-8d5c-8094aec9697f)
![WhatsApp Image 2024-05-28 at 10 41 37_15cda42b](https://github.com/Mahaning/Thrift-traill/assets/92427624/ddcbde73-ddb8-4282-b994-2f924c3daf13)
![WhatsApp Image 2024-05-28 at 10 41 37_bd49d237](https://github.com/Mahaning/Thrift-traill/assets/92427624/4623f5fa-5973-4b9e-a9c4-766837f1bee1)
![WhatsApp Image 2024-05-28 at 10 41 38_6d06d79f](https://github.com/Mahaning/Thrift-traill/assets/92427624/660dc959-ece4-4fbf-841e-dc5835ba0d6f)
![WhatsApp Image 2024-05-28 at 10 41 38_c5dd58cd](https://github.com/Mahaning/Thrift-traill/assets/92427624/2c86b472-c3a5-4148-a35a-55292f4ef455)
![WhatsApp Image 2024-05-28 at 10 41 38_f4588dd2](https://github.com/Mahaning/Thrift-traill/assets/92427624/cf749fad-91ac-414c-86da-64a1ad8b408b)
![WhatsApp Image 2024-05-28 at 10 41 39_4581f7ab](https://github.com/Mahaning/Thrift-traill/assets/92427624/78d79dd1-7abc-459d-b27d-160782167399)
![WhatsApp Image 2024-05-28 at 10 41 39_bbaf0f7f](https://github.com/Mahaning/Thrift-traill/assets/92427624/44530206-f5ea-41d4-b84a-44a71d327fc2)
![WhatsApp Image 2024-05-28 at 10 41 40_4a8eba9b](https://github.com/Mahaning/Thrift-traill/assets/92427624/12fdfdfd-d7eb-4bf9-9c5c-d9a7cbe1d8e1)
![WhatsApp Image 2024-05-28 at 10 41 40_4d689bb4](https://github.com/Mahaning/Thrift-traill/assets/92427624/cd07b649-ab1c-479b-a04f-d470eb701fe4)
![WhatsApp Image 2024-05-28 at 10 41 40_54c6525a](https://github.com/Mahaning/Thrift-traill/assets/92427624/313defed-2401-43a7-9a05-e63717fdfd75)
![WhatsApp Image 2024-05-28 at 10 41 41_4dda9dcf](https://github.com/Mahaning/Thrift-traill/assets/92427624/c5382fee-5eb2-4928-b72f-2873f15be49e)




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

