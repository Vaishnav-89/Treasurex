import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasuex/Models/Checked_In_Details.dart';
import 'package:treasuex/Models/Product_Detail.dart';
import 'package:treasuex/Other_Pages/Home.dart';
import 'package:treasuex/Other_Pages/Navigation.dart';
import 'package:treasuex/main.dart';

class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

final db = FirebaseFirestore.instance;

FirebaseDatabase fb = FirebaseDatabase.instance;
final current_user = FirebaseAuth.instance.currentUser;

List history = List();

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final user_ref = fb.reference().child("users");
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
          //elevation: 0,
          brightness: Brightness.dark,
        ),
        drawer: Navigationbar(),
        body:
            // Consumer<Markevents>(
            //   builder: (context, Markevents, child) =>

            Container(
          padding: EdgeInsets.all(10),
          child: StreamBuilder(
              stream: user_ref
                  .child(current_user.uid)
                  .child("Checked_In_Products")
                  .onValue,
              // db
              //     .collection("users")
              //     .doc(current_user.uid)
              //     .collection("Checked_In_Products")
              //     .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  history.clear();
                  DataSnapshot datavalues = snapshot.data.snapshot;
                  Map<dynamic, dynamic> values = datavalues.value;
                  if (values == null) return SizedBox();
                  values.forEach((key, values) {
                    history.add(values);
                  });
                  return ListView.builder(
                      itemCount: history.length,
                      //itemCount: snapshot.data.docs.length,
                      //Markevents.marklist.length,
                      itemBuilder: (context, index) {
                        // var item = Markevents.marklist[index];
                        //   DocumentSnapshot checkedin_product = snapshot.data.docs[index];

                        return Single_Checked_In_Products(
                            //checkedin_prod_id: checkedin_product["productID"],
                            checkedin_prod_id: history[index]["productID"],
                            checkedin_prod_name: history[index]['product_name'],
                            checkedin_prod_category: history[index]
                                ['product_category'],
                            checkedin_prod_checkinamt: history[index]
                                ['product_checkinamt'],
                            checkedin_payment_id: history[index]['paymentID'],
                            checkedin_payment_time: history[index]
                                ['payment_time'],
                            checkedin_prod_image: history[index]
                                ['product_image']);
                      });
                } else {
                  return LinearProgressIndicator(
                    color: Color(0xffFFD700),
                    backgroundColor: Colors.black,
                  );
                }
              }),
        )
        //),
        );
  }
}

//----------------------------------------------------------------------------------------------------------------------------

class Single_Checked_In_Products extends StatefulWidget {
  final checkedin_prod_id;
  final checkedin_prod_name;
  final checkedin_prod_category;
  final checkedin_prod_checkinamt;
  final checkedin_payment_id;
  final checkedin_payment_time;
  final checkedin_prod_image;

  // const
  Single_Checked_In_Products(
      {this.checkedin_prod_id,
      this.checkedin_prod_name,
      this.checkedin_prod_category,
      this.checkedin_prod_checkinamt,
      this.checkedin_prod_image,
      this.checkedin_payment_id,
      this.checkedin_payment_time});
  //,{Key key}) : super(key: key);

  @override
  _Single_Checked_In_ProductsState createState() =>
      _Single_Checked_In_ProductsState();
}

class _Single_Checked_In_ProductsState
    extends State<Single_Checked_In_Products> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: ListTile(
        //minVerticalPadding: 10,
        contentPadding: EdgeInsets.all(10),
        leading: Image.network(
          widget.checkedin_prod_image, fit: BoxFit.fill,
          //item.prod_image
        ),
        title: Text(widget.checkedin_prod_name
            //item.prod_name
            ),
        trailing: Icon(Icons.keyboard_arrow_right),
        //subtitle: Text(prod_enddate
        //item.prod_enddate
        //),
        // trailing: GestureDetector(
        //     child: Icon(
        //       Icons.favorite,
        //       color: Colors.yellow,
        //     ),
        //     onTap: () async {
        //       //Markevents.removeFrommarklist(item);
        //
        //       await db
        //           .collection("users")
        //           .doc(currentUser.uid)
        //           .collection("marked_products")
        //           .doc(prod_id)
        //           .delete();
        //     }),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckedIn_Details(
                        //passing value ofthe products to product detail page
                        checkedin_detail_prod_id: widget.checkedin_prod_id,
                        checkedin_detail_prod_name: widget.checkedin_prod_name,
                        checkedin_detail_prod_category:
                            widget.checkedin_prod_category,
                        // product_detail_startdate: prod_startdate,
                        // product_detail_enddate: prod_enddate,
                        checkedin_detail_prod_checkinamt:
                            widget.checkedin_prod_checkinamt,
                        checkedin_detail_payment_id:
                            widget.checkedin_payment_id,
                        checkedin_detail_payment_time:
                            widget.checkedin_payment_time,
                        checkedin_detail_prod_image:
                            widget.checkedin_prod_image,
                        // product_detail_pictures: prod_pictures,
                      )));
        },
      ),
    );
  }
}
