import 'package:balize_todo/AppConstants/Constants.dart';
import 'package:balize_todo/Services/allFiles.dart';
import 'package:flutter/material.dart';
import 'package:balize_todo/Services/Auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  void CreateUser(User user) async{

    DateTime now = DateTime.now();
    String time = DateFormat('kk:mm').format(now);
    String date = DateFormat('d EEE, MMM').format(now);


    DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(user.uid);

    Map<String,dynamic> userData = {
      'name': user.displayName,
      'email': user.email,
      'photoUrl': user.photoURL,
      'lastLoginDate': date,
      'lastLoginTime': time,
    };

    ref.collection('UserData').doc('information').set(userData);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Log In',
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: Constants.primary_dark,fontSize: 44,fontWeight: FontWeight.bold),),
                  )
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                child: GestureDetector(
                  onTap: (){
                      google_sign_in().then((user){
                        if(user!=null)
                          {
                            CreateUser(user);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(user)));
                          }
                      });
                  },
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                      width: MediaQuery.of(context).size.width*0.8,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(Constants.google),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              child: Text(
                                'Google Sign In',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Constants.primary_dark,
                                  fontWeight: FontWeight.bold
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}
