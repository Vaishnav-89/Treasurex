import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:treasuex/Models/Authentication_provider.dart';
import 'package:treasuex/Models/LoadingWidget.dart';
import 'package:treasuex/main.dart';

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final signupformkey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  var _password = TextEditingController();
  var _repassword = TextEditingController();

  String _email, _address, _dob = "", _name, _contact;

  bool isHidden = true;

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  // Future<void> SignUp(BuildContext context) async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //
  //   await _auth
  //       .createUserWithEmailAndPassword(email: _email, password: _password)
  //       .catchError((onError) {
  //     print(onError);
  //   }).then((value) => Navigator.pop(context));
  // }

  //----------------------------------------------------------------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    // final titletag = Container(
    //     //padding: EdgeInsets.only(top: 30),
    //     alignment: Alignment.topLeft,
    //     child: Text(
    //       "Treasuex",
    //       style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
    //     ));

    //--------------------name field--------------------------------------------------------------------------------------------------------------------------------

    final namefield = Container(
        alignment: Alignment.centerRight,
        height: 70,
        width: 300,
        child: TextFormField(
          onSaved: (value) {
            _name = value;
          },
          validator: (value) {
            String pattern = r'(^[a-zA-Z ]*$)';
            RegExp regExp = new RegExp(pattern);

            if (value.isEmpty) {
              return "Please enter your Name";
            } else if (!regExp.hasMatch(value)) {
              return 'Enter Username with alphabets only ';
            }
            return null;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(color: Colors.grey),
              labelText: 'Name'),
        ));

    //--------------------contact field--------------------------------------------------------------------------------------------------------------------------------

    final contactfield = Container(
        height: 70,
        width: 300,
        child: TextFormField(
          onSaved: (value) {
            _contact = value.toString();
          },
          keyboardType: TextInputType.phone,
          validator: (value) {
            String pattern = r'(^[0-9]*$)';
            RegExp regExp = new RegExp(pattern);

            if (value.isEmpty) {
              return "Please enter your Contact";
            } else if (value.length != 10) {
              return "Invalid Contact";
            } else if (!regExp.hasMatch(value)) {
              return 'Please make sure you enter a valid Contact NO.';
            }
            return null;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(color: Colors.grey),
              labelText: 'Contact'),
        ));

    //--------------------DOB field--------------------------------------------------------------------------------------------------------------------------------

    final dobfield = Container(
        margin: EdgeInsets.only(left: 15),
        height: 50,
        width: 300,
        alignment: Alignment.centerLeft,
        child: Row(children: [
          Container(
            //flex: 0,
            child: InkWell(
                child: Icon(Icons.date_range),
                onTap: () async {
                  DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now())
                      .then((date) {
                    if (date != DateTime.now()) {
                      setState(() {
                        _dob = date.toString().substring(0, 10);
                      });
                    }
                  });
                }),
          ),
          Container(
            //flex: 1,
            child: Text("  Date  :  ",
                style: TextStyle(color: Colors.grey[700], fontSize: 17),
                textAlign: TextAlign.left),
            // TextFormField(
            //   readOnly: true,
            //   onSaved: (_dob) {
            //     _dob = _dob;
            //   },
            //   keyboardType: TextInputType.datetime,
            //   validator: (_dob) {
            //     if (_dob.isEmpty) {
            //       return "Enter a valid DOB";
            //     }
            //   },
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       hintStyle: TextStyle(color: Colors.grey),
            //       labelText: _dob),
            // ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              _dob == "" ? "Please Enter D.O.B " : _dob,
              style: TextStyle(color: Colors.black, fontSize: 17),
              // textAlign: TextAlign.left
            ),
          )
        ]));

    //--------------------email field--------------------------------------------------------------------------------------------------------------------------------

    final mailfield = Container(
        height: 70,
        width: 300,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) {
            _email = value;
          },
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

            // if (value.isEmpty) {
            //   return "Please enter a Email ID";
            // }
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(color: Colors.grey),
              labelText: 'Mail ID'),
        ));

    //--------------------address field--------------------------------------------------------------------------------------------------------------------------------

    final addressfield = Container(
        //height: 70,
        width: 300,
        child: TextFormField(
          onSaved: (value) {
            _address = value;
          },
          maxLines: 5,
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter your Address";
            }
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(color: Colors.grey),
              labelText: 'Address'),
        ));

    //--------------------pass field--------------------------------------------------------------------------------------------------------------------------------

    final passfield = Container(
        height: 70,
        width: 300,
        child: TextFormField(
          obscureText: true,
          controller: _password,
          // onSaved: (value) {
          //   _password = value.trim();
          // },
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter Password";
            } else if (value.length < 6) {
              return "Password has to be at least 6 characters long";
            }
            return null;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(color: Colors.grey),
              labelText: 'Password'),
        ));

    final repassfield = Container(
        height: 70,
        width: 300,
        child: TextFormField(
          obscureText: isHidden,
          controller: _repassword,
          // onSaved: (value) {
          //   _repassword = value.trim();
          // },
          validator: (_repassword) {
            if (_repassword.isEmpty) {
              return "Please RE-Enter Password";
            } else if (_repassword != _password.text) {
              return "Password doesn't Match";
            }
            return null;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                icon: isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: togglePasswordVisibility,
              ),
              labelText: 'Re-Enter Password'),
        ));

    final signupbtn = Container(
        padding: EdgeInsets.only(left: 180),
        width: 100,
        height: 50,
        child: RaisedButton(
            onPressed: () async {
              if (signupformkey.currentState.validate()) {
                signupformkey.currentState.save();
                if (!await user.SignUp(
                    _name, _email, _password.text, _contact, _address, _dob)) {
                  _key.currentState.showSnackBar(
                      SnackBar(content: Text("Sign up failed !")));
                } else {
                  Navigator.pop(context);
                }

                //  else {
                // //   Navigator.pushReplacement(
                // //       context,
                // //       MaterialPageRoute(
                // //           builder: (context) => ScreensController()));
                // // Navigator.pop(context);
                //  }

                //Navigator.pop(context);
                //SignUp(context);

                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
              }
            },
            child: Text("SIGN UP", style: TextStyle(fontSize: 16)),
            color: Colors.black,
            textColor: Color(0xffFFD700)));

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Color(0xffFFD700),
        brightness: Brightness.dark,
        title: Text(
          'Treasurex',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w900, fontSize: 25),
        ),
      ),
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Container(
              margin: EdgeInsets.only(right: 25, left: 25, top: 23),
              child: new ListView(children: <Widget>[
                //titletag,
                //SizedBox(height: 40.0),
                Form(
                    key: signupformkey,
                    child: Column(children: <Widget>[
                      namefield,
                      SizedBox(height: 20.0),
                      dobfield,
                      SizedBox(height: 20.0),
                      contactfield,
                      SizedBox(height: 20.0),
                      addressfield,
                      SizedBox(height: 20.0),
                      mailfield,
                      SizedBox(height: 20.0),
                      passfield,
                      SizedBox(height: 20.0),
                      repassfield,
                      SizedBox(height: 45.0)
                    ])),
                signupbtn,
                SizedBox(height: 20.0)
              ])),
    );
  }
}
