import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:intl/intl.dart';
import 'package:treasuex/Models/Marking_products.dart';
import 'package:treasuex/Models/Product_Detail.dart';

// var products_list = [
//   {
//     "p_id": 1,
//     "p_name": 'Cycle',
//     "p_startdate": "2021-05-22",
//     "p_enddate": "2021-05-23",
//     "p_checkinamt": "30,000",
//     "p_image":
//         'https://images.unsplash.com/photo-1496150590317-f8d952453f93?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y3ljbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
//     "p_pictures":
//         "https://images.unsplash.com/photo-1618761979759-949464b5da07?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzZ8fGJ5Y3ljbGUlMjBwYXJ0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1525104325683-eb7d21279760?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1055&q=80,https://images.unsplash.com/photo-1617307326208-8cbd186cb388?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTE1fHxieWN5Y2xlJTIwcGFydHN8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1617307327024-14c0a02125fd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2089&q=80"
//   },
//   {
//     "p_id": 2,
//     "p_name": 'Watch',
//     "p_startdate": "2021-05-13",
//     "p_enddate": "2021-05-20",
//     "p_checkinamt": "20,000",
//     "p_image":
//         "https://images.unsplash.com/photo-1523170335258-f5ed11844a49?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1059&q=80",
//     "p_pictures":
//         "https://images.unsplash.com/photo-1618761979759-949464b5da07?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzZ8fGJ5Y3ljbGUlMjBwYXJ0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1525104325683-eb7d21279760?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1055&q=80,https://images.unsplash.com/photo-1617307326208-8cbd186cb388?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTE1fHxieWN5Y2xlJTIwcGFydHN8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1617307327024-14c0a02125fd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2089&q=80"
//   },
//   {
//     "p_id": 3,
//     "p_name": 'Headset',
//     "p_startdate": "2021-05-22",
//     "p_enddate": "2021-05-25",
//     "p_checkinamt": "15,000",
//     "p_image":
//         'https://images.unsplash.com/photo-1577174881658-0f30ed549adc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=662&q=80',
//     "p_pictures":
//         "https://images.unsplash.com/photo-1618761979759-949464b5da07?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzZ8fGJ5Y3ljbGUlMjBwYXJ0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1525104325683-eb7d21279760?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1055&q=80,https://images.unsplash.com/photo-1617307326208-8cbd186cb388?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTE1fHxieWN5Y2xlJTIwcGFydHN8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1617307327024-14c0a02125fd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2089&q=80"
//   },
//   {
//     "p_id": 4,
//     "p_name": 'TV',
//     "p_startdate": "2021-05-18",
//     "p_enddate": "2021-05-24",
//     "p_checkinamt": "25,000",
//     "p_image":
//         'https://images.unsplash.com/photo-1567690187548-f07b1d7bf5a9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=676&q=80',
//     "p_pictures":
//         "https://images.unsplash.com/photo-1618761979759-949464b5da07?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzZ8fGJ5Y3ljbGUlMjBwYXJ0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1525104325683-eb7d21279760?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1055&q=80,https://images.unsplash.com/photo-1617307326208-8cbd186cb388?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTE1fHxieWN5Y2xlJTIwcGFydHN8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1617307327024-14c0a02125fd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2089&q=80"
//   },
//   {
//     "p_id": 5,
//     "p_name": 'Cycle 2',
//     "p_startdate": "2021-05-25",
//     "p_enddate": "2021-05-30",
//     "p_checkinamt": "30,000",
//     "p_image":
//         'https://images.unsplash.com/photo-1496150590317-f8d952453f93?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y3ljbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
//     "p_pictures":
//         "https://images.unsplash.com/photo-1618761979759-949464b5da07?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzZ8fGJ5Y3ljbGUlMjBwYXJ0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1525104325683-eb7d21279760?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1055&q=80,https://images.unsplash.com/photo-1617307326208-8cbd186cb388?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTE1fHxieWN5Y2xlJTIwcGFydHN8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1617307327024-14c0a02125fd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2089&q=80"
//   },
//   {
//     "p_id": 6,
//     "p_name": 'Watch 2',
//     "p_startdate": "2021-05-20",
//     "p_enddate": "2021-05-26",
//     "p_checkinamt": "20,000",
//     "p_image":
//         "https://images.unsplash.com/photo-1523170335258-f5ed11844a49?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1059&q=80",
//     "p_pictures":
//         "https://images.unsplash.com/photo-1618761979759-949464b5da07?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzZ8fGJ5Y3ljbGUlMjBwYXJ0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1525104325683-eb7d21279760?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1055&q=80,https://images.unsplash.com/photo-1617307326208-8cbd186cb388?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTE1fHxieWN5Y2xlJTIwcGFydHN8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1617307327024-14c0a02125fd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2089&q=80"
//   },
//   {
//     "p_id": 7,
//     "p_name": 'Headset 2',
//     "p_startdate": "2021-05-22",
//     "p_enddate": "2021-05-27",
//     "p_checkinamt": "15,000",
//     "p_image":
//         'https://images.unsplash.com/photo-1577174881658-0f30ed549adc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=662&q=80',
//     "p_pictures":
//         "https://images.unsplash.com/photo-1618761979759-949464b5da07?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzZ8fGJ5Y3ljbGUlMjBwYXJ0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1525104325683-eb7d21279760?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1055&q=80,https://images.unsplash.com/photo-1617307326208-8cbd186cb388?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTE1fHxieWN5Y2xlJTIwcGFydHN8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1617307327024-14c0a02125fd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2089&q=80"
//   },
//   {
//     "p_id": 8,
//     "p_name": 'TV 2',
//     "p_startdate": "2021-05-18",
//     "p_enddate": "2021-05-24",
//     "p_checkinamt": "25,000",
//     "p_image":
//         'https://images.unsplash.com/photo-1567690187548-f07b1d7bf5a9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=676&q=80',
//     "p_pictures":
//         "https://images.unsplash.com/photo-1618761979759-949464b5da07?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzZ8fGJ5Y3ljbGUlMjBwYXJ0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1525104325683-eb7d21279760?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1055&q=80,https://images.unsplash.com/photo-1617307326208-8cbd186cb388?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTE1fHxieWN5Y2xlJTIwcGFydHN8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60,https://images.unsplash.com/photo-1617307327024-14c0a02125fd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2089&q=80"
//   }
// ];

