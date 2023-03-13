import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_screen_task/log_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email = "";
  String password = "";
  String image = "";
  SharedPreferences? sharedPreferences;
  @override
  void initState() {
    // TODO: implement initState
    getInstanceData();
    super.initState();
  }

  getInstanceData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getData();
  }

  getData() {
    if (sharedPreferences!.containsKey('loginData')) {
      dynamic data = jsonDecode(sharedPreferences!.getString('loginData')!);

      email = data["email"];
      password = data["password"];
      image = data["image"];
    } else {
      debugPrint('false');
    }
    setState(() {});
  }

  Future<void> logout(BuildContext context) async {
    // Logout logic goes here

    // Save logout status in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);

    // Navigate to the login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Column(
        children: [
          Image.file(
            File(image),
            height: 300,
            width: 300,
          ),
          Text(
            "email: $email",
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "pass: $password",
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: () => logout(context),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  Future<bool> dataStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }
}