import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooky/ui_elements/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cooky/Services/getRecipees.dart';

class ListViewCards extends StatelessWidget {
  final String category;

  ListViewCards(this.category);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Vegetarian"),
        backgroundColor: Colors.pinkAccent[200],
      ),
      body: listCards(context),
    );
  }

  Widget listCards(BuildContext context) {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
      stream: GetRecipesService().getByCategory(category),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading Data, please wait');
        } else {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return makeCard(context, snapshot, index);
            },
          );
        }
      },
    ));
  }

  Widget makeCard(BuildContext context, AsyncSnapshot snapshot, int index) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
         onTap: ()=>_openDetailPage(context, snapshot.data.documents[index]),
          child: Container(
            width: 300,
            height: 220,
            child: Column(
              children: <Widget>[
                Container(
                  height: 160,
                  width: 300,
                  child: Image.asset("assets/food.jpg", fit: BoxFit.fitWidth),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(snapshot.data.documents[index]['title'],
                              style: TextStyle(fontSize: 14.0)),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text("Vegetarian, Nepali",
                              style: TextStyle(fontSize: 12.0)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                        Text(
                          snapshot.data.documents[index]['favouriteCount'].toString(),
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
  _openDetailPage(BuildContext context, DocumentSnapshot document) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Detail(document)
    ));
  }
}
//