//===================================== Products List ===========================================================

class Products extends StatefulWidget {
  const Products({Key key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  FirebaseDatabase fb = FirebaseDatabase.instance;

  List products = List();

  @override
  Widget build(BuildContext context) {
    // this is single product grid view in the home page

    // List<String> getcategories() {
    //   db.collection("categories").doc("hfUNgdLPF2FIXX7wg4Is").get();
    // List<String> categories = [
    //   "Appliances",
    //   "Accessories",
    //   "Sports",
    //   "Electronics"
    // ];
    // print(categories);
    //   return categories;
    // }

    // FirebaseFirestore.instance
    //     .collection("categories")
    //     .doc("hfUNgdLPF2FIXX7wg4Is")
    //     .get()
    //     .then((value) {
    //   categories = List.from(value.data()['categories']);
    //   //     .forEach((element) {
    //   //   categories.add(element);
    //   // });
    // });

    // Widget cdet(ctag) {
    //   return Container(
    //     margin: EdgeInsets.symmetric(vertical: 20.0),
    //     //color: Colors.black12,
    //     child: Column(children: [
    //       Container(
    //           padding: EdgeInsets.fromLTRB(12, 10, 20, 10),
    //           alignment: Alignment.topLeft,
    //           child: Text(
    //             ctag,
    //             style: TextStyle(
    //               fontWeight: FontWeight.w400,
    //               color: Colors.redAccent[700],
    //               fontSize: 20,
    //             ),
    //           )),
    //       StreamBuilder(
    //           stream: FirebaseFirestore.instance
    //               .collection("products")
    //               .where("product_category", isEqualTo: ctag)
    //               .orderBy("product_enddate", descending: true)
    //               .snapshots(),
    //           builder: (context, snapshot) {
    //             if (snapshot.data == null) return CircularProgressIndicator();
    //             return ListView.builder(
    //               shrinkWrap: true,
    //               physics: NeverScrollableScrollPhysics(),
    //               itemCount: snapshot.data.docs.length,
    //               padding: EdgeInsets.all(10.0),
    //               //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //               itemBuilder: (context, index) {
    //                 DocumentSnapshot product = snapshot.data.docs[index];
    //                 return Single_Product(
    //                   prod_id: product['productID'],
    //                   prod_name: product['product_name'],
    //                   prod_category: product['product_category'],
    //                   prod_startdate: product['product_startdate'],
    //                   prod_enddate: product['product_enddate'],
    //                   prod_checkinamt: product['product_checkinamt'],
    //                   prod_image: product['product_image'],
    //                   prod_pictures: product['product_pictures'],
    //                   prod_total_participants: product['total_participants'],
    //                   prod_current_participants:
    //                       product['current_participants'],
    //                 );
    //               },
    //             );
    //           }),
    //     ]),
    //   );
    // }

    final products_ref = fb.reference().child("products");

    return
        // Column(
        // children: categories.map<Widget>((ctag) => cdet(ctag)).toList()

        StreamBuilder(
            stream: products_ref.onValue,
            // FirebaseFirestore.instance
            //     .collection("products")
            //     // .where("product_category", isEqualTo: "appliances")
            //     .orderBy("product_enddate", descending: true)
            //     .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Container(
                    height: 100,
                    width: 100,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Color(0xffFFD700),
                      // backgroundColor: Colors.black,
                    )));
              products.clear();
              DataSnapshot datavalues = snapshot.data.snapshot;
              Map<dynamic, dynamic> values = datavalues.value;
              values.forEach((key, values) {
                products.add(values);
              });
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                //itemCount: snapshot.data.docs.length,
                itemCount: products.length,
                padding: EdgeInsets.all(10.0),
                //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  //DocumentSnapshot product = snapshot.data.snapshot[index];
                  return Single_Product(
                    prod_id: products[index]['productID'],
                    prod_name: products[index]['product_name'],
                    prod_category: products[index]['product_category'],
                    prod_startdate: products[index]['product_startdate'],
                    prod_enddate: products[index]['product_enddate'],
                    prod_checkinamt: products[index]['product_checkinamt'],
                    prod_image: products[index]['product_image'],
                    prod_pictures: products[index]['product_pictures'],
                    prod_total_participants: products[index]
                        ['total_participants'],
                    prod_current_participants: products[index]
                        ['current_participants'],
                  );
                },
              );
            });

    // children: [
    //   Container(
    //     margin: EdgeInsets.symmetric(vertical: 20.0),
    //     //color: Colors.black12,
    //     child: Column(children: [
    //       Container(
    //           padding: EdgeInsets.fromLTRB(12, 10, 20, 10),
    //           alignment: Alignment.topLeft,
    //           child: Text(
    //             "Appliances ",
    //             style: TextStyle(
    //               fontWeight: FontWeight.w400,
    //               color: Colors.redAccent[700],
    //               fontSize: 20,
    //             ),
    //           )),
    //       StreamBuilder(
    //           stream: FirebaseFirestore.instance
    //               .collection("products")
    //              // .where("product_category", isEqualTo: "appliances")
    //               .orderBy("product_enddate", descending: true)
    //               .snapshots(),
    //           builder: (context, snapshot) {
    //             if (snapshot.data == null) return CircularProgressIndicator();
    //             return ListView.builder(
    //               shrinkWrap: true,
    //               physics: NeverScrollableScrollPhysics(),
    //               itemCount: snapshot.data.docs.length,
    //               padding: EdgeInsets.all(10.0),
    //               //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //               itemBuilder: (context, index) {
    //                 DocumentSnapshot product = snapshot.data.docs[index];
    //                 return Single_Product(
    //                   prod_id: product['productID'],
    //                   prod_name: product['product_name'],
    //                   prod_category: product['product_category'],
    //                   prod_startdate: product['product_startdate'],
    //                   prod_enddate: product['product_enddate'],
    //                   prod_checkinamt: product['product_checkinamt'],
    //                   prod_image: product['product_image'],
    //                   prod_pictures: product['product_pictures'],
    //                   prod_total_participants: product['total_participants'],
    //                   prod_current_participants:
    //                       product['current_participants'],
    //                 );
    //               },
    //             );
    //           }),
    //     ]),
    //   ),
    //
    //   //------------------------------------------------------------------------------
    //   // SizedBox(height: 5),
    //
    //   Container(
    //     margin: EdgeInsets.symmetric(vertical: 20.0),
    //     // color: Colors.white,
    //     child: Column(children: [
    //       Container(
    //           padding: EdgeInsets.fromLTRB(12, 10, 20, 10),
    //           alignment: Alignment.topLeft,
    //           child: Text(
    //             "Accessories ",
    //             style: TextStyle(
    //               fontWeight: FontWeight.w400,
    //               color: Colors.redAccent[700],
    //               fontSize: 20,
    //             ),
    //           )),
    //       StreamBuilder(
    //           stream: FirebaseFirestore.instance
    //               .collection("products")
    //               .where("product_category", isEqualTo: "accessories")
    //               .orderBy("product_enddate", descending: true)
    //               .snapshots(),
    //           builder: (context, snapshot) {
    //             if (snapshot.data == null) return CircularProgressIndicator();
    //             return ListView.builder(
    //               shrinkWrap: true,
    //               physics: NeverScrollableScrollPhysics(),
    //               itemCount: snapshot.data.docs.length,
    //               padding: EdgeInsets.all(10.0),
    //               //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //               itemBuilder: (context, index) {
    //                 DocumentSnapshot product = snapshot.data.docs[index];
    //                 return Single_Product(
    //                   prod_id: product['productID'],
    //                   prod_name: product['product_name'],
    //                   prod_category: product['product_category'],
    //                   prod_startdate: product['product_startdate'],
    //                   prod_enddate: product['product_enddate'],
    //                   prod_checkinamt: product['product_checkinamt'],
    //                   prod_image: product['product_image'],
    //                   prod_pictures: product['product_pictures'],
    //                   prod_total_participants: product['total_participants'],
    //                   prod_current_participants:
    //                       product['current_participants'],
    //                 );
    //               },
    //             );
    //           }),
    //     ]),
    //   ),
    //
    //   //------------------------------------------------------------------------------
    //   // SizedBox(height: 5),
    //
    //   Container(
    //     margin: EdgeInsets.symmetric(vertical: 20.0),
    //     //color: Colors.white,
    //     child: Column(children: [
    //       Container(
    //           padding: EdgeInsets.fromLTRB(12, 10, 20, 10),
    //           alignment: Alignment.topLeft,
    //           child: Text(
    //             "Sports ",
    //             style: TextStyle(
    //               fontWeight: FontWeight.w400,
    //               color: Colors.redAccent[700],
    //               fontSize: 20,
    //             ),
    //           )),
    //       StreamBuilder(
    //           stream: FirebaseFirestore.instance
    //               .collection("products")
    //               .where("product_category", isEqualTo: "sports")
    //               .orderBy("product_enddate", descending: true)
    //               .snapshots(),
    //           builder: (context, snapshot) {
    //             if (snapshot.data == null) return CircularProgressIndicator();
    //             return ListView.builder(
    //               shrinkWrap: true,
    //               physics: NeverScrollableScrollPhysics(),
    //               itemCount: snapshot.data.docs.length,
    //               padding: EdgeInsets.all(10.0),
    //               //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //               itemBuilder: (context, index) {
    //                 DocumentSnapshot product = snapshot.data.docs[index];
    //                 return Single_Product(
    //                   prod_id: product['productID'],
    //                   prod_name: product['product_name'],
    //                   prod_category: product['product_category'],
    //                   prod_startdate: product['product_startdate'],
    //                   prod_enddate: product['product_enddate'],
    //                   prod_checkinamt: product['product_checkinamt'],
    //                   prod_image: product['product_image'],
    //                   prod_pictures: product['product_pictures'],
    //                   prod_total_participants: product['total_participants'],
    //                   prod_current_participants:
    //                       product['current_participants'],
    //                 );
    //               },
    //             );
    //           }),
    //     ]),
    //   ),
    //
    //   //------------------------------------------------------------------------------
    //   // SizedBox(height: 5),
    //
    //   Container(
    //     margin: EdgeInsets.symmetric(vertical: 20.0),
    //     //color: Colors.white,
    //     child: Column(children: [
    //       Container(
    //           padding: EdgeInsets.fromLTRB(12, 10, 20, 10),
    //           alignment: Alignment.topLeft,
    //           child: Text(
    //             "Electronics ",
    //             style: TextStyle(
    //               fontWeight: FontWeight.w400,
    //               color: Colors.redAccent[700],
    //               fontSize: 20,
    //             ),
    //           )),
    //       StreamBuilder(
    //           stream: FirebaseFirestore.instance
    //               .collection("products")
    //               .where("product_category", isEqualTo: "electronics")
    //               .orderBy("product_enddate", descending: true)
    //               .snapshots(),
    //           builder: (context, snapshot) {
    //             if (snapshot.data == null) return CircularProgressIndicator();
    //             return ListView.builder(
    //               shrinkWrap: true,
    //               physics: NeverScrollableScrollPhysics(),
    //               itemCount: snapshot.data.docs.length,
    //               padding: EdgeInsets.all(10.0),
    //               //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //               itemBuilder: (context, index) {
    //                 DocumentSnapshot product = snapshot.data.docs[index];
    //                 return Single_Product(
    //                   prod_id: product['productID'],
    //                   prod_name: product['product_name'],
    //                   prod_category: product['product_category'],
    //                   prod_startdate: product['product_startdate'],
    //                   prod_enddate: product['product_enddate'],
    //                   prod_checkinamt: product['product_checkinamt'],
    //                   prod_image: product['product_image'],
    //                   prod_pictures: product['product_pictures'],
    //                   prod_total_participants: product['total_participants'],
    //                   prod_current_participants:
    //                       product['current_participants'],
    //                 );
    //               },
    //             );
    //           }),
    //     ]),
    //   ),
    // ],
    //);
  }
}

