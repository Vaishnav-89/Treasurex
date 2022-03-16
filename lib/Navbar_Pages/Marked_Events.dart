import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treasuex/Models/Marking_products.dart';
import 'package:treasuex/Models/Product_Detail.dart';
import 'package:treasuex/Other_Pages/Home.dart';
import 'package:treasuex/Other_Pages/Navigation.dart';
import 'package:treasuex/main.dart';
import '../Models/Home_Single_Product.dart';

class Marked extends StatefulWidget {
  const Marked({Key key}) : super(key: key);

  @override
  _MarkedState createState() => _MarkedState();
}

Single_Product obj = new Single_Product();
String user_ID = obj.prod_id;

// Future<dynamic> getuser() async {
//
//   await current_user.reload();
//   var newUser = FirebaseAuth.instance.currentUser;
// }

//final db = FirebaseFirestore.instance;

FirebaseDatabase fb = FirebaseDatabase.instance;

final current_user = FirebaseAuth.instance.currentUser;

List marked = List();

// final user_check = db
//     .collection("users")
//     .where(currentUser.uid, isEqualTo: user_check)
//     .get()
//     .then((value) => (value.data["uid"]));

class _MarkedState extends State<Marked> {
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
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 25),
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
                .child("marked_products")
                .onValue,

            // db
            //     .collection("users")
            //     .doc(current_user.uid)
            //     .collection("marked_products")
            //     .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                marked.clear();

                DataSnapshot datavalues = snapshot.data.snapshot;

                Map<dynamic, dynamic> values = datavalues.value;
                if (values == null) return SizedBox();
                //   CircularProgressIndicator(
                //   color: Color(0xffFFD700),
                //   backgroundColor: Colors.black,
                // );

                values.forEach((key, values) {
                  marked.add(values);
                });
                return ListView.builder(
                    itemCount: marked.length,
                    //Markevents.marklist.length,
                    itemBuilder: (context, index) {
                      // var item = Markevents.marklist[index];
                      //  DocumentSnapshot product = snapshot.data.docs[index];

                      return Single_Marked_Product(
                          prod_id: marked[index]['productID'],
                          prod_name: marked[index]['product_name'],
                          prod_category: marked[index]['product_category'],
                          prod_startdate: marked[index]['product_startdate'],
                          prod_enddate: marked[index]['product_enddate'],
                          prod_checkinamt: marked[index]['product_checkinamt'],
                          prod_image: marked[index]['product_image'],
                          prod_pictures: marked[index]['product_pictures'],
                          prod_total_participants: marked[index]
                              ['total_participants'],
                          prod_current_participants: marked[index]
                              ['current_participants']);
                    });
              } else {
                return LinearProgressIndicator(
                  color: Color(0xffFFD700),
                  backgroundColor: Colors.black,
                );
              }
            }),
      ),
      //),
    );
  }
}

class Single_Marked_Product extends StatelessWidget {
  // const Single_Marked_Product({Key key}) : super(key: key);

  final prod_id;
  final prod_name;
  final prod_category;
  final prod_startdate;
  final prod_enddate;
  final prod_checkinamt;
  final prod_image;
  final prod_pictures;
  final prod_total_participants;
  final prod_current_participants;

  Single_Marked_Product(
      {this.prod_id,
      this.prod_name,
      this.prod_category,
      this.prod_startdate,
      this.prod_enddate,
      this.prod_checkinamt,
      this.prod_image,
      this.prod_pictures,
      this.prod_total_participants,
      this.prod_current_participants});

//   @override
//   _Single_Marked_ProductState createState() => _Single_Marked_ProductState();
// }

//class _Single_Marked_ProductState extends State<Single_Marked_Product> {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: ListTile(
        contentPadding: EdgeInsets.all(7),
        leading: Image.network(prod_image, fit: BoxFit.fill
            //item.prod_image
            ),
        title: Text(prod_name
            //item.prod_name
            ),
        subtitle: Text(prod_enddate
            //item.prod_enddate
            ),
        trailing: GestureDetector(
            child: Icon(
              Icons.favorite,
              color: Colors.yellow,
            ),
            onTap: () async {
              //Markevents.removeFrommarklist(item);

              await fb
                  .reference()
                  .child("users")
                  .child(current_user.uid)
                  .child("marked_products")
                  .child(prod_id)
                  .remove();
              // db
              //     .collection("users")
              //     .doc(currentUser.uid)
              //     .collection("marked_products")
              //     .doc(prod_id)
              //     .delete();
            }),
        onTap: () {
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
                        product_current_participants: prod_current_participants,
                        product_total_participants: prod_total_participants,
                      )));
        },
      ),
    );
  }
}
