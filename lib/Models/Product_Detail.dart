import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:treasuex/DB_services/Payment_gateway.dart';
import 'package:treasuex/EntryandExit/Login.dart';
import 'package:treasuex/Models/LoadingWidget.dart';
import 'package:treasuex/Other_Pages/Home.dart';
import 'package:treasuex/Models/Checked_In_Details.dart';

import 'package:treasuex/Models/Marking_products.dart';
import 'package:treasuex/Other_Pages/Navigation.dart';
import 'package:treasuex/main.dart';

class ProductDetails extends StatefulWidget {
  //  const ProductDetails({Key key}) : super(key: key);
  final product_detail_id;
  final product_detail_name;
  final product_detail_category;
  final product_detail_startdate;
  final product_detail_enddate;
  final product_detail_checkinamt;
  final product_detail_image;
  final product_detail_pictures;
  final product_total_participants;
  final product_current_participants;

  ProductDetails(
      {this.product_detail_id,
      this.product_detail_name,
      this.product_detail_category,
      this.product_detail_startdate,
      this.product_detail_enddate,
      this.product_detail_checkinamt,
      this.product_detail_image,
      this.product_detail_pictures,
      this.product_total_participants,
      this.product_current_participants});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String CountTime = "Event Loading !";

  Timer _timer;
  String btnDisplay;
  bool res, mark_res;

  var current_user = FirebaseAuth.instance.currentUser;
  //final db = FirebaseFirestore.instance;
  FirebaseDatabase fb = FirebaseDatabase.instance;

