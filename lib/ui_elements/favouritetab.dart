import 'package:cooky/widget/NoNetworkWidget.dart';
import 'package:cooky/widget/recipecard_main.dart';
import 'package:flutter/material.dart';
import 'package:cooky/ui_elements/detailrecipe.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/models/recipe.dart';
import 'package:cooky/models/recipeHalf.dart';

class DisplayfavouriteTab extends StatefulWidget {
  final  MainModel _model;
   DisplayfavouriteTab(this._model);
  DisplayfavouriteState createState()=>new DisplayfavouriteState();
  
}

class DisplayfavouriteState extends State<DisplayfavouriteTab>{
  @override
  void initState() {
    super.initState();
    
    widget._model.checkConnection();
    
  }
  @override
  Widget build(BuildContext context) {
    return listCards(context);
  }

}

Widget listCards(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    double height = size.height;
  return Container(child: ScopedModelDescendant(
    builder: (BuildContext context, Widget child, MainModel model) {
      return model.get_isLoading
          ? Center(
              child: CircularProgressIndicator(),
            ) :!model.get_isConnected?NoNetwork(model)
          : model.recipeHalfList_fav.length == 0
              ? Center(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          //color: Colors.redAccent,
                          image: AssetImage("assets/halflogo.png"),
                          height: height*0.3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Your favourite recipes will appear here.",
                          style: TextStyle(color: Colors.black87),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:25,right: 25,top:20,bottom: 20),
                          child: Text(
                              "Tap on the favourite icon to bookmark your favourite recipe.",
                              textAlign:TextAlign.center,
                              style: TextStyle(color: Colors.grey)),
                        )
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: model.recipeHalfList_fav.length,
                  itemBuilder: (BuildContext context, int index) {
                    return makeCard(context, model.recipeHalfList_fav,
                        model.recipeHalfList_fav.length - index - 1,model);
                  },
                );
    },
  ));
}

Widget makeCard(BuildContext context, List<RecipeHalf> recipe, int index,MainModel model) {
  return  SizedBox(
      height: 220,
      child: Padding(
    padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
    child: InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () => _openDetailPage(context, recipe[index],model),
      child: RecipeCardMain(recipe[index]),
      //
    ),
  ),);
}

_openDetailPage(BuildContext context, RecipeHalf recipe, MainModel model) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => DetailScreen(recipe, model)));
}
