import 'package:flutter/material.dart';

class Categoryitem extends StatelessWidget{

final String item_name;

Categoryitem(
  this.item_name
);

  @override
  Widget build(BuildContext context) {
   
    return Material(
      color: Colors.grey[50],
      elevation: 5.0,
      borderRadius: BorderRadius.circular(12.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Icon(
                    Icons.category,
                    color: Colors.redAccent,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 1),
                  child: Text(item_name,
                      style: TextStyle(color: Colors.black, fontSize: 15.0)),
                )
              ],
            )
          ],
        ),
      ),
    ); 
  }
  
 

}
