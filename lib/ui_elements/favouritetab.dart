import 'package:flutter/material.dart';
import 'package:cooky/ui_elements/detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/models/recipe.dart';



class DisplayfavouriteTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return listCards(context);
  }
}


 Widget listCards(BuildContext context) {
    return Container(child: ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: model.displayRecipe.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(
                      context, model.displayRecipe,model.displayRecipe.length- index-1);
                },
              );
      },
    ));
  }
Widget makeCard(BuildContext context, List<Recipe> recipe, int index) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => _openDetailPage(context, recipe[index]),
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
                          Text(recipe[index].title,
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
                          recipe[index].favouriteCount.toString(),
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
    ));
  }

  _openDetailPage(BuildContext context, Recipe recipe) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailScreen(recipe)));
  }
