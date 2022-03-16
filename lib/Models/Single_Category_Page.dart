import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:treasuex/Models/Product_Detail.dart';
import 'package:treasuex/Other_Pages/Navigation.dart';
import 'package:treasuex/main.dart';

class SingleCategory extends StatefulWidget {
  final single_category_id;
  final single_category_name;
  //final single_category_image;

  const SingleCategory({
    this.single_category_id,
    this.single_category_name,
    // this.single_category_image
  });

  @override
  _SingleCategoryState createState() => _SingleCategoryState();
}

class _SingleCategoryState extends State<SingleCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Treasuex',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 25),
            ),
          ),
          backgroundColor: Colors.black,
          //elevation: 0,
          brightness: Brightness.dark,
        ),

        //-------------------------------- B O D Y ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("products")
                .where("product_category",
                    isEqualTo: widget.single_category_name.toLowerCase())
                .orderBy("product_enddate", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return CircularProgressIndicator();
              return ListView.builder(
                //shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                padding: EdgeInsets.all(10.0),
                //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  DocumentSnapshot product = snapshot.data.docs[index];
                  return Single_Product(
                    prod_id: product['productID'],
                    prod_name: product['product_name'],
                    prod_category: product['product_category'],
                    prod_startdate: product['product_startdate'],
                    prod_enddate: product['product_enddate'],
                    prod_checkinamt: product['product_checkinamt'],
                    prod_image: product['product_image'],
                    prod_pictures: product['product_pictures'],
                    prod_total_participants: product['total_participants'],
                    prod_current_participants: product['current_participants'],
                  );
                },
              );
            }));
  }
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
      //elevation: 5,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey[300],
            // width: 1
          ),
          borderRadius: BorderRadius.circular(5)),

      shadowColor: Colors.white,
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
                      //  color: Colors.blue,
                      margin: EdgeInsets.fromLTRB(0, 0, 3, 10),
                      //padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                          SizedBox(height: 13),
                          Text(
                            "${afterformat}",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 4),
                          Text("CheckIn at  \u20B9 " +
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
