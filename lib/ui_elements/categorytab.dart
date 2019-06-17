import 'package:flutter/material.dart';

import 'listViewCards.dart';

class CategoryTab extends StatelessWidget {
  final List<String> _categoryList = [
    'Vegetarian',
    'Non Vegetarian',
    'Gujrati Recipee',
    'Malwa Recipee',
    'Punjabi Recipee',
    'South Indian Recipee',
    'Assamese Recipee',
    'Rajasthani Recipee'
  ];
  final List<int> categorycount;
  CategoryTab(this.categorycount);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(context, index);
        },
      ),
    );
    ;
  }

  Widget makeCard(BuildContext context, int index) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: makeListTile(context, index),
      ),
    );
  }

  Widget makeListTile(BuildContext context, int index) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.black),
        ),
        title: Text(
          _categoryList[index],
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(categorycount[index].toString(),
                style: TextStyle(color: Colors.black))
          ],
        ),
        trailing: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.pinkAccent[100],
            ),
            onPressed: () =>
                _openListViewCardPage(context, _categoryList[index])));
  }

  _openListViewCardPage(BuildContext context, String category) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ListViewCards(category)));
  }
}
