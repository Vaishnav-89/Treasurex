import 'package:flutter/material.dart';
import 'package:treasuex/Other_Pages/Home.dart';
import 'package:treasuex/Other_Pages/Navigation.dart';
import 'package:treasuex/main.dart';

class settings extends StatefulWidget {
  const settings({Key key}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
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
        body: Text('Settings'));
  }
}
