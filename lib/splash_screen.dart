// import 'package:flutter/material.dart';
// import 'package:login_screen_task/home_screen.dart';
// import 'package:login_screen_task/log_in_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   SharedPreferences? sharedPreferences;
//
//   @override
//   void initState() {
//     Future.delayed(const Duration(seconds: 1), () => dataStore());
//     // getInstanceData();
//     future: getInstanceData();
//     super.initState();
//   }
//
//   getInstanceData() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }
//   dataStore() {
//     if (sharedPreferences!.containsKey('loginData')) {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const HomeScreen(),
//           ),
//               (route) => false);
//     } else {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const LoginScreen(),
//           ),
//               (route) => false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: dataStore(),
//       builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//         if (snapshot.hasData && snapshot.data!) {
//           // User is already logged in, navigate to the home screen
//           return const HomeScreen();
//         } else {
//           // User is not logged in, navigate to the login screen
//           return const LoginScreen();
//         }
//       },
//     );
//   }
// }
// //prefs?.getBool('seen') ?? false

import 'package:flutter/material.dart';
import 'package:login_screen_task/home_screen.dart';
import 'package:login_screen_task/log_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    getInstanceData();
  }

  Future<void> getInstanceData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return sharedPreferences == null
        ? const CircularProgressIndicator() // Show loading indicator while waiting for shared preferences
        : FutureBuilder<bool>(
      future: Future.value(sharedPreferences!.containsKey('loginData')),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          // User is already logged in, navigate to the home screen
          return const HomeScreen();
        } else {
          // User is not logged in, navigate to the login screen
          return const LoginScreen();
        }
      },
    );
  }
}

