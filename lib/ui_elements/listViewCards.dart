import 'package:cooky/ui_elements/detailrecipe.dart';
import 'package:cooky/widget/NoNetworkWidget.dart';
import 'package:cooky/widget/hasError.dart';
import 'package:cooky/widget/recipecard_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/models/recipeHalf.dart';

class ListViewCards extends StatefulWidget {
  final String category;
  final MainModel model;
  ListViewCards(this.category, this.model);

  ListViewState createState() {
    return new ListViewState();
  }
}

class ListViewState extends State<ListViewCards> {
  @override
  void initState() {
    super.initState();
    widget.model
        .checkConnection()
        .whenComplete(() => widget.model.getrecipebyCategory(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.redAccent,
      ),
      body: listCards(context)
    );
  }

  Widget listCards(BuildContext context) {
    return Container(child: ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.hasError? HasError(model):model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : !model.isConnected
                ? NoNetwork(model)
                :widget.category=="New Arrivals" || widget.category=="Less Duration" ? 
                 ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: widget.model.recipeHalfList_all.length,
                        itemBuilder: (BuildContext context, int index) {
                          return makeCard(context,
                               model.recipeHalfList_all, index,model);
                        },
                      )
                :widget.model.category_wise_Half.length == 0
                    ? Center(
                        child: Text(
                            "No Recipe in this category. We will be adding some soon."),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: widget.model.category_wise_Half.length,
                        itemBuilder: (BuildContext context, int index) {
                          return makeCard(context,
                               model.category_wise_Half, index,model);
                        },
                      );
      },
    ));
  }

  Widget makeCard(BuildContext context, List<RecipeHalf> recipe, int index,MainModel model) {
    return SizedBox(
        height: 220,
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () => _openDetailPage(context, recipe[index],model),
            child: RecipeCardMain(recipe[index]),
            //
          ),
        ));
  }

  _openDetailPage(BuildContext context, RecipeHalf recipe, MainModel model) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailScreen(recipe,model)));
  }

  // _getCategory(String category, MainModel model) {
  //   switch (category) {
  //     case "New Arrivals":
  //       return model.recipesHalf_all;
  //       break;
  //     case "Most Popular":
  //       return model.recipesHalf_all;
  //       break;
  //     default:
  //       return model.recipesHalf_all;
  //   }
  // }
}

