import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditScreen extends StatefulWidget {

  final User user;
  final DocumentSnapshot data;
  final String docId;

  EditScreen(this.user,this.data,this.docId);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  final _formKey = GlobalKey<FormState>();
  String title,description;

  void UpdateData(User user,String title,String description,String book,String docId)
  {
    DateTime now = DateTime.now();
    String time = DateFormat('kk:mm').format(now);
    //String date = DateFormat('d EEE, MMM, YYY').format(now);
    //String date = DateFormat('dd-MM-yyyy').format(now);
    String date = DateFormat.yMMMMd().format(now);

    String timestamp = Timestamp.now().toString();
    DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(widget.user.uid).collection('Posts').doc(docId);

    Map<String,String> data = {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'isBookmarked': 'false',
      'timeStamp': timestamp,
    };

    ref.update(data);

  }

  @override
  Widget build(BuildContext context) {
    title = widget.data.data()["title"];
    description = widget.data.data()["description"];
    DateTime now = DateTime.now();
    String time = DateFormat('kk:mm').format(now);
    String date = DateFormat('d EEE, MMM').format(now);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          if(_formKey.currentState.validate())
          {
            UpdateData(widget.user, title, description, widget.data.data()["isBookmarked"], widget.docId);
            Navigator.pop(context);
          }
        },
        backgroundColor: Color(0xff00316E),
        label: Text('Save',style: TextStyle(fontSize: 18,color: Colors.grey.shade200),),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff00316E),
        title: Text('Edit',style: TextStyle(color: Colors.grey.shade200),),
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
                    initialValue: widget.data.data()["title"],
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
                    initialValue: widget.data.data()["description"],
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
