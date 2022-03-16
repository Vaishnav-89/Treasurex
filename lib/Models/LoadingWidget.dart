import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    //);
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Expanded(
//           child: Container(
//         color: Colors.white,
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       )),
//     );
//   }
// }
