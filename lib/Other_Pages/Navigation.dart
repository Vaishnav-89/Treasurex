import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:treasuex/EntryandExit/Login.dart';
import 'package:treasuex/Models/Authentication_provider.dart';
import 'package:treasuex/Models/LoadingWidget.dart';
import 'package:treasuex/Models/Marking_products.dart';
import 'package:treasuex/Models/Single_Category_Page.dart';
import 'package:treasuex/main.dart';
// import 'package:treasuex/Navigation%20Drawer/Navigation_Main.dart';
// import 'package:treasuex/Navigation%20Drawer/Widget/navigation_drawer_widget.dart';

import '../Navbar_Pages/Account.dart';
import '../Navbar_Pages/Category.dart';
import '../Navbar_Pages/Marked_Events.dart';
import '../Navbar_Pages/Help.dart';
import '../Navbar_Pages/History.dart';
import 'Home.dart';
import '../Navbar_Pages/Settings.dart';
import '../Navbar_Pages/Winner.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({Key key}) : super(key: key);

  @override
  _NavigationbarState createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  //void nav_userinfo() {
  // var currentUser = FirebaseAuth.instance.currentUser;
  // final db = FirebaseFirestore.instance;

  // db.collection("users").doc(currentUser.uid).get().then((value) async {
  //   //if (mounted) {
  //   //setState(() {
  //   Username = value.data()["name"];
  //   UseremailID = value.data()["email"];
  //  });
  // }
  //   });
  // }

  // int currentpage = 1;
  //
  // Widget setcurrentpage() {
  //   nav_userinfo();
  //   switch (currentpage) {
  //     case 1:
  //       return Home();
  //       break;
  //     case 2:
  //       return Category();
  //       break;
  //     case 3:
  //       return Marked();
  //       break;
  //     case 4:
  //       return History();
  //       break;
  //     case 5:
  //       return Winner();
  //       break;
  //     case 6:
  //       return Account();
  //       break;
  //     // case 7:
  //     //   return Help();
  //     //   break;
  //     case 8:
  //       return settings();
  //       break;
  //   }
  // }

  // getcurrentpage(page) {
  //   setState(() {
  //     currentpage = page;
  //   });
  //   Navigator.pop(context);
  // }
  //
  String Username = "";
  String UseremailID = "";

  var currentUser = FirebaseAuth.instance.currentUser;
  //final db = FirebaseFirestore.instance;
  FirebaseDatabase fb = FirebaseDatabase.instance;
  // userinfo() {
  //   StreamBuilder(
  //     stream: db.collection("users").doc(currentUser.uid).snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.data) {
  //         return Loading();
  //       }
  //       var user_document = snapshot.data;
  //      setState(() {
  //         Username = user_document["name"];
  //         UseremailID = user_document["email"];
  //       });
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    //userinfo();
    //nav_userinfo();
    //
    // var currentUser = FirebaseAuth.instance.currentUser;
    // final db = FirebaseFirestore.instance;

    //----------------------------change it to stream so it will not load again and again ...but you have to exit the app..when u logout ------------------------------------

    // db.collection("users").doc(currentUser.uid).get().then((value) async {
    //   if (mounted) {
    //     setState(() {
    //       Username = value.data()["name"];
    //       UseremailID = value.data()["email"];
    //     });
    //   }
    // });

    fb
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DataSnapshot snapshot) {
      if (mounted) {
        setState(() {
          Username = snapshot.value["name"];
          UseremailID = snapshot.value["email"];
        });
      }
    });

    return

        // Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     'Treasuex',
        //     style: TextStyle(
        //         color: Colors.white, fontWeight: FontWeight.w900, fontSize: 25),
        //   ),
        //   backgroundColor: Colors.black,
        //   brightness: Brightness.dark,
        //   elevation: 30,
        //   shadowColor: Colors.red,
        // ),
        //
        // //drawer --------------------------------------------------------------------------
        //
        // drawer:
        Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(children: <Widget>[
          Container(
            color: Colors.white,
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  //child: Image.network(src),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 160,
                      child: Text(Username,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 160,
                      child: Text(UseremailID,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w300)),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
              color: Colors.black,
              padding: EdgeInsets.only(top: 20, bottom: 50),
              child: Column(children: <Widget>[
                ListTile(
                    leading: Icon(
                      Icons.home_filled,
                      color: Color(0xffFFD700),
                      //color: Colors.yellow
                    ),
                    // selected: currentpage == 1 ? true : false,
                    // selectedTileColor: Colors.yellow,
                    //selectedTileColor: Colors.yellow,
                    title: Text("Home",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreensController()),
                          (Route<dynamic> route) => false);
                      // getcurrentpage(1);
                    }),
                // ExpansionTile(
                //   collapsedIconColor: Colors.white,
                //   //collapsedBackgroundColor: Colors.white54,
                //   // backgroundColor: Colors.white54,
                //   // collapsedTextColor: Colors.white,
                //   title: Text("Category",
                //       style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w700,
                //           color: Colors.white)),
                //
                //   children: [
                //     ListTile(
                //       leading: Icon(Icons.arrow_right_alt,
                //           // color: Color(0xffFFD700),
                //           color: Colors.yellow[200]),
                //       title: Text("Appliances",
                //           style: TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[400])),
                //       onTap: () {
                //         Navigator.pop(context);
                //         return Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => SingleCategory(
                //                       single_category_id:
                //                           "ZZch60w1LSABZ07iNwhK",
                //                       single_category_name: "appliances",
                //                     )));
                //       },
                //     ),
                //     ListTile(
                //       leading: Icon(Icons.arrow_right_alt,
                //           color: Colors.yellow[200]),
                //       title: Text("Accessories",
                //           style: TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[400])),
                //       onTap: () {
                //         Navigator.pop(context);
                //         return Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => SingleCategory(
                //                       single_category_id:
                //                           "uPBioCAhUQ4Kf7FaDiGV",
                //                       single_category_name: "accessories",
                //                     )));
                //       },
                //     ),
                //     ListTile(
                //       leading: Icon(Icons.arrow_right_alt,
                //           color: Colors.yellow[200]),
                //       title: Text("Electronics",
                //           style: TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[400])),
                //       onTap: () {
                //         Navigator.pop(context);
                //         return Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => SingleCategory(
                //                       single_category_id:
                //                           "nCG1JvMLIkK1QLqgIcrl",
                //                       single_category_name: "electronics",
                //                     )));
                //       },
                //     ),
                //     ListTile(
                //       leading: Icon(Icons.arrow_right_alt,
                //           color: Colors.yellow[200]),
                //       title: Text("Furniture",
                //           style: TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[400])),
                //       onTap: () {
                //         Navigator.pop(context);
                //         return Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => SingleCategory(
                //                       single_category_id:
                //                           "JvZjBVdlQAYpanDaqabx",
                //                       single_category_name: "furniture",
                //                     )));
                //       },
                //     ),
                //     ListTile(
                //       leading: Icon(Icons.arrow_right_alt,
                //           color: Colors.yellow[200]),
                //       title: Text("Sports",
                //           style: TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[400])),
                //       onTap: () {
                //         Navigator.pop(context);
                //         return Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => SingleCategory(
                //                       single_category_id:
                //                           "P09XBSJ1ygXdDKfFe5Yp",
                //                       single_category_name: "Sports",
                //                     )));
                //       },
                //     ),
                //     ListTile(
                //       leading: Icon(Icons.arrow_right_alt,
                //           color: Colors.yellow[200]),
                //       title: Text("Others..",
                //           style: TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.grey[400])),
                //       onTap: () {
                //         Navigator.pop(context);
                //         return Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => SingleCategory(
                //                       single_category_id:
                //                           "AGp8Wy3AUSAGwuOOUrwW",
                //                       single_category_name: "others",
                //                     )));
                //       },
                //     )
                //   ],
                //   //contentPadding: EdgeInsets.symmetric(horizontal: 20),
                //   leading: Icon(
                //     Icons.category_outlined, color: Color(0xffFFD700),
                //     //color: Colors.yellow
                //   ),
                //   // selected: currentpage == 2 ? true : false,
                //   // selectedTileColor: Colors.yellow,
                //   // title: Text("Category",
                //   //     style: TextStyle(
                //   //         fontSize: 18,
                //   //         fontWeight: FontWeight.w700,
                //   //         color: Colors.white)),
                //   // onTap: () {
                //   //   // getcurrentpage(2);
                //   // }
                // ),
                ListTile(
                    leading: Icon(
                      Icons.bookmark_outline_sharp,
                      color: Color(0xffFFD700),
                      //color: Colors.yellow
                    ),
                    //  selected: currentpage == 3 ? true : false,
                    selectedTileColor: Colors.yellow,
                    title: Text("Marked Events",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      return Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Marked()));
                      //    getcurrentpage(3);
                    }),
                ListTile(
                    leading: Icon(
                      Icons.history, color: Color(0xffFFD700),
                      //color: Colors.yellow
                    ),
                    // selected: currentpage == 4 ? true : false,
                    selectedTileColor: Colors.yellow,
                    title: Text("History",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      return Navigator.push(context,
                          MaterialPageRoute(builder: (context) => History()));
                      //  getcurrentpage(4);
                    }),
                ListTile(
                    leading: Icon(
                      Icons.card_giftcard, color: Color(0xffFFD700),
                      //color: Colors.yellow
                    ),
                    //   selected: currentpage == 5 ? true : false,
                    selectedTileColor: Colors.yellow,
                    title: Text("Winner",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      return Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Winner()));
                      // getcurrentpage(5);
                    }),

                // ListTile(
                //     leading: Icon(Icons.help_outline_outlined,
                //         color: Colors.white),
                //     selected: currentpage == 7 ? true : false,
                //     selectedTileColor: Colors.yellow,
                //     title: Text("Help",
                //         style: TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.w700,
                //             color: Colors.white)),
                //     onTap: () {
                //       getcurrentpage(7);
                //     }),
                SizedBox(height: 10),
                Divider(color: Colors.white, indent: 30, endIndent: 30),
                SizedBox(height: 10),

                ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    //  selected: currentpage == 8 ? true : false,
                    selectedTileColor: Colors.yellow,
                    title: Text("Settings",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      return Navigator.push(context,
                          MaterialPageRoute(builder: (context) => settings()));
                      //  getcurrentpage(8);
                    }),
                ListTile(
                    leading: Icon(Icons.account_circle, color: Colors.white),
                    // selected: currentpage == 6 ? true : false,
                    //selectedTileColor: Colors.yellow,
                    title: Text("Account",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      return Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Account()));
                      //   getcurrentpage(6);
                    }),
                // ListTile(
                //     leading: Icon(Icons.logout, color: Colors.white),
                //     // selected: currentpage == 9 ? true : false,
                //     selectedTileColor: Colors.yellow,
                //     title: Text("Logout",
                //         style: TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.w700,
                //             color: Colors.white)),
                //     onTap: () {
                //       //final user = Provider.of<UserProvider>(context);
                //
                //       Navigator.pushAndRemoveUntil(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => ScreensController()),
                //           (Route<dynamic> route) => false);
                //       user.LogOut();
                //     }
                //     // async {
                //     //   await FirebaseAuth.instance.signOut();
                //     //   Navigator.pushAndRemoveUntil(
                //     //       context,
                //     //       MaterialPageRoute(builder: (context) => Login()),
                //     //       (Route<dynamic> route) => false);
                //     //}
                //     )
              ]))
        ]),
      ),
    );

    //drawer ends --------------------------------------------------------------------------

    //body: setcurrentpage(),
    //);
  }
}

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// class navimain extends StatefulWidget {
//   const navimain({Key key}) : super(key: key);
//
//   @override
//   _navimainState createState() => _navimainState();
// }
//
// class _navimainState extends State<navimain> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Treasuex',
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.w900, fontSize: 25),
//         ),
//         backgroundColor: Colors.black,
//         brightness: Brightness.dark,
//       ),
//       drawer: NavigationDrawerWidget(),
//       body: Navigation_Main(),
//     );
//   }
// }
