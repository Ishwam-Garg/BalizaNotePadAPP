import 'package:balize_todo/Services/allFiles.dart';
import 'package:balize_todo/Store/TodoStore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:balize_todo/Store/Index.dart';
import 'package:firebase_auth/firebase_auth.dart';
class CreatePostScreen extends StatefulWidget {
  final User user;
  CreatePostScreen(this.user);
  //const CreatePostScreen({Key key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  String title='',description='';

  void AddData(User user,String title,String des)
  {
    DateTime now = DateTime.now();
    String time = DateFormat('kk:mm').format(now);
    //String date = DateFormat('d EEE, MMM, YYY').format(now);
    //String date = DateFormat('dd-MM-yyyy').format(now);
    String date = DateFormat.yMMMMd().format(now);

    String timestamp = Timestamp.now().toString();
    CollectionReference ref = FirebaseFirestore.instance.collection("Users").doc(widget.user.uid).collection('Posts');

    Map<String,String> data = {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'isBookmarked': 'false',
      'timeStamp': timestamp,
    };

    ref.add(data);

  }

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    DateTime now = DateTime.now();
    String time = DateFormat('kk:mm').format(now);
    String date = DateFormat('d EEE, MMM').format(now);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            if(_formKey.currentState.validate())
              {
                  AddData(widget.user, title, description);
                  Navigator.pop(context);
              }
          },
          backgroundColor: Color(0xff00316E),
          label: Text('Create',style: TextStyle(fontSize: 18,color: Colors.grey.shade200),),
          icon: Icon(Icons.add,color: Colors.grey.shade200,size: 28,),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff00316E),
        title: Text('Create',style: TextStyle(color: Colors.grey.shade200),),
      ),
      body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 20,),
                  //title box
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      cursorColor: Color(0xff00316E).withOpacity(0.6),
                      maxLength: 40,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Title',
                        enabled: true,
                        labelStyle: TextStyle(color: Color(0xff00316E),fontWeight: FontWeight.bold,fontSize: 22),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff00316E).withOpacity(0.8)
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff00316E).withOpacity(0.6),
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red.shade500,
                          ),
                        ),
                      ),
                      validator: (value){
                        if(value.length < 4)
                          {
                            return 'Title cannot be less than 4 letters';
                          }

                      },
                      onChanged: (value){
                        title = value;
                      },
                      onSaved: (value){
                        title = value;
                      },
                      onFieldSubmitted: (value){
                        title = value;
                      },
                    ),
                  ),
                //description box
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    cursorColor: Color(0xff00316E).withOpacity(0.6),
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Description',
                      enabled: true,
                      labelStyle: TextStyle(color: Color(0xff00316E),fontWeight: FontWeight.bold,fontSize: 22),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xff00316E).withOpacity(0.8)
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff00316E).withOpacity(0.6),
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red.shade500,
                        ),
                      ),
                    ),
                    validator: (value){
                      if(value.length < 10)
                      {
                        return 'description cannot be less than 10 letters';
                      }

                    },
                    onChanged: (value){
                      description = value;
                    },
                    onSaved: (value){
                      description = value;
                    },
                    onFieldSubmitted: (value){
                      description = value;
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
