// import 'package:flutter/material.dart';
//
// class MaterialListTile extends StatelessWidget {
//   final String title ;
//   final Color color ;
//   const MaterialListTile({super.key ,
//     required this.title,
//     this.color=Colors.blueGrey,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return  Material(
//       elevation: 5.0,
//       shadowColor: color,
//       child: ListTile(
//         leading: const Icon(Icons.info),
//         title: const Text(
//           'About Us',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         onTap: () {
//         },
//         trailing: const Icon(Icons.arrow_forward_ios),
//       ),
//     );
//   }
// }