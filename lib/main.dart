// @dart=2.9
import 'dart:io';
import 'package:car_world_system/constant/app_constant.dart';
import 'package:car_world_system/sources/ui/login/first_page.dart';
import 'package:car_world_system/sources/ui/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification notification = message.notification;
  //     AndroidNotification android = message.notification?.android;
  //   });
  // FirebaseMessaging.private(channel)
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // channel = const AndroidNotificationChannel(
  //   'high_importance_channel', // id
  //   'High Importance Notifications', // title
  //   'This channel is used for important notifications.', // description
  //   importance: Importance.high,
  // );
  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

// Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
//   if (message.containsKey('data')) {
//     final dynamic data = message['data'];
//   }

//   if (message.containsKey('notification')) {
//     final dynamic notification = message['notification'];
//   }
// }

class MyApp extends StatelessWidget {
  static final String title = 'User & Admin Login';

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          color: AppConstant.backgroundColor,
          theme: ThemeData(
            colorScheme: const ColorScheme.light(),
            //scaffoldBackgroundColor: Colors.blue.shade300,
            accentColor: Colors.indigoAccent.withOpacity(0.8),
            //unselectedWidgetColor: Colors.blue.shade200,
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.all(Colors.black),
            ),
          ),
          home: LoginScreen(),
        );
      },
    );

    // MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: title,
    //     theme: ThemeData(
    //       colorScheme: const ColorScheme.dark(),
    //       //scaffoldBackgroundColor: Colors.blue.shade300,
    //       accentColor: Colors.indigoAccent.withOpacity(0.8),
    //       //unselectedWidgetColor: Colors.blue.shade200,
    //       switchTheme: SwitchThemeData(
    //         thumbColor: MaterialStateProperty.all(Colors.white),
    //       ),
    //     ),
    //     home: FirstPage(),
    //   );
  }
}
