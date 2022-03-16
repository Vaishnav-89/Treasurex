import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:treasuex/Models/Product_Detail.dart';
import 'package:treasuex/Other_Pages/Navigation.dart';
import 'package:treasuex/main.dart';
import 'package:treasuex/main.dart';

class CheckedIn_Details extends StatefulWidget {
  final checkedin_detail_prod_id;
  final checkedin_detail_prod_name;
  final checkedin_detail_prod_category;
  final checkedin_detail_prod_checkinamt;
  final checkedin_detail_payment_id;
  final checkedin_detail_payment_time;
  final checkedin_detail_prod_image;

  const CheckedIn_Details({
    this.checkedin_detail_prod_id,
    this.checkedin_detail_prod_name,
    this.checkedin_detail_prod_category,
    this.checkedin_detail_prod_checkinamt,
    this.checkedin_detail_payment_id,
    this.checkedin_detail_payment_time,
    this.checkedin_detail_prod_image,
  }
      // {Key key})
      // : super(key: key
      );

  @override
  _CheckedIn_DetailsState createState() => _CheckedIn_DetailsState();
}

class _CheckedIn_DetailsState extends State<CheckedIn_Details> {
  // final db = FirebaseFirestore.instance;
  FirebaseDatabase fb = FirebaseDatabase.instance;

  final current_user = FirebaseAuth.instance.currentUser;

  var prod_id;

  var prod_name;

  var prod_category;
  var prod_startdate;

  var prod_checkinamt;

  var prod_enddate;
  var prod_image;

  var prod_current_participants;
  var prod_pictures;

  var prod_total_participants;

  @override
  Widget build(BuildContext context) {
    final user_ref = fb.reference().child("users");
    final products_ref = fb.reference().child("products");
    return Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              //Navigator.popUntil(context, ModalRoute.withName('/homepage'));
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
          elevation: 0,
          brightness: Brightness.dark,
        ),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.black,
          child: RaisedButton(
            color: Colors.black,
            child: Text(" Product Details ",
                style: TextStyle(color: Color(0xffFFD700))),
            onPressed: () async {
              await products_ref
                  .child(widget.checkedin_detail_prod_id)
                  .once()
                  .then((DataSnapshot snapshot) {
                // db
                // .collection("products")
                // .doc(widget.checkedin_detail_prod_id)
                // .get()
                // .then((product)
                // async {
                Map<dynamic, dynamic> product = snapshot.value;
                product.forEach((key, values) {
                  prod_id = product['productID'];
                  prod_name = product['product_name'];
                  prod_category = product['product_category'];
                  prod_startdate = product['product_startdate'];
                  prod_enddate = product['product_enddate'];
                  prod_checkinamt = product['product_checkinamt'];
                  prod_image = product['product_image'];
                  prod_pictures = product['product_pictures'];
                  prod_total_participants = product['total_participants'];
                  prod_current_participants = product['current_participants'];
                });

                // }
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetails(
                            //passing value ofthe products to product detail page
                            product_detail_id: prod_id,
                            product_detail_name: prod_name,
                            product_detail_category: prod_category,
                            product_detail_startdate: prod_startdate,
                            product_detail_enddate: prod_enddate,
                            product_detail_checkinamt: prod_checkinamt,
                            product_detail_image: prod_image,
                            product_detail_pictures: prod_pictures,
                            product_total_participants: prod_total_participants,
                            product_current_participants:
                                prod_current_participants,
                          )));
              //print(widget.prod_id+"-----------------------");
            },
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("JoinedIn Time          :  ",
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    Text("${widget.checkedin_detail_payment_time}"),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product Name          :  ",
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    Container(
                        width: 180,
                        child: Text(widget.checkedin_detail_prod_name)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("Product ID                 :  ",
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    Text(widget.checkedin_detail_prod_id),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("JoinedIn Amount     :  ",
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    Text("\u20B9 ${widget.checkedin_detail_prod_checkinamt}"),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("Payment ID               :  ",
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    Text(widget.checkedin_detail_payment_id),
                  ],
                ),
                //SizedBox(height: 15),
              ],
            )));
  }
}
