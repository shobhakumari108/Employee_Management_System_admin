// import 'package:flutter/material.dart';

// AppBar buildAppBar(BuildContext context, String title) {
//   return AppBar(
//     leading: Icon(Icons.abc),
//     title: Text(title),
//     // elevation: 0,
//     backgroundColor: Color.fromARGB(255, 61, 124, 251),
//     actions: [
//       Row(
//         children: [
//           Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//                 // border: Border.all(),
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(20)),
//             child: IconButton(
//               icon: Icon(Icons.person),
//               onPressed: () {},
//             ),
//           ),
//           SizedBox(
//             width: 30,
//           ),
//         ],
//       ),
//     ],
//   );
// }

// // class CustomSearchDelegate extends SearchDelegate {
// //   @override
// //   List<Widget> buildActions(BuildContext context) {
// //     return [
// //       IconButton(
// //         icon: Icon(Icons.clear),
// //         onPressed: () {
// //           query = '';
// //         },
// //       ),
// //     ];
// //   }

// //   @override
// //   Widget buildLeading(BuildContext context) {
// //     return IconButton(
// //       icon: Icon(Icons.arrow_back),
// //       onPressed: () {
// //         close(context, null);
// //       },
// //     );
// //   }

// //   @override
// //   Widget buildResults(BuildContext context) {
// //     // Implement search results based on the query
// //     return Container(
// //       child: Center(
// //         child: Text('Search Results for "$query"'),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget buildSuggestions(BuildContext context) {
// //     // Implement search suggestions based on the query
// //     return Container(
// //       child: Center(
// //         child: Text('Search Suggestions for "$query"'),
// //       ),
// //     );
// //   }
// // }
