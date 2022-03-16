import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:treasuex/Models/Marking_products.dart';
import 'package:treasuex/Models/Product_Detail.dart';

import 'package:treasuex/Models/homecategory.dart';
import 'package:treasuex/Other_Pages/Navigation.dart';
// import 'package:treasuex/Navigation%20Drawer/Widget/navigation_drawer_widget.dart';
import 'package:treasuex/main.dart';

import '../Models/Home_Single_Product.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //
    // db.collection("products").get()
    // //Widget home_page_Carousel() {
    //
    //
    //
    List<NetworkImage> imagelist = new List<NetworkImage>();
    imagelist.add(NetworkImage(
        "https://images.unsplash.com/photo-1496150590317-f8d952453f93?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y3ljbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"));
    imagelist.add(NetworkImage(
      "https://images.unsplash.com/photo-1523170335258-f5ed11844a49?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1059&q=80",
    ));

    //print(imagelist);
    //}

    // Future getCarouselWidget() async {
    //   QuerySnapshot qn = await db.collection("products").get();
    //   return qn.docs;
    // }

    return Scaffold(
      drawer: Navigationbar(),
      appBar: AppBar(
        title: InkWell(
          // onTap: () {
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(builder: (context) => ScreensController()),
          //           (Route<dynamic> route) => false);
          // }
          // ,
          child: Text(
            'Treasurex',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 25),
          ),
        ),
        backgroundColor: Color(0xffFFD700),
        brightness: Brightness.dark,
        elevation: 30,
        shadowColor: Color(0xffFFD700),
      ),
      // drawer: NavigationDrawerWidget(),
      body:
          // Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(colors: [
          //     Colors.yellow[50],
          //     Colors.yellow[100],
          //     Colors.yellow[200],
          //     Colors.yellow[300],
          //     Colors.yellow[400],
          //     Colors.yellow,
          //     Colors.yellow[600]
          //   ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          //
          //   child:
          ListView(children: <Widget>[
        Container(
          //padding: EdgeInsets.symmetric(vertical: 0),
          margin: EdgeInsets.all(13.0),
          height: 200,

          // borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Carousel(
            borderRadius: true,
            //radius: Radius.circular(18),
            boxFit: BoxFit.cover,
            images: imagelist,
            dotSize: 4.0,
            dotBgColor: Colors.transparent,
            indicatorBgPadding: 15.0,
            animationCurve: Curves.fastOutSlowIn,
            //animationDuration: Duration(milliseconds: 500),
          ),
          // width: 80,
          //color: Colors.black12,
        ),
        SizedBox(height: 20),
        Divider(indent: 35, endIndent: 35, color: Color(0xffFFD700)),

        Container(
            margin: EdgeInsets.fromLTRB(20, 20, 10, 10),
            child: Row(
              children: [
                Text("Shop Here ! "),
                //Text("Shop by Category "),
                Icon(
                  Icons.double_arrow,
                )
              ],
            )),

        //  HomeCategory(),

        //-------------------

        Products()

        //-------------------
      ]),
      // ),
      /* body: ListView(children: <Widget>[
      // Container(child: Products())]*/
      /*_populateProducts()*/
    );
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //
  //   super.initState();
  // }

  //single product view

//-----------------------------------------------------------------

  // GridView _buildgridview() {
  //   return GridView.builder(
  //       padding: EdgeInsets.all(15.0),
  //       gridDelegate:
  //           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  //       itemCount: products_list.length,
  //       itemBuilder: (context, index) {
  //         var item = products_list[index];
  //         return Expanded(
  //             child: Consumer<Markevents>(
  //                 builder: (context, Markevents, child) => Card(
  //                     clipBehavior: Clip.antiAlias,
  //                     elevation: 4.0,
  //                     child: Stack(
  //                       fit: StackFit.loose,
  //                       alignment: Alignment.center,
  //                       children: <Widget>[
  //                         Column(children: <Widget>[
  //                           Image.network(item.prod_image, fit: BoxFit.cover),
  //                           Text(item.prod_name,
  //                               style: TextStyle(), textAlign: TextAlign.left),
  //                           Text(item.prod_date)
  //                         ]),
  //                         Padding(
  //                           padding: EdgeInsets.only(right: 8.0, bottom: 8.0),
  //                           child: Align(
  //                             alignment: Alignment.bottomRight,
  //                             child: GestureDetector(
  //                               child: new Icon(
  //                                   Markevents.marklist.contains(item)
  //                                       ? Icons.bookmark_sharp
  //                                       : Icons.bookmark_outline_sharp,
  //                                   color: Colors.yellow),
  //                               onTap: () {
  //                                 if (Markevents.marklist.contains(item)) {
  //                                   Markevents.removeFrommarklist(item);
  //                                 } else {
  //                                   Markevents.addTomarklist(item);
  //                                 }
  //                               },
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ))));
  //       });
  // }

//-----------------------------------------------------------------

  // //_populateProducts() {
  //   var List = <Product>[
  //     Product(
  //       pname: 'Cycle',
  //       pdate: "2021-05-18",
  //       pimage:
  //           'https://images.unsplash.com/photo-1496150590317-f8d952453f93?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y3ljbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //     ),
  //     Product(
  //         pname: 'Watch',
  //         pdate: "2021-05-20",
  //         pimage:
  //             "https://images.unsplash.com/photo-1523170335258-f5ed11844a49?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1059&q=80"),
  //     Product(
  //         pname: 'Headset',
  //         pdate: "2021-05-22",
  //         pimage:
  //             'https://images.unsplash.com/photo-1577174881658-0f30ed549adc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=662&q=80'),
  //     Product(
  //         pname: 'TV',
  //         pdate: "2021-05-24",
  //         pimage:
  //             'https://images.unsplash.com/photo-1567690187548-f07b1d7bf5a9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=676&q=80'),
  //   ];
  //
  //   // setState(() {
  //     // _products = List;
  //   // });
  //   //return ;
  // //}
}
