import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treasuex/Models/Authentication_provider.dart';
import 'package:treasuex/Models/Change_Password.dart';
import 'package:treasuex/Models/LoadingWidget.dart';
import 'package:treasuex/Other_Pages/Home.dart';
import 'package:treasuex/Other_Pages/Navigation.dart';
import 'package:treasuex/main.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var currentUser = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;

  FirebaseDatabase fb = FirebaseDatabase.instance;

  final nameformkey = GlobalKey<FormState>();
  final addressformkey = GlobalKey<FormState>();

  String _name, _address;

  // Stream<DocumentSnapshot> provideDocumentFieldStream() {
  //   //return fb.reference().child("users").child(currentUser.uid).onValue;
  //   return db.collection('users').doc(currentUser.uid).snapshots();
  // }

  Widget Change_name(bname) {
    return AlertDialog(
      title: Text(
        "Edit Name",
        style: TextStyle(
          //color: Color(0xffFFD700),
          fontWeight: FontWeight.w300,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: nameformkey,
            child: TextFormField(
              initialValue: bname,
              onSaved: (value) {
                _name = value;
              },
              validator: (value) {
                String pattern = r'(^[a-zA-Z ]*$)';
                RegExp regExp = new RegExp(pattern);

                if (value.isEmpty) {
                  return "Please enter your Name";
                } else if (!regExp.hasMatch(value)) {
                  return 'Enter Username with alphabets only ';
                }
                return null;
              },
              decoration: InputDecoration(
                  //  border: OutlineInputBorder(),
                  // hintStyle: TextStyle(color: Colors.grey),
                  // labelText: 'Name'
                  ),
            ),
          ),
          SizedBox(
            height: 50,
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
                        borderRadius: BorderRadius.all(Radius.circular(1))),
                  ),
                  onPressed: () {
                    if (nameformkey.currentState.validate()) {
                      nameformkey.currentState.save();
                      fb
                          .reference()
                          .child("users")
                          .child(currentUser.uid)
                          .update({"name": _name}).then(
                              (_) => print("name changed"));

                      // db.collection('users').doc(currentUser.uid).update(
                      //     {"name": _name}).then((_) => print("name changed"));

                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Widget Change_address(baddress) {
    return AlertDialog(
      title: Text(
        "Edit Address",
        style: TextStyle(
          //color: Color(0xffFFD700),
          fontWeight: FontWeight.w300,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: addressformkey,
            child: TextFormField(
              initialValue: baddress,
              onSaved: (value) {
                _address = value;
              },
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter valid Address";
                }
              },
              maxLines: 5,
              decoration: InputDecoration(
                  //  border: OutlineInputBorder(),
                  // hintStyle: TextStyle(color: Colors.grey),
                  // labelText: 'Name'
                  ),
            ),
          ),
          SizedBox(
            height: 50,
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
                        borderRadius: BorderRadius.all(Radius.circular(1))),
                  ),
                  onPressed: () {
                    if (addressformkey.currentState.validate()) {
                      addressformkey.currentState.save();
                      fb
                          .reference()
                          .child("users")
                          .child(currentUser.uid)
                          .update({"address": _address}).then(
                              (_) => print("address changed"));
                      // db
                      //     .collection('users')
                      //     .doc(currentUser.uid)
                      //     .update({"address": _address}).then(
                      //         (_) => print("address changed"));

                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final users = db.collection("users").doc(currentUser.uid).get();
    final user = Provider.of<UserProvider>(context);
    final user_ref = fb.reference().child("users");
    // Widget passbox(build) {
    //   showDialog(context: context, child: Dialog());
    // }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Navigationbar(),
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
          //  elevation: 0,
          brightness: Brightness.dark,
        ),
        body: Column(children: [
          StreamBuilder(
              stream:
                  fb.reference().child("users").child(currentUser.uid).onValue,
              //  provideDocumentFieldStream(),
              // ignore: missing_return
              builder: (BuildContext context,
                  // AsyncSnapshot<DocumentSnapshot>
                  snapshot) {
                // if (snapshot.data == null) return Loading();
                if (snapshot.hasData) {
                  //snapshot -> AsyncSnapshot of DocumentSnapshot
                  //snapshot.data -> DocumentSnapshot
                  //snapshot.data.data -> Map of fields that you need :)

                  //Map<String, dynamic> documentFields = snapshot.data.data();
                  //TODO Okay, now you can use documentFields (json) as needed

                  DataSnapshot datavalues = snapshot.data.snapshot;
                  Map<dynamic, dynamic> values = datavalues.value;

                  return Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'NAME :',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 7),
                                child: InkWell(
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Color(0xffFFD700),
                                  ),
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (_) =>
                                          Change_name(values['name']),
                                      barrierDismissible: false),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(values['name']),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ADDRESS :',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 7),
                                child: InkWell(
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Color(0xffFFD700),
                                  ),
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (_) =>
                                          Change_address(values['address']),
                                      barrierDismissible: false),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(values['address']),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'CONTACT :',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(values['contact']),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'EMAIL :',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(values['email']),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ));
                } else {
                  return LinearProgressIndicator(
                    color: Color(0xffFFD700),
                    backgroundColor: Colors.black,
                  );
                }

                // Container(
                //   height: 100,
                //   width: 100,
                //   child: Center(child: CircularProgressIndicator()));

                //--------------------------------------------------------------------------
                // return ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: snapshot.data.docs.length,
                //   padding: EdgeInsets.all(10.0),
                //   //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                //   itemBuilder: (context, index) {
                //     DocumentSnapshot product = snapshot.data.docs[index];
                //     return Single_Product(
                //       prod_id: product['productID'],
                //       prod_name: product['product_name'],
                //       prod_category: product['product_category'],
                //       prod_startdate: product['product_startdate'],
                //       prod_enddate: product['product_enddate'],
                //       prod_checkinamt: product['product_checkinamt'],
                //       prod_image: product['product_image'],
                //       prod_pictures: product['product_pictures'],
                //       prod_total_participants: product['total_participants'],
                //       prod_current_participants:
                //           product['current_participants'],
                //     );
                //   },
                // );
                //-------------------------------------------------------------------------------
              }),
          SizedBox(
            height: 30,
          ),
          ListTile(
              leading: Icon(Icons.password_sharp, color: Colors.blueGrey),
              title: Text("Change Password",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
              onTap: () => showDialog(
                  context: context,
                  builder: (_) => Change_password(),
                  barrierDismissible: false)

              //passbox();
              ),
          // SizedBox(
          //   height: 100,
          // ),
          ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.red)),
              onTap: () {
                //final user = Provider.of<UserProvider>(context);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreensController()),
                    (Route<dynamic> route) => false);
                user.LogOut();
              }
              // async {
              //   await FirebaseAuth.instance.signOut();
              //   Navigator.pushAndRemoveUntil(
              //       context,
              //       MaterialPageRoute(builder: (context) => Login()),
              //       (Route<dynamic> route) => false);
              //}
              ),
        ]));
  }
}
