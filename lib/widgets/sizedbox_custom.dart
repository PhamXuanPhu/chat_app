import 'package:flutter/material.dart';

Widget width10({double? value = 10}) => SizedBox(
      width: value,
    );

Widget height10({double? value = 10}) => SizedBox(
      height: value,
    );


// Widget iconButton() => ClipOval(
//       child: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//             color: Colors.grey.shade300,
//             borderRadius: BorderRadius.circular(10)),
//         child: IconButton(
//           splashColor: Colors.black,
//           icon: Icon(Icons.cancel_outlined,
//               color: Colors.grey.shade600, size: 20),
//           onPressed: () {},
//           padding: EdgeInsets.all(0),
//           splashRadius: 10,
//         ),
//       ),
//     );