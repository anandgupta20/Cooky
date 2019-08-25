import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/ui_elements/listViewCards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scoped_model/scoped_model.dart';

class Category extends StatelessWidget {
  GestureDetector items(String itemname, BuildContext context ) {
    return GestureDetector(
  onTap: () {
    _openListViewCardPage( context, "Vegetarian");
  },
  child: Material(
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
                  child: Text(itemname,
                      style: TextStyle(color: Colors.black, fontSize: 15.0)),
                )
              ],
            )
          ],
        ),
      ),
    ),
);
    
    
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Main Categories",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      staggered(context),
                      Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Based on region",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      staggered(context),
                    ],
                  ),
                )
              ]);
      },
    ));
  }

  Widget staggered(BuildContext context) {
    return StaggeredGridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: <Widget>[
        items("Starter", context),
        items("Vegan",context),
        items("Breakfast", context),
        items("Juices", context),
        items("Dessert", context),
        items("Snack", context),
      ],
      staggeredTiles: [
        StaggeredTile.extent(1, 100),
        StaggeredTile.extent(1, 100),
        StaggeredTile.extent(1, 100),
        StaggeredTile.extent(1, 100),
        StaggeredTile.extent(1, 100),
        StaggeredTile.extent(1, 100),
      ],
    );
  }
  
    _openListViewCardPage(BuildContext context, String category) {
   Navigator.push(context,
       MaterialPageRoute(builder: (context) => ListViewCards(category)));
   }

}
