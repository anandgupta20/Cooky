import 'package:flutter/material.dart';

class FullScreenDialog extends StatefulWidget {
  @override
  FullDialogState createState() => new FullDialogState();
}

class FullDialogState extends State<FullScreenDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return new Scaffold(
      appBar: new AppBar(
      
      ),
      body: ListView(
          padding: EdgeInsets.all(5),
          children: <Widget>[     
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              SizedBox(
              height:10,
              ),
               Container(
              child:Text("Healthy Dish Method",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               ),    
             SizedBox(
              height:20,
              ),
             Container(
             child:Text("What is the Healthy Dish ?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
             ),
            SizedBox(
              height:15,
            ),
            Container(
              height: height*0.224,
              width: double.maxFinite,
              margin: EdgeInsets.all(8),
              child:Text("My name is An"),  
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )     
             ),
            SizedBox(
              height:10,
            ),
              Container(
             height: height*0.224,
              width: double.maxFinite,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
              //  color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image:AssetImage('assets/circe.png')
              )     
             ),
            ),
            SizedBox(
              height:10,
             ),
             Text("Keys to the Healthy Dish",style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
              height:10,
             ),
             Container(
             height: height*0.224,
              width: double.maxFinite,
              margin: EdgeInsets.all(8),
              child:Text("My name is An"),  
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )     
             ),
             SizedBox(
              height:10,
             ),
             Container(
             height: height*0.224,
              width: double.maxFinite,
              margin: EdgeInsets.all(8),
              child:Text("My name is An"),  
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )     
             ),
             SizedBox(
              height:10,
             ),
             Container(
            height: height*0.224,
              width: double.maxFinite,
              margin: EdgeInsets.all(8),
              child:Text("My name is An"),  
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )     
             ),
              ],
            ),  
          ],
      ),
    );
  }
}