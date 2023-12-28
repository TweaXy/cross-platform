// import 'package:flutter/material.dart';

// class SideBarListTile extends StatelessWidget {
//   const SideBarListTile(
//       {super.key,
//       required this.icon,
//       required this.title,
//       required this.onTap, required this.selectedIndex,
//       required this.curindex});

//   final IconData icon;
//   final String title;
//     final int selectedIndex;
//   final int curindex;
//   final Function() onTap;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(
//           30,
//         ),
//       ),
//       leading: SizedBox(
//           height: double.infinity, //Align icon to center
//           child: Icon(icon, size: 27)),
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 20,
// fontWeight:
//               curindex == selectedIndex ? FontWeight.bold : FontWeight.normal),    
//       ),
//       titleAlignment: ListTileTitleAlignment.center,
//       iconColor: Colors.black,
//       textColor: Colors.black,
//       onTap: onTap,
//     );
//   }
// }