  void isMarked() {
    // db
    //     .collection("users")
    //     .doc(current_user.uid)
    //     .collection("marked_products")
    //     .doc(widget.product_detail_id)
    //     .get()
    //     .then((value) {
    //   if (value.exists) {

    fb
        .reference()
        .child("users")
        .child(current_user.uid)
        .child("marked_products")
        .child(widget.product_detail_id)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        mark_res = true;
        print("present in the list");
        //return ans;
      } else {
        mark_res = false;
        print("not present in the list");
        // return ans;
      }
      print("${mark_res} - marked ");
    });
  }

  void check() {
    // db
    //     .collection("users")
    //     .doc(current_user.uid)
    //     .collection("Checked_In_Products")
    //     .doc(widget.product_detail_id)
    //     .get()
    //     .then((value) {
    //   if (value.exists) {

    fb
        .reference()
        .child("users")
        .child(current_user.uid)
        .child("Checked_In_Products")
        .child(widget.product_detail_id)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        res = true;
        print(" -- exists in history");
        //return ans;
      } else {
        res = false;
        print(" -- doesn't exsist in history");
        // return ans;
      }
      print(res);
      // if (ans == true) {
      //   return true;
      // } else {
      //   return false;
      // }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //check();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  DateTime toparsedate(String date) {
    DateTime givendate = DateTime.parse(date);
    return givendate;
    //String afterformat = DateFormat('dd-MM-yyyy').format(givendate);
  }

  String toformatedate(String date) {
    DateTime givendate = DateTime.parse(date);
    String afterformat = DateFormat('dd-MM-yyyy').format(givendate);
    return afterformat;
  }

  DateTime now = new DateTime.now();

  bool isAvailable(start, end) {
    if (now.isAfter(toparsedate(start)) && now.isBefore(toparsedate(end))) {
      if ((widget.product_total_participants -
              widget.product_current_participants) !=
          0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  int Cvalue;

  String btnvalue(start, end) {
    DateTime parsestart = toparsedate(start);
    DateTime parseend = toparsedate(end);

    bool initialval = isAvailable(start, end);
    if (initialval) {
      Cvalue = 1;
      return CountTime;
    } else {
      if (now.isBefore(parsestart)) {
        //Text("",style: TextStyle(color: Colors.yellow));
        Cvalue = 2;
        return "Event Starts on ${toformatedate(start)}";
      } else {
        Cvalue = 3;
        return CountTime;
      }
    }

    // bool isCheckedIn() {
    //   bool ans;
    //   // await
    //   db
    //       .collection("users")
    //       .doc(current_user.uid)
    //       .collection("Checked_In_Products")
    //       .doc(widget.product_detail_id)
    //       .get()
    //       .then((value) {
    //     if (value.exists) {
    //       ans = true;
    //       print("true---------------");
    //       //return ans;
    //     } else {
    //       ans = false;
    //       print("false---------------");
    //       // return ans;
    //     }
    //
    //     // if (ans == true) {
    //     //   return true;
    //     // } else {
    //     //   return false;
    //     // }
    //   });
    //   print(ans);
    //   return ans;
    // }
  }

  //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // DateTime givendate = DateTime.parse(widget.product_detail_enddate);
    // String afterformat = DateFormat('dd-MM-yyyy').format(givendate);

    // Future<bool> isMarked() async {
    //   bool ans;
    //   await db
    //       .collection("users")
    //       .doc(current_user.uid)
    //       .collection("marked_products")
    //       .doc(widget.product_detail_id)
    //       .get()
    //       .then((value) => (value.exists == null ? ans = false : ans = true));
    //   return ans;
    // }

    // Future<bool> ans = isMarked();

    //.then((DocumentSnapshot docssnap) {
    // if (!mark.exists || mark == null) {
    //   mark = true;
    // } else {
    //   mark = false;
    // }
    //});

    CountTime = CountDown().timeLeft(
        (toparsedate(widget.product_detail_enddate)),
        "Event Ended on ${toformatedate(widget.product_detail_enddate)}");

    btnDisplay = btnvalue(
        widget.product_detail_startdate, widget.product_detail_enddate);

    Color btntxtclr = Cvalue <= 1
        ? Colors.greenAccent
        : Cvalue == 2
            ? Colors.yellow
            : Colors.red;

    Icon btntxticon = Cvalue <= 1
        ? Icon(Icons.timer_outlined)
        : Cvalue == 2
            ? Icon(Icons.access_time_rounded)
            : Icon(Icons.timer_off_outlined);

    // Widget toMarkIcon() {
    //   return Icon(Icons.bookmark_outline_sharp, color: Colors.yellow);
    // }
    //
    // Widget MarkedIcon() {
    //   return Icon(Icons.bookmark_sharp, color: Colors.yellow);
    // }

    Widget MarkIconBtn() {
      isMarked();
      if (mark_res == null) {
        return Container(
          height: 25,
          width: 25,
          margin: EdgeInsets.only(right: 25.0),
          // margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            color: Colors.black,
          ),
        );
      }

      return Container(
        margin: EdgeInsets.only(right: 25.0),
        child: Icon(mark_res == false ? Icons.favorite_border : Icons.favorite,
            color: Colors.yellow, size: 27),
      );
    }

    Widget CheckInbtn(start, end) {
      check();
      if (res == null) {
        return SizedBox(width: 130);
      }

      if (res) {
        print("----- present in history -----");
        return Expanded(
            flex: 1,
            child: MaterialButton(
              child: Row(
                children: [
                  Text(" Joined  ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                          fontSize: 15)),
                  Icon(Icons.check_circle_rounded,
                      color: Colors.green, size: 20)
                ],
              ),
              //onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => CheckedIn_Details(
              //             // widget.product_detail_id,
              //             // widget.product_detail_name,
              //             // widget.product_detail_checkinamt,
              //             // widget.product_detail_image
              //             )));
              //},
            ));
      } else {
        if (isAvailable(start, end)) {
          return Expanded(
              flex: 1,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckIn_Payment(
                              widget.product_detail_id,
                              widget.product_detail_name,
                              widget.product_detail_category,
                              widget.product_detail_checkinamt,
                              widget.product_detail_image,
                              widget.product_current_participants)));
                },
                child: Text("Join In",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                        fontSize: 15)),
              ));
        } else {
          return SizedBox(
            width: 130,
          );
        }
      }
    }

    Widget CheckInpricedisplay(start, end) {
      if (isAvailable(start, end) && res == false) {
        return Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Join In at  \u20B9 ${widget.product_detail_checkinamt}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.yellow),
                //textAlign: TextAlign.center,
              ),
            ));
      } else {
        return SizedBox(
          height: 10,
        );
      }
    }

    // if (ans == null) {
    //   return Loading();
    // }

    //var item = widget.product_detail_id;
    // var btnDisplay;

    //--------------------------------------------------------------------------------------------------------------

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
        elevation: 3,
        // shadowColor: Colors.red,
      ),

      //product detail image screen -------------------------------- B O D Y -------------------------------------------------------

      body:
          //Container(
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(colors: [
          //   Colors.yellow[50],
          //   Colors.yellow[100],
          //   Colors.yellow[200],
          // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          // child:
          ListView(
        children: <Widget>[
          Container(
            height: 230,
            child: CarouselSlider(
              items: [
                Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image:
                                NetworkImage("${widget.product_detail_image}"),
                            fit: BoxFit.contain)))
              ],
              options: CarouselOptions(autoPlay: true, height: 200),
            ),
          ),

          // ---------------------------------------------  product name and timer -----------------------------------------------------------------------

          Container(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Column(
              children: [
                Row(children: [
                  // product name
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(widget.product_detail_name,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.black)),
                    ),
                  ),

                  //TODO: place the started date of the event
                ]),
                SizedBox(height: 10),
                //-----------------------------------------------------Countdown time an fav icon---------------------

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                          icon: btntxticon,
                          label: Text(btnDisplay,
                              style: TextStyle(
                                //fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: btntxtclr,
                              ),
                              textAlign: TextAlign.center),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shadowColor: btntxtclr,
                            shape: const BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          onPressed: () {
                            // if (isAvailable(widget.product_detail_startdate,
                            //     widget.product_detail_enddate)) {
                            //   setState(() {
                            //     if (Cvalue == 1) {
                            //     btnDisplay =
                            //         "Event Ends on ${toformatedate(widget.product_detail_enddate)}";
                            //     Cvalue = 0;
                            //     }
                            //   });
                            // }
                          }

                          // if (isAvailable(widget.product_detail_startdate,
                          //     widget.product_detail_enddate)) {
                          //   setState(() {
                          //     btnDisplay =
                          //         "Event Ends on ${toformatedate(widget.product_detail_enddate)}";
                          //   });
                          // } else {
                          //   setState(() {
                          //     btnDisplay = CountTime;
                          //   });
                          // }
                          ),
                      Container(
                        //margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: InkWell(
                            onTap: () {
                              if (mark_res == false) {
                                // db
                                //     .collection('users')
                                //     .doc(current_user.uid)
                                //     .collection('marked_products')
                                //     .doc(widget.product_detail_id)
                                //     .set({
                                //

                                fb
                                    .reference()
                                    .child("users")
                                    .child(current_user.uid)
                                    .child('marked_products')
                                    .child(widget.product_detail_id)
                                    .set({
                                  "productID": widget.product_detail_id,
                                  "product_name": widget.product_detail_name,
                                  "product_category":
                                      widget.product_detail_category,
                                  "product_startdate":
                                      widget.product_detail_startdate,
                                  "product_enddate":
                                      widget.product_detail_enddate,
                                  "product_image": widget.product_detail_image,
                                  "product_pictures":
                                      widget.product_detail_pictures,
                                  "product_checkinamt":
                                      widget.product_detail_checkinamt,
                                  "total_participants":
                                      widget.product_total_participants,
                                  "current_participants":
                                      widget.product_current_participants,
                                });
                              } else {
                                // db
                                //     .collection("users")
                                //     .doc(current_user.uid)
                                //     .collection("marked_products")
                                //     .doc(widget.product_detail_id)
                                //     .delete();

                                fb
                                    .reference()
                                    .child("users")
                                    .child(current_user.uid)
                                    .child("marked_products")
                                    .child(widget.product_detail_id)
                                    .remove();
                              }
                            },
                            child: MarkIconBtn()

                            //         .collection("users")
                            //         .doc(current_user.uid)
                            //         .collection("marked_products")
                            //         .doc(widget.product_detail_id)

                            // StreamBuilder(
                            //     stream: db
                            //         .collection("users")
                            //         .doc(current_user.uid)
                            //         .collection("marked_products")
                            //         .doc(widget.product_detail_id)
                            //         .snapshots(),
                            //     builder: (context, snapshot) {
                            //       if (snapshot.hasData) {
                            //         MarkedIcon();
                            //       } else {
                            //         toMarkIcon();
                            //         // return Icon(Icons.bookmark_outline_sharp,
                            //         //     color: Colors.yellow);
                            //       }
                            //     })

                            // new Icon(
                            //     //Icons.favorite_border,
                            //     // Markevents.marklist.contains( widget.)
                            //
                            //     isMarked() == false
                            //         ? Icons.favorite_border
                            //         : Icons.favorite,
                            //     color: Colors.yellow),
                            ),
                      ),
                    ]),

                //-------------------------------------------------------------------------

                SizedBox(height: 10),
                Text((widget.product_total_participants -
                            widget.product_current_participants) ==
                        0
                    ? "Event Full !"
                    : "Participants Left -  ${widget.product_total_participants - widget.product_current_participants}"),

                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),

                //-------------------------------------------------------------------------

                Container(
                  alignment: Alignment.topRight,
                  child: Cvalue <= 1 || Cvalue == 3
                      ? Text(
                          "Event Started on ${toformatedate(widget.product_detail_startdate)} ",
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        )
                      : null,
                ),

                //--------------------------------------------product detail contents ----------------------------------------------------------------------------------------
                SizedBox(height: 20),

                Container(
                    child: ListTile(
                  title: Text("Details :",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left),
                  subtitle: Text(
                      "\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem IpsumWhy do we use It is a ong established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose",
                      style: TextStyle(
                          //color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ))
              ],
            ),
          ),
        ],
      ),
      // ),

      //---------------------------------------bottom bar in product detail screen ---------------------------------------------------------------------------------------

      bottomNavigationBar: Container(
          height: 60,
          color: Colors.black,
          child: Row(
            children: <Widget>[
              // Expanded(
              //     flex: 1,
              //     child: InkWell(
              //         onTap: () {
              //           if (mark_res == false) {
              //             db
              //                 .collection('users')
              //                 .doc(current_user.uid)
              //                 .collection('marked_products')
              //                 .doc(widget.product_detail_id)
              //                 .set({
              //               "productID": widget.product_detail_id,
              //               "product_name": widget.product_detail_name,
              //               "product_category": widget.product_detail_category,
              //               "product_startdate":
              //                   widget.product_detail_startdate,
              //               "product_enddate": widget.product_detail_enddate,
              //               "product_image": widget.product_detail_image,
              //               "product_pictures": widget.product_detail_pictures,
              //               "product_checkinamt":
              //                   widget.product_detail_checkinamt,
              //               "total_participants":
              //                   widget.product_total_participants,
              //               "current_participants":
              //                   widget.product_current_participants,
              //             });
              //           } else {
              //             db
              //                 .collection("users")
              //                 .doc(current_user.uid)
              //                 .collection("marked_products")
              //                 .doc(widget.product_detail_id)
              //                 .delete();
              //           }
              //         },
              //         child: MarkIconBtn()
              //
              //         //         .collection("users")
              //         //         .doc(current_user.uid)
              //         //         .collection("marked_products")
              //         //         .doc(widget.product_detail_id)
              //
              //         // StreamBuilder(
              //         //     stream: db
              //         //         .collection("users")
              //         //         .doc(current_user.uid)
              //         //         .collection("marked_products")
              //         //         .doc(widget.product_detail_id)
              //         //         .snapshots(),
              //         //     builder: (context, snapshot) {
              //         //       if (snapshot.hasData) {
              //         //         MarkedIcon();
              //         //       } else {
              //         //         toMarkIcon();
              //         //         // return Icon(Icons.bookmark_outline_sharp,
              //         //         //     color: Colors.yellow);
              //         //       }
              //         //     })
              //
              //         // new Icon(
              //         //     //Icons.favorite_border,
              //         //     // Markevents.marklist.contains( widget.)
              //         //
              //         //     isMarked() == false
              //         //         ? Icons.favorite_border
              //         //         : Icons.favorite,
              //         //     color: Colors.yellow),
              //         )),
              // SizedBox(width: 6),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.product_detail_name,
                            style: TextStyle(
                                fontWeight:
                                    // res == true
                                    //     ?
                                    FontWeight.w400,
                                //     :
                                //FontWeight.normal,
                                color: Colors.white,
                                fontSize: 15

                                // fontSize: res == true ? 18 : 15
                                ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                            // textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      //SizedBox(height: 6),
                      CheckInpricedisplay(widget.product_detail_startdate,
                          widget.product_detail_enddate)
                    ],
                  )),
              CheckInbtn(widget.product_detail_startdate,
                  widget.product_detail_enddate)
            ],
          )),
    );
  }
}
