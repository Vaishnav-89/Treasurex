import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:treasuex/Models/Single_Category_Page.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({Key, key}) : super(key: key);

  @override
  _HomeCategoryState createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("categories")
            .orderBy("category_doc_id", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            padding: EdgeInsets.all(10.0),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              DocumentSnapshot category = snapshot.data.docs[index];
              return CategoryView(
                  category_id: category['category_doc_id'],
                  category_name: category['category_name'],
                  category_image: category['category_image']);
            },
          );
        });
  }
}

class CategoryView extends StatefulWidget {
  final category_id;
  final category_name;
  final category_image;

  CategoryView({this.category_id, this.category_name, this.category_image});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue,
      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
      // padding: new EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey[300],
              // width: 1
            ),
            borderRadius: BorderRadius.circular(5)),

        shadowColor: Colors.white,
        margin: EdgeInsets.all(5),
        //margin: Radius.circular(10),
        //   child: Hero(
        // tag: prod_name,
        child: Container(
            //height: 400,
            //borderRadius: BorderRadius.all(Radius.circular(10)),

            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SingleCategory(
                                single_category_id: widget.category_id,
                                single_category_name: widget.category_name,
                                //  single_category_image: widget.category_image
                                //             //passing value ofthe products to product detail page
                                //             product_detail_id: widget.prod_id,
                                //             product_detail_name: widget.prod_name,
                                //             product_detail_category: widget.prod_category,
                                //             product_detail_startdate: widget.prod_startdate,
                                //             product_detail_enddate: widget.prod_enddate,
                                //             product_detail_checkinamt: widget.prod_checkinamt,
                                //             product_detail_image: widget.prod_image,
                                //             product_detail_pictures: widget.prod_pictures,
                                //             product_total_participants:
                                //                 widget.prod_total_participants,
                                //             product_current_participants:
                                //                 widget.prod_current_participants
                              )));
                },
                child: Column(
                  children: [
                    Container(
                        //padding: EdgeInsets.all(5),
                        height: 100,
                        width: 120,
                        //color: Colors.grey[200],
                        child: Image.network(
                          widget.category_image,
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 10),
                    Container(child: Text(widget.category_name))
                  ],
                ))),

        // ) // this for hero tag
      ),
    );
  }
}
