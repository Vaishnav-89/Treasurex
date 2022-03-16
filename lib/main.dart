import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:treasuex/Other_Pages/Home.dart';
import 'package:treasuex/Models/Authentication_provider.dart';
import 'package:treasuex/Models/LoadingWidget.dart';

import 'package:treasuex/Models/Marking_products.dart';
// import 'package:treasuex/Navigation%20Drawer/Navigation_Main.dart';
// import 'package:treasuex/Navigation%20Drawer/Provider.dart';
import 'package:treasuex/Other_Pages/Navigation.dart';

import '../EntryandExit/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider.initialize()),
      ChangeNotifierProvider<Markevents>(create: (_) => Markevents()),
      // ChangeNotifierProvider<NavigationProvider>(
      //     create: (_) => NavigationProvider()),
    ],
    child: new MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      home: MyApp(),
      title: 'Treasurex ',
      // routes: {"/homepage": (context) => Home()}
    ),
  ));
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: ScreensController(),
        image: Image.asset('assets/images/splashlogo.png'),
        backgroundColor: Colors.white,
        useLoader: false,
        photoSize: 150);
  }
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
        return Login();
      case Status.Authenticating:
        return Loading();
      case Status.Authenticated:
        return Home();
      // // return Navigation_Main();
      // return navimain();
      default:
        return Login();
    }
  }
}

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         body: Center(
//             child: SplashScreen(
//                 seconds: 3,
//                 navigateAfterSeconds: new Homepage(),
//                 image: Image.asset('assets/images/splashlogo.png'),
//                 backgroundColor: Colors.white,
//                 useLoader: false,
//                 photoSize: MediaQuery.of(context).size.width / 2 - 50)));
//   }
// }
