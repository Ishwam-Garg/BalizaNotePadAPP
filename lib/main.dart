import 'package:balize_todo/Screens/HomesScreen.dart';
import 'package:balize_todo/Screens/LoginScreen.dart';
import 'package:balize_todo/Screens/SplashScreen.dart';
import 'package:balize_todo/Services/RootUserLoggedIn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}



