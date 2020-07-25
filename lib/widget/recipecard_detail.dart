import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:flutter/material.dart';
import 'package:cooky/models/recipeHalf.dart';
import 'package:scoped_model/scoped_model.dart';

class RecipeCardDetail extends StatelessWidget {
  final RecipeHalf recipe;

  RecipeCardDetail(
    this.recipe,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //double width = size.width;
    double height = size.height;
    ScopedModelDescendant<MainModel> _buildFavoriteButton() {
      return ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return RawMaterialButton(
          constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
          onPressed: () {
            // print("Height And Width");
            // print(height);
            // print(width);
            model.selectHalfRecipe(recipe.id);
            model.toggleProductFavorite();
          },
          child: model.recipeHalfList_all
                  .firstWhere((RecipeHalf recipe1) => recipe1.id == recipe.id)
                  .isFavourite
              ? Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  size: 30,
                )
              : Icon(
                  Icons.favorite_border,
                  color: Colors.redAccent,
                  size: 30,
                ),
          elevation: 2.0,
          fillColor: Colors.white,
          shape: CircleBorder(),
        );
      });
    }

    ScopedModelDescendant<MainModel> _buildVegIcon() {
      return ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return model.recipeHalfList_all
                .firstWhere((RecipeHalf recipe1) => recipe1.id == recipe.id)
                .isVeg
            ? Image.asset(
                "assets/veg.png",
                height: 30,
                width: 30,
              )
            : Image.asset("assets/non-veg.png", height: 30, width: 30);
      });
    }

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // We overlap the image and the button by
          // creating a Stack object:
          Stack(
            children: <Widget>[
              Container(
                height: height * 0.27,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 1.5],
                      colors: [Colors.white, Colors.black]),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: FadeInImage(
                      placeholder: AssetImage(""),
                      image: NetworkImage(recipe.imageUrl),
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                child: _buildFavoriteButton(),
                bottom: 10.0,
                right: 10.0,
              ),
              Positioned(
                child: _buildVegIcon(),
                top: 10,
                left: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
