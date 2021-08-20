import 'package:balize_todo/Screens/HomesScreen.dart';
import 'package:balize_todo/Screens/LoginScreen.dart';
import 'package:balize_todo/Services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CheckRootUser extends StatelessWidget {
  //const CheckRootUser({Key key}) : super(key: key);

  User user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot){
          if(snapshot.hasData)
            {
              user = snapshot.data;
              return HomeScreen(user);
            }
          else
            {
              return LoginScreen();
            }
        });
  }
}
