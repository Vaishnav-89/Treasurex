import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:treasuex/Models/Home_Single_Product.dart';

class Markevents extends ChangeNotifier {
  List<Single_Product> marklist = [];

  addTomarklist(item) {
    marklist.add(item);
    notifyListeners();
  }

  removeFrommarklist(item) {
    marklist.remove(item);
    notifyListeners();
  }
}

var currentUser = FirebaseAuth.instance.currentUser;
final db = FirebaseFirestore.instance;

class MarkingProducts {
  Future<int> checking_markprods(product_detail_id) async {
    int mark;
    db
        .collection("users")
        .doc(currentUser.uid)
        .collection("marked_products")
        .doc(product_detail_id)
        .get()
        .then((value) => value.exists ? mark = 1 : mark = 0);
    return mark;
  }
}
