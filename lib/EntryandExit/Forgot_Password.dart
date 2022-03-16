import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forget_pass extends StatefulWidget {
  const Forget_pass({Key, key}) : super(key: key);

  @override
  _Forgot_passState createState() => _Forgot_passState();
}

class _Forgot_passState extends State<Forget_pass> {
  final requestformkey = GlobalKey<FormState>();
  String _email;

  @override
  Widget build(BuildContext context) {
    final emailfield = TextFormField(
      // controller: email,
      onSaved: (value) {
        _email = value.trim();
      },
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        final pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        final regExp = RegExp(pattern);

        if (value.isEmpty) {
          return "Please enter a Email ID";
        } else if (!regExp.hasMatch(value)) {
          return 'Please make sure you enter a valid mail ID';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          icon: Icon(
            Icons.account_circle,
            color: Colors.black87,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintStyle: TextStyle(color: Colors.grey),
          labelText: 'Mail ID'),
    );

    final requestbtn = Container(
        // margin: EdgeInsets.only(left: 100, right: 100),
        //width: 100,
        //height: 50,
        child: Center(
      child: RaisedButton(
          onPressed: () async {
            if (requestformkey.currentState.validate()) {
              requestformkey.currentState.save();

              FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
              Fluttertoast.showToast(
                  msg: "Password reset Link has been sent to your Mail",
                  toastLength: Toast.LENGTH_LONG);
              Navigator.pop(context);
            }
          },
          child: Text("Send Request !", style: TextStyle(fontSize: 16)),
          color: Colors.black,
          textColor: Color(0xffFFD700)),
    ));

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffFFD700)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
        //child: SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("Reset your Password ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              margin: EdgeInsets.fromLTRB(40, 0, 0, 35),
            ),
            //SizedBox(height: 130.0),
            Form(
              key: requestformkey,
              child: emailfield,
            ),
            SizedBox(height: 25.0),

            requestbtn,
          ],
        ),
        //)
      ),
    );
  }
}
