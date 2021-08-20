import 'package:balize_todo/AppConstants/Constants.dart';
import 'package:balize_todo/Screens/CreatePostScreen.dart';
import 'package:balize_todo/Screens/PostScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:balize_todo/Store/Index.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:balize_todo/Services/Auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'LoginScreen.dart';


class HomeScreen extends StatefulWidget {

  final User user;
  HomeScreen(this.user);


  //const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Stream<QuerySnapshot> getTodoData(User user) {

    Stream<QuerySnapshot> snapshot;

    snapshot = FirebaseFirestore.instance.collection("Users").doc(user.uid).collection('Posts').orderBy('timeStamp',descending: true).snapshots();

    return snapshot;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: EdgeInsets.only(top: 40,left: 10,right: 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Constants.primary_accent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            widget.user.photoURL!=null?
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: NetworkImage(widget.user.photoURL),
                            ) : Container(),
                            SizedBox(width: 20,),
                            Expanded(
                                child: Container(
                                  child: Text(
                                      widget.user.displayName,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Constants.primary_dark,
                                      ),
                                  ),
                                )),

                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async{
                            await googleSignIn.disconnect();
                            FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Constants.primary_dark,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout,color: Colors.white,),
                                SizedBox(width: 10,),
                                Text(
                                  'Log Out',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePostScreen(widget.user)));
          },
          child: Icon(Icons.add,size: 34,),
          backgroundColor: Color(0xff00316E),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //SizedBox(height: 20,),
              //custom app bar
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //drawer button
                    GestureDetector(
                        onTap: (){
                          Scaffold.of(context).openDrawer();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Icon(Icons.menu,)),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      child: Center(
                          child: Text('MyNotes',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Color(0xff00316E)),)),
                    ),
                    GestureDetector(
                        onTap: (){},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Icon(Icons.search,)),
                        )),
                  ],
                ),
              ),
              //list body
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  //color: Colors.blue.shade200,
                    child: StreamBuilder(
                        stream: getTodoData(widget.user),
                        builder: (context,snapshot){
                          if(snapshot.connectionState==ConnectionState.waiting)
                            {
                              return Center(
                                  child: Container(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Constants.primary_accent,
                                    ),
                                  ));
                            }
                          else if(snapshot.hasData)
                            {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context,index){

                                    String id;

                                    DocumentSnapshot data = snapshot.data.docs[index];

                                    id = data.id;

                                    return ListItem(context,widget.user,data,id,index);


                                  });
                            }
                          else
                            return Container(
                              child: Text('The list is Empty',
                              style: TextStyle(
                                color: Constants.primary_dark,
                                fontSize: 14,
                              ),
                              ),
                            );

                        }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  //add a docId also
  Widget ListItem(BuildContext context,User user,DocumentSnapshot data,String id,int index)
  {
    return GestureDetector(
      onTap: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context)=>PostScreen(user,data,id)));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    //width: MediaQuery.of(context).size.width*0.8-20,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(data.data()["title"],
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Color(0xff00316E)),)
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      data.data()["isBookmarked"] == "true" ?
                      Icon(Icons.star,color: Colors.yellow.shade800,) :
                      Icon(Icons.star_border),
                      SizedBox(width: 5,),
                      Icon(Icons.more_vert),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(data.data()["description"].toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: 150,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(data.data()["date"].toString() + ' ' + data.data()["time"].toString(),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,color: Colors.black.withOpacity(0.5)),),
                  ),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }




}
