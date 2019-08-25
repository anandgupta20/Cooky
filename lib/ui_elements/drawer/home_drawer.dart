import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cooky/scoped_models/mainmodel.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40.0,
                    child: Icon(Icons.photo_camera),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'you@example.com',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share App'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('About us'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Terms of use'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  model.logout();
                  Navigator.of(context).pushReplacementNamed('/');
                },
              );
            },
          )
        ],
      ),
    );
  }
}
