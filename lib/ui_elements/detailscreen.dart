import 'package:flutter/material.dart';

import 'package:cooky/widget/recipe_title.dart';
import 'package:cooky/widget/recipe_image.dart';
import 'package:cooky/models/recipe.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailScreen extends StatefulWidget {
  final Recipe recipe;

  DetailScreen(
    this.recipe,
  );

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  //bool _inFavorites;
  //StateModel appState;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
    // _inFavorites = widget.inFavorites;
  }

  @override
  void dispose() {
    // "Unmount" the controllers:
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    // appState = StateWidget.of(context).state;

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerViewIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //  RecipeImage(widget.recipe.imageUrl),
                    RecipeImage("assets/food.jpg"),
                    RecipeTitle(widget.recipe, 20.0),
                    Container(
                      height: 30,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.memory),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("65%")
                              ],
                            ),
                          ),
                          VerticalDivider(),
                          Expanded(
                            child: Text(
                              "Vegetarian",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          VerticalDivider(),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.timer),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("10 min")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child:Container
                      (padding: EdgeInsets.all(25),
                      child: Text(
                         widget.recipe.description
                         ),
                    )
                    ),
                  ],
                ),
              ),
              expandedHeight: 500.0,
              pinned: true,
              floating: true,
              elevation: 2.0,
              forceElevated: innerViewIsScrolled,
              bottom: TabBar(
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                labelColor: Colors.black,
                indicatorColor: Colors.redAccent,
                tabs: <Widget>[
                  Tab(
                    text: "Home",
                  ),
                  Tab(text: "Preparation"),
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            IngredientsView(widget.recipe.ingredients),
            PreparationView(widget.recipe.preparation), 
          ],
          controller: _tabController,
        ),
      ),
      floatingActionButton: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return FloatingActionButton(
            onPressed: () {
              model.selectRecipe(widget.recipe.id);
              model.toggleProductFavorite();

              // updateFavorites(appState.user.uid, widget.recipe.id).then((result) {
              //   // Toggle "in favorites" if the result was successful.
              //   if (result) _toggleInFavorites();
              // });
            },
            child: model.recipeList
                    .firstWhere(
                        (Recipe recipe) => recipe.id == widget.recipe.id)
                    .isFavourite
                ? Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 35,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.blueGrey[100],
                    size: 35,
                  ),
            elevation: 6.0,
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }
}

class IngredientsView extends StatelessWidget {
  final List<String> ingredients;

  IngredientsView(this.ingredients);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = new List<Widget>();
    ingredients.forEach((item) {
      children.add(
        new Row(
          children: <Widget>[
            new Icon(Icons.done),
            new SizedBox(width: 5.0),
            new Text(item.toString()),
          ],
        ),
      );
      // Add spacing between the lines:
      children.add(
        new SizedBox(
          height: 5.0,
        ),
      );
    });
    return ListView(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 45.0),
      children: children,
    );
  }
}

class PreparationView extends StatelessWidget {
  final List<String> preparationSteps;

  PreparationView(this.preparationSteps);

  @override
  Widget build(BuildContext context) {
    List<Widget> textElements = List<Widget>();
    int i=1;
    preparationSteps.forEach((value) {

      textElements.add(
        _buildStep(
          leadingTitle: "0${i.toString()}",
          title: "Step".toUpperCase(),
          content: value.toString(),
        ),
      );
      // Add spacing between the lines:
      textElements.add(
        SizedBox(
          height: 10.0,
        ),
      );
      i++;
    });
    return ListView(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 45.0),
      children: textElements,
    );
  }
}

Widget _buildStep({String leadingTitle, String title, String content}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: Colors.red,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Text(leadingTitle,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0)),
        ),
      ),
      SizedBox(
        width: 16.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(
              height: 10.0,
            ),
            Text(content),
          ],
        ),
      )
    ],
  );
}
