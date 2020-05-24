# Preparation of the startup environment for the mobile application written in the flutter


1. [Install Android Studio](https://developer.android.com/studio/install/)
2. [Install the Flutter and Dart plugins](https://flutter.dev/docs/get-started/editor)
3. Recommended boot device in virtual device:  
For Android: Pixel 2, API Level: R  
For iOS: 11 pro Max  
4. Install the required packages by typing flutter pub get in the terminal
5. When running the application with the backend locally, it is necessary to change _basePath in mobile_app/lib/apis/api.dart  
For Android Devices: static final String _basePath = 'http://10.0.2.2/api';  
For iOS Devices: static final String _basePath = 'http://localhost/api';  
6. Run the backend as [instructed](https://github.com/measure-your-life-squad/measure-your-life/blob/develop/api_backend_server/README.md/) before debugging the application
7. Debug application from main.dart
