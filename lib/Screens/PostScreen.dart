import 'package:balize_todo/AppConstants/Constants.dart';
import 'package:balize_todo/Screens/EditScreen.dart';
import 'package:balize_todo/Services/allFiles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class PostScreen extends StatefulWidget {

  final User user;
  final String docId;
  final DocumentSnapshot data;

  PostScreen(this.user,this.data,this.docId);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Icon(Icons.arrow_back_ios,),
                    )),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //title
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade400,
                            width: 0.5
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Text(
                          widget.data.data()['title'].toString(),
                          overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 24,
                          color: Constants.primary_dark,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  widget.data.data()["description"],
                                  style: TextStyle(
                                    color: Constants.primary_dark,
                                    fontSize: 16
                                  ),
                                ),
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(widget.data.data()["date"].toString() + ' ' + widget.data.data()["time"].toString(),
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,color: Constants.primary_dark.withOpacity(0.6)),),
                                    ),
                                  ),
                                  Container(

                                  ),
                                ],
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //custom bottom appbar
            Material(
              elevation: 10,
              color: Colors.blue.shade100,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditScreen(widget.user, widget.data, widget.docId)));
                      },
                      child: Container(
                        child: Icon(Icons.edit_outlined,size: 36,color: Color(0xff00316E),),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                          if(widget.data.data()["isBookmarked"] == "true")
                            {
                              FirebaseFirestore.instance.collection("Users").doc(widget.user.uid).collection('Posts').doc(widget.docId).update({
                                'isBookmarked': "false",
                              });
                              Fluttertoast.showToast(
                                msg: 'Bookmark removed',
                                gravity: ToastGravity.CENTER,
                                toastLength: Toast.LENGTH_SHORT,
                              );
                              Navigator.pop(context);
                            }
                          else{
                            FirebaseFirestore.instance.collection("Users").doc(widget.user.uid).collection('Posts').doc(widget.docId).update({
                              'isBookmarked': "true",
                            });
                            Fluttertoast.showToast(
                              msg: 'Post Bookmarked',
                              gravity: ToastGravity.CENTER,
                              toastLength: Toast.LENGTH_SHORT,
                            );
                            Navigator.pop(context);
                          }
                      },
                      child: Container(
                        // to pass boolean
                        child:
                        widget.data.data()["isBookmarked"] == "true"
                            ?
                        Icon(Icons.star,color: Colors.yellow.shade800,size: 36,)
                            :
                        Icon(Icons.star_border,size: 36,color: Constants.primary_dark,),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        child: Icon(Icons.share_outlined,size: 36,color: Color(0xff00316E),),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        FirebaseFirestore.instance.collection("Users").doc(widget.user.uid).collection('Posts').doc(widget.docId).delete();
                        Fluttertoast.showToast(
                            msg: 'Post deleted',
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_SHORT,
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Icon(Icons.delete,size: 36,color: Color(0xff00316E),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
