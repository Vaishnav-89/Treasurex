import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:treasuex/Models/Product_Detail.dart';
import 'package:treasuex/Other_Pages/Navigation.dart';
import 'package:treasuex/main.dart';
import 'package:uuid/uuid.dart';

class CheckIn_Payment extends StatefulWidget {
  final product_detail_id;
  final product_detail_name;
  final product_detail_category;
  final product_detail_checkinamt;
  final product_detail_image;
  final product_current_participants;

  const CheckIn_Payment(
      this.product_detail_id,
      this.product_detail_name,
      this.product_detail_category,
      this.product_detail_checkinamt,
      this.product_detail_image,
      this.product_current_participants,
      {Key key})
      : super(key: key);

  @override
  _CheckIn_PaymentState createState() => _CheckIn_PaymentState();
}

class _CheckIn_PaymentState extends State<CheckIn_Payment> {
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;

  var uuid = Uuid();

  //final db = FirebaseFirestore.instance;

  FirebaseDatabase fb = FirebaseDatabase.instance;

  //-----------------------------------------------------------------------------------------------------------

  final user_ref = FirebaseDatabase.instance.reference().child("users");
  final product_ref = FirebaseDatabase.instance.reference().child("products");

  final current_user = FirebaseAuth.instance.currentUser;

  // user_contact_info() async {

  var user_contact_info = FirebaseDatabase.instance
      .reference()
      .child("users")
      .child(FirebaseAuth.instance.currentUser.uid)
      .child("contact")
      .once()
      .then((DataSnapshot snapshot) => snapshot.value);

  // FirebaseFirestore.instance
  //     .collection("users")
  //     .doc(FirebaseAuth.instance.currentUser.uid)
  //     .get()
  //     .then((value) => value.data()["contact"]);
  //   return user_contact_info;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ScreensController()),
                  (Route<dynamic> route) => false);
            },
            child: Text(
              'Treasurex',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 25),
            ),
          ),
          backgroundColor: Color(0xffFFD700),
          brightness: Brightness.dark,
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(children: [
            Row(
              children: [
                Container(
                    child: Text(
                  "Product ID              :  ",
                  style: TextStyle(fontWeight: FontWeight.w800),
                )),
                Text(widget.product_detail_id),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Product Name       :  ",
                    style: TextStyle(fontWeight: FontWeight.w800)),
                Container(width: 180, child: Text(widget.product_detail_name)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("Joining Amount    :  ",
                    style: TextStyle(fontWeight: FontWeight.w800)),
                Text("\u20B9 ${widget.product_detail_checkinamt}"),
              ],
            ),
            SizedBox(height: 40),
            RaisedButton(
              color: Colors.black,
              child: Text("Confirm Join In ?",
                  style: TextStyle(color: Colors.red)),
              onPressed: () {
                openCheckout();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => CheckIn_Payment()));
              },
            ),
          ]),
        ));
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_uWFfulytiWY5NT',
      //'order_id': uuid.v1(),
      'amount': "${await widget.product_detail_checkinamt.toString()}00",
      'name': 'Treasuex',
      'description': await widget.product_detail_name,
      'prefill': {
        'contact': await user_contact_info,
        'email': await current_user.email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    DateTime time = DateTime.now();

    String afterformat = DateFormat.yMMMEd().add_Hms().format(time);
    print(afterformat);

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);

    await product_ref.child(widget.product_detail_id).update(
        {"current_participants": widget.product_current_participants + 1});

    user_ref
        .child(current_user.uid)
        .child("Checked_In_Products")
        .child(widget.product_detail_id)
        .set({
      "productID": widget.product_detail_id,
      "product_name": widget.product_detail_name,
      "product_category": widget.product_detail_category,
      "product_image": widget.product_detail_image,
      "product_checkinamt": widget.product_detail_checkinamt,
      "paymentID": response.paymentId,
      //"orderID": response.orderId,
      "payment_time": afterformat,
      // "order_of_checkin": widget.product_current_participants
    });

    // db.collection("products").doc(widget.product_detail_id).update(
    //     {"current_participants": widget.product_current_participants + 1});

    // db
    //     .collection("users")
    //     .doc(current_user.uid)
    //     .collection("Checked_In_Products")
    //     .doc(widget.product_detail_id)
    //     .set({
    //   "productID": widget.product_detail_id,
    //   "product_name": widget.product_detail_name,
    //   "product_category": widget.product_detail_category,
    //   "product_image": widget.product_detail_image,
    //   "product_checkinamt": widget.product_detail_checkinamt,
    //   "paymentID": response.paymentId,
    //   //"orderID": response.orderId,
    //   "payment_time": afterformat,
    //   "order_of_checkin": widget.product_current_participants
    // });

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ScreensController()),
        (Route<dynamic> route) => false);
    // Navigator.pop(context);

    //Navigator.popUntil(context, (ProductDetails) => false);
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => ScreensController()),
    //     (Route<dynamic> route) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString(),
        toastLength: Toast.LENGTH_SHORT);
    print(response.code.toString() + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }
}
