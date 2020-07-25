import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/ui_elements/listViewCards.dart';
import 'package:cooky/widget/NoNetworkWidget.dart';
import 'package:cooky/widget/categoryitems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scoped_model/scoped_model.dart';


class Category extends StatefulWidget {
   final MainModel model;
   Category(this.model);
 CategoryState createState() => new CategoryState();
}


class CategoryState extends State<Category>{
 

    @override
  void initState() {
     super.initState();
    //widget._model.checkConnection();
   
  }
          
    GestureDetector items(String itemname, BuildContext context,MainModel model) {
    return GestureDetector(
      onTap: () {
        _openListViewCardPage(context,itemname,model);
      },
      child: Categoryitem(itemname),
    );
  }

  Widget build(BuildContext context) {
    return Container(child: ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.get_isLoading
            ? Center(
                child: CircularProgressIndicator(),
              ):!model.get_isConnected?NoNetwork(model)
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
                      staggered(context,model),
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
                      staggered(context,model),
                    ],
                  ),
                )
              ]);
      },
    ));
  }

  Widget staggered(BuildContext context,MainModel model) {
    return StaggeredGridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: <Widget>[
        items("Low-Calorie", context,model),
        items("Breakfast", context,model),
        items("Lunch", context,model),
        items("Vegan", context,model),
        items("Juices", context,model),
        items("Dessert", context,model),
        items("Dinner", context,model),
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

  _openListViewCardPage(BuildContext context, String category,MainModel model) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ListViewCards(category,model)));
  }
}
