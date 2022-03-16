import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:treasuex/EntryandExit/Signup.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  User get user => _user;
  // FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseDatabase fb = FirebaseDatabase.instance;

  //UserServices _userServices = UserServices();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> LogIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      // Fluttertoast.showToast(
      //     msg: "ERROR: " + e.toString(), toastLength: Toast.LENGTH_SHORT);
      return false;
    }
  }

  Future<bool> SignUp(String name, String email, String password,
      String contact, String address, String dob) async {
    final user_ref = fb.reference().child("users");
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((currentUser) {
        user_ref.child(currentUser.user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'dob': dob,
          'contact': contact,
          'address': address,
        });

        // _db.collection('users').doc(currentUser.user.uid).set({
        //   'uid': user.uid,
        //   'name': name,
        //   'email': email,
        //   'dob': dob,
        //   'contact': contact,
        //   'address': address,
        // });
      });

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future LogOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
