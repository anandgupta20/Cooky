// import 'package:cooky/ui_elements/drawer/AboutUs.dart';
// import 'package:cooky/ui_elements/drawer/TermAndcondi.dart';
// import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:cooky/scoped_models/mainmodel.dart';
// import 'package:share/share.dart';

// class HomeDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<MainModel>(
//         builder: (BuildContext context, Widget child, MainModel model) {
//       return Drawer(
//         child: ListView(
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.redAccent,
//               ),
//               child: Center(
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Text(
//                       "Welcome!",
//                       style: TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       model.authdata.email,
//                       style: TextStyle(fontSize: 16.0, color: Colors.white),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.share),
//               title: Text('Share App'),
//               onTap: () {
//                 Share.share("App Link");
//                 // Update the state of the app
//                 // ...
//                 // Then close the drawer
//                 Navigator.pop(context);
//               },
//             ),
//             Divider(height: 2),
//             ListTile(
//               leading: Icon(Icons.help_outline),
//               title: Text('About us'),
//               onTap: () {
//                 // Update the state of the app
//                 Navigator.push(context,
//                     new MaterialPageRoute(builder: (context) => new Aboutus()));
//                 // Then close the drawer
//                 // Navigator.pop(context);
//               },
//             ),
//             Divider(height: 2),
//             ListTile(
//               leading: Icon(Icons.library_books),
//               title: Text('Terms of use'),
//               onTap: () {
//                 // Update the state of the app
//                 Navigator.push(
//                     context,
//                     new MaterialPageRoute(
//                         builder: (context) => new TermAndcondi()));
//                 // Then close the drawer
//                 //Navigator.pop(context);
//               },
//             ),
//             Divider(height: 2),
//             ListTile(
//               leading: Icon(Icons.exit_to_app),
//               title: Text('Logout'),
//               onTap: () {      
//                 Navigator.of(context).pushReplacementNamed('/');
//                 model.logout();
//               },
//             ),
//             Divider(height: 2),
//           ],
//         ),
//       );
//     });
//   }
// }
