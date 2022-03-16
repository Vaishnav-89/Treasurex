import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:treasuex/Models/LoadingWidget.dart';

class Change_password extends StatefulWidget {
  const Change_password({Key, key}) : super(key: key);

  @override
  _Change_passwordState createState() => _Change_passwordState();
}

class _Change_passwordState extends State<Change_password> {
  var _current_password = TextEditingController();
  var _new_password = TextEditingController();
  var _renew_password = TextEditingController();

  var _resetpasskey = GlobalKey<FormState>();

  bool CheckCurrentPasswordValid = true;

  bool isHidden_1 = true;
  bool isHidden_2 = true;
  void togglePasswordVisibility_1() => setState(() => isHidden_1 = !isHidden_1);
  void togglePasswordVisibility_2() => setState(() => isHidden_2 = !isHidden_2);

  Future<bool> validateCurrentPassword(String Cpassword) async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseuser.email, password: Cpassword);

    try {
      var authResult =
          await firebaseuser.reauthenticateWithCredential(authCredentials);
      return authResult != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> UpdateNewPassword(String Newpassword) async {
    var firebaseuser = await FirebaseAuth.instance.currentUser;
    firebaseuser.updatePassword(Newpassword);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(
          "Reset Password",
          style: TextStyle(
            //color: Color(0xffFFD700),
            fontWeight: FontWeight.w300,
          ),
        ),
        content: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _resetpasskey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  obscureText: isHidden_1,
                  controller: _current_password,

                  // onSaved: (value) {
                  //   _current_password = value.trim();
                  // },
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return "Please enter Password";
                  //   } else if (value.length < 6) {
                  //     return "Password has to be at least 6 characters long";
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                      //border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: 'Enter Current Password',
                      suffixIcon: IconButton(
                        icon: isHidden_1
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: togglePasswordVisibility_1,
                      ),
                      errorText: CheckCurrentPasswordValid
                          ? null
                          : "Please check your given password"),
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _new_password,
                  // onSaved: (value) {
                  //   _new_password = value.trim();
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
                      //border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: 'Enter New Password'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  obscureText: isHidden_2,
                  controller: _renew_password,
                  // onSaved: (value) {
                  //   _renew_password = value.trim();
                  // },
                  validator: (value) {
                    return value == _new_password.text
                        ? null
                        : "Please validate your entered password";
                    // if (value.isEmpty) {
                    //   return "Please enter Password";
                    // } else if (value.length < 6) {
                    //   return "Password has to be at least 6 characters long";
                    // }
                    // return null;
                  },
                  decoration: InputDecoration(
                      //border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: isHidden_2
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: togglePasswordVisibility_2,
                      ),
                      labelText: 'Re-Enter Password'),
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Color(0xffFFD700),
                        ),
                        onTap: () => Navigator.pop(context)),
                    ElevatedButton(
                        child: Text("Save",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xffFFD700),
                            ),
                            textAlign: TextAlign.center),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          //shadowColor: btntxtclr,
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1))),
                        ),
                        onPressed: () async {
                          CheckCurrentPasswordValid =
                              await validateCurrentPassword(
                                  _current_password.text);

                          setState(() {});

                          if (_resetpasskey.currentState.validate() &&
                              CheckCurrentPasswordValid) {
                            UpdateNewPassword(_renew_password.text);
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: "Password has been changed Successfully !",
                                toastLength: Toast.LENGTH_LONG);
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
