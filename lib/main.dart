import 'package:cooky/ui_elements/homemain.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyHomePage());


class MyHomePage extends StatefulWidget {

  
  

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyState();
      }
    
     
    }
    
    class MyState extends State<MyHomePage>{
    
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
