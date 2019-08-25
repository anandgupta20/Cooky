import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child:  ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          child: Text("Click"),
          onPressed: (){
            model.toggleProductFavoriteStatus();
          },
        );
      },
    )
        ),
      ),
    );
  }
}