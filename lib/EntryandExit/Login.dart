import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:treasuex/EntryandExit/Forgot_Password.dart';

import 'package:treasuex/EntryandExit/Signup.dart';
import 'package:provider/provider.dart';
import 'package:treasuex/Models/Authentication_provider.dart';
import 'package:treasuex/Models/LoadingWidget.dart';
import 'package:treasuex/Other_Pages/Navigation.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginformkey = GlobalKey<FormState>();
  // final _key = GlobalKey<ScaffoldState>();

  String _email, _password;

  bool isHidden = true;

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  // TextEditingController email = TextEditingController();
  // TextEditingController password = TextEditingController();

  // void LogIn(BuildContext context) async {
  //   await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: _email, password: _password)
  //       .catchError((onError) {
  //     print(onError);
  //   }).then((authUser) {
  //     if (authUser.user != null) {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => Navigationbar()));
  //     }
  //   });
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

    //--------------------email field--------------------------------------------------------------------------------------------------------------------------------

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

        // if (value.isEmpty) {
        //   return "Please enter a Email ID";
        // }
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

    //--------------------password field--------------------------------------------------------------------------------------------------------------------------------

    final passfield = TextFormField(
      obscureText: isHidden,
      // controller: password,
      onSaved: (value) {
        _password = value.trim();
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter Password";
        } else if (value.length < 6) {
          return "Password has to be at least 6 characters long";
        }
        return null;
      },
      decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Colors.black87,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon:
                isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: togglePasswordVisibility,
          ),
          labelText: 'Password'),
    );

    final forgotpass = Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Forget_pass()));
            },
            child: Text("Forgot Password ?"),
            textColor: Colors.black));

    //login button----------------------------------------------------------------------------------------------------------------------------------------------------------

    final loginbtn = Container(
        padding: EdgeInsets.only(left: 100, right: 100),
        width: 100,
        height: 50,
        child: RaisedButton(
            onPressed: () async {
              if (loginformkey.currentState.validate()) {
                loginformkey.currentState.save();
                if (!await user.LogIn(_email, _password)) {
                  //_key.currentState.
                  //.Toast(SnackBar(content: Text("Log In Failed !")));
                  Fluttertoast.showToast(
                      msg: "ERROR: Log In Failed ! ",
                      toastLength: Toast.LENGTH_SHORT);
                }
              }
              //LogIn(context);
            },
            child: Text("LOGIN", style: TextStyle(fontSize: 16)),
            color: Colors.black,
            textColor: Color(0xffFFD700)));

    final signuptxt = Text("doesn't have an account ?",
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700));

    //signup button----------------------------------------------------------------------------------------------------------------------------------------------------------

    final signupbtn = Container(
      child: FlatButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Signup()));
          },
          textColor: Colors.black,
          child: Text("SignUp !",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17))),
    );

    //----------------------------------------------------------------------------------------------------------------------------------------------------------

    return new Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Color(0xffFFD700),
        brightness: Brightness.dark,
        title: Text(
          'Treasurex',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w900, fontSize: 25),
        ),
      ),
      // appBar: new AppBar(
      //     backgroundColor: Colors.white,
      //     shadowColor: no,
      //     title: new Text("Treasuex"),
      //     automaticallyImplyLeading: false),
      //key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Container(
              margin: EdgeInsets.only(right: 25, left: 25, top: 23),
              //child: SingleChildScrollView(
              child: new ListView(
                children: <Widget>[
                  //titletag,
                  SizedBox(height: 130.0),
                  Form(
                      key: loginformkey,
                      child: Column(children: <Widget>[
                        emailfield,
                        SizedBox(height: 20.0),
                        passfield
                      ])),
                  SizedBox(height: 25.0),
                  forgotpass,
                  SizedBox(height: 10.0),
                  loginbtn,
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[signuptxt, signupbtn],
                  ),
                ],
              ),
              //)
            ),
    );
  }
}
