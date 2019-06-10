import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Detail extends StatelessWidget {
   DocumentSnapshot document;
  Detail(this.document);

  @override
  Widget build(BuildContext context){
    String image = "assets/img/2.jpg";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent[200],
        title: Text('Article Two',style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: (){},)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.asset(image,fit: BoxFit.cover,)),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 250.0,16.0,16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Text(document['title'], style: Theme.of(context).textTheme.title,),
                      SizedBox(height: 10.0),
                      Text("${document['timeStamp']} ${document['author']}"),
                      SizedBox(height: 10.0),
                      Divider(),
                      SizedBox(height: 10.0,),
                      Row(children: <Widget>[
                        Icon(Icons.favorite_border),
                        SizedBox(width: 5.0,),
                        Text(document['favouriteCount'].toString()),
                        SizedBox(width: 16.0,),
                        Icon(Icons.comment),
                        SizedBox(width: 5.0,),
                        Text("2.2k"),
                      ],),
                      SizedBox(height: 10.0,),
                      Text(document['description'], textAlign: TextAlign.justify,),
                      SizedBox(height: 10.0),
                      Text(document['description'], textAlign: TextAlign.justify,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}