//===================================== Single Product class  ===========================================================

class Single_Product extends StatefulWidget {
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

  Single_Product(
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

  @override
  _Single_ProductState createState() => _Single_ProductState();
}

class _Single_ProductState extends State<Single_Product> {
  @override
  Widget build(BuildContext context) {
    DateTime givendate = DateTime.parse(widget.prod_enddate);
    String afterformat = DateFormat('dd-MM-yyyy').format(givendate);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey[300],
            // width: 1
          ),
          borderRadius: BorderRadius.circular(5)),

      shadowColor: Color(0xffFFD700),
      margin: EdgeInsets.symmetric(vertical: 3),
      //margin: Radius.circular(10),
      //   child: Hero(
      // tag: prod_name,
      child: Material(
          //borderRadius: BorderRadius.all(Radius.circular(10)),
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetails(
                            //passing value ofthe products to product detail page
                            product_detail_id: widget.prod_id,
                            product_detail_name: widget.prod_name,
                            product_detail_category: widget.prod_category,
                            product_detail_startdate: widget.prod_startdate,
                            product_detail_enddate: widget.prod_enddate,
                            product_detail_checkinamt: widget.prod_checkinamt,
                            product_detail_image: widget.prod_image,
                            product_detail_pictures: widget.prod_pictures,
                            product_total_participants:
                                widget.prod_total_participants,
                            product_current_participants:
                                widget.prod_current_participants)));
              },
              child: Row(
                children: [
                  Container(
                      //padding: EdgeInsets.all(5),
                      height: 150,
                      width: 100,
                      color: Colors.grey[200],
                      child: Image.network(
                        widget.prod_image,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(width: 10),
                  Container(
                      // height: 150,
                      //padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      margin: EdgeInsets.fromLTRB(0, 7, 3, 7),
                      //color: Colors.black54,
                      //height: 42,
                      //width: 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Align(
                          //alignment: Alignment.centerLeft,
                          //  child:
                          Container(
                            width: 200,
                            child: Text(
                              widget.prod_name,

                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              //textAlign: TextAlign.left,
                            ),
                          ),
                          //),
                          SizedBox(height: 4),
                          Text(
                            "${afterformat}",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 4),
                          Text("JOIN at  \u20B9 " +
                              widget.prod_checkinamt.toString()),
                          SizedBox(height: 20),
                          Text(
                              (widget.prod_total_participants -
                                          widget.prod_current_participants) ==
                                      0
                                  ? "Event Full !"
                                  : "Participants Left -  ${widget.prod_total_participants - widget.prod_current_participants}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300))
                        ],
                      )),
                ],
              ))),

      // ) // this for hero tag
    );
  }
}
