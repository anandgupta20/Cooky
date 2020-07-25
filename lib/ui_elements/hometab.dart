
import 'package:cooky/models/recipeHalf.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/ui_elements/listViewCards.dart';
import 'package:cooky/ui_elements/detailrecipe.dart';
import 'package:cooky/widget/NoNetworkWidget.dart';
import 'package:cooky/widget/recipecard_main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class HomeTab extends StatefulWidget {
  final MainModel _model;
  HomeTab(this._model);
  HomeTabState createState() => new HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  @override
  void initState() {
   // widget._model.fetchRecipe().whenComplete(() => widget._model.checkConnection());
   // widget._model.checkConnection();
    super.initState();
  }

  final List<String> _category = [
    "New Arrivals",
    "Less Duration",
    "Low-Calorie",
    //"Festival dishes",
   // ""
  ];

  @override
  Widget build(BuildContext context) {
    return Container(child: ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.get_isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : !model.get_isConnected
                ? NoNetwork(model)
                : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      if (index % 2 == 0) {
                        return _buildCarousel(context, index ~/ 2, model);
                      } else {
                        return Divider(
                          indent: 15.0,
                          height: 25.0,
                        );
                      }
                    },
                  );
      },
    ));
  }

  Widget _buildCarousel(
      BuildContext context, int carouselIndex, MainModel model) {
    print("no" + "$carouselIndex");
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildListHeader(_category[carouselIndex], "SEE ALL", context, model),
        SizedBox(
          height: 25.0,
        ),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 220.0,

          child: ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            //  if (!snapshot.hasData)
            return PageView.builder(
              // store this controller in a State to save the carousel scroll position
              controller: PageController(viewportFraction: 0.9, initialPage: 1),
              itemCount: 4,
              itemBuilder: (BuildContext context, int itemIndex) {
                // return  _buildCarouselItem(context,itemIndex,
                //           model.category_wise_Half,model);
                 
                
                
               return _buildCarouselItem(context, itemIndex,
                    _getCarousal(_category[carouselIndex], model),model);
              },
            );
          }),
        )
      ],
    );
  }

  Widget _buildCarouselItem(
      BuildContext context, int itemIndex, List<RecipeHalf> recipes, MainModel model) {
    return GestureDetector(
      onTap: () => _openDetailPage(context, recipes[itemIndex],model),
      child: RecipeCardMain(recipes[itemIndex]),
    );
  }

  Widget _buildListHeader(
      String left, String right, BuildContext context, MainModel model) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, top: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          color: Colors.redAccent,
          child: Text(
            left,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10.0, top: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: InkWell(
            onTap: () => _openListViewCardPage(context, left, model),
            child: Text(
              right,
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ],
    ));
  }

  _getCarousal(String category, MainModel model) {
    switch (category) {
      case "New Arrivals":
        return model.recipeHalfList_all;
        break;
      case "Less Duration":
        return model.recipeHalfList_all.where((recipeHalf) =>int.parse(recipeHalf.duration)<=40).toList();
        break;
      case "Low-Calorie":
        return model.recipeHalfList_all.where((recipeHalf) =>recipeHalf.category=="Low-Calorie").toList();
      break;
      default:
        return model.recipeHalfList_all;
    }
  }

  _openListViewCardPage(
    BuildContext context, String category, MainModel model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListViewCards(category, model)));
  }

  _openDetailPage(BuildContext context, RecipeHalf recipe, MainModel model) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailScreen(recipe, model)));
  }
}
