import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cooky/models/recipe.dart';
import 'package:cooky/models/recipeHalf.dart';
import 'package:cooky/models/recipeFull.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ConnectedModel.dart';

class RecipeModel extends ConnectedModel {
  ////////////////////////////////////////

  List<RecipeHalf> get recipesHalf_all {
    return List.from(recipeHalfList_all);
  }

  int get selectedHalfRecipeIndex {
    return recipeHalfList_all.indexWhere((RecipeHalf recipeHalf) {
      return recipeHalf.id == selHalfRecipeId;
    });
  }

  List<Recipe> get recipesHalf_fav {
    return List.from(recipeHalfList_fav);
  }

  String get selectedHalfRecipeId {
    return selHalfRecipeId;
  }

  void selectHalfRecipe(String recipeId) {
    selHalfRecipeId = recipeId;
    notifyListeners();
  }

  RecipeHalf get selectedHalfRecipe {
    if (selectedHalfRecipeId == null) {
      return null;
    }

    return recipeHalfList_all.firstWhere((RecipeHalf recipe) {
      return recipe.id == selHalfRecipeId;
    });
  }

  ////////////////////////////////////////////

  //////////////////////////////////////////////

  RecipeFull get get_recipeFull {
    return recipeFull;
  }

  ///////////////////////////////////////////

  String get get_cur_pre {
    return cur_preference;
  }

//**************Different List iniatialisation*******************//

  List<RecipeHalf> get category_wise_Half {
    return List.from(categoryHalfList_wise);
  }

  //*******************End ***************************//

  Future<void> get_preferences() async {
    isLoading = true;
    notifyListeners();
    SharedPreferences sf = await SharedPreferences.getInstance();
    if (sf.getString(authenticatedUser.email) == null) {
      sf.setString(authenticatedUser.email, "Both");
      cur_preference = "Both";
    } else {
      String cur_pre = sf.getString(authenticatedUser.email);
      cur_preference = cur_pre;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> save_preferences(String pre) async {
    isLoading = true;
    sf = await SharedPreferences.getInstance();
    if (sf.getString(authenticatedUser.email) == null) {
      sf.setString(authenticatedUser.email, "Both");
    } else {
      sf.setString(authenticatedUser.email, pre);
      cur_preference = pre;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getrecipebyCategory(String category) async {
    try {
      if (isConnected) {
        isLoading = true;
        hasError = false;
        notifyListeners();
        if (category == "New Arrivals" || category == "Less Duration") {
          await Future.delayed(const Duration(seconds: 1), () {});
        } else {
          var encode;
          if (cur_preference.compareTo("Veg") == 0) {
            encode = json.encode({
              "structuredQuery": {
                "from": [
                  {"collectionId": "RecipeHalf"}
                ],
                "where": {
                  "compositeFilter": {
                    "op": "AND",
                    "filters": [
                      {
                        "fieldFilter": {
                          "field": {
                            "fieldPath": "category",
                          },
                          "op": "EQUAL",
                          "value": {"stringValue": category}
                        }
                      },
                      {
                        "fieldFilter": {
                          "field": {
                            "fieldPath": "isVeg",
                          },
                          "op": "EQUAL",
                          "value": {"booleanValue": true}
                        }
                      }
                    ],
                  }
                },
              }
            });
          } else if (cur_preference.compareTo("Non-Veg") == 0) {
            encode = json.encode({
              "structuredQuery": {
                "from": [
                  {"collectionId": "RecipeHalf"}
                ],
                "where": {
                  "compositeFilter": {
                    "op": "AND",
                    "filters": [
                      {
                        "fieldFilter": {
                          "field": {
                            "fieldPath": "category",
                          },
                          "op": "EQUAL",
                          "value": {"stringValue": category}
                        }
                      },
                      {
                        "fieldFilter": {
                          "field": {
                            "fieldPath": "isVeg",
                          },
                          "op": "EQUAL",
                          "value": {"booleanValue": false}
                        }
                      }
                    ],
                  }
                },
              }
            });
          } else {
            encode = json.encode({
              "structuredQuery": {
                "from": [
                  {"collectionId": "RecipeHalf"}
                ],
                "where": {
                  "fieldFilter": {
                    "field": {"fieldPath": "category"},
                    "op": "EQUAL",
                    "value": {"stringValue": category}
                  }
                },
              }
            });
          }
          http.Response response = await http.post(
              'https://firestore.googleapis.com/v1/projects/cooky-e12a6/databases/(default)/documents:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4/projects/cooky-e12a6/databases/(default)/documents/India:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${authenticatedUser.token}'
              },
              body: encode);
          var recipeDocuments = json.decode(response.body);
          //print("XXXXXXXXXXXX");
          /// print(recipeDocuments);

          sf = await SharedPreferences
              .getInstance(); //local database of favourite list item for particular user id

          //*****adding recipe to recipe_all list ************//
          final List<RecipeHalf> fetchedRecipeList = [];

          for (int i = 0; i < recipeDocuments.length; i++) {
            fetchedRecipeList.add(RecipeHalf.fromMap(
                recipeDocuments[i]['document']['fields'],
                authenticatedUser,
                sf));
          }
          categoryHalfList_wise = fetchedRecipeList;
        }

        // print(category_wise);
        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      hasError = true;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<RecipeFull> fetchRecipeFull(String id) async {
    try {
      if (isConnected) {
        isLoading = true;
        hasError = false;
        notifyListeners();
        var encode = json.encode({
          "structuredQuery": {
            "from": [
              {"collectionId": "RecipeFull"}
            ],
            "where": {
              "fieldFilter": {
                "field": {"fieldPath": "id"},
                "op": "EQUAL",
                "value": {"stringValue": id}
              }
            },
          }
        });
        ;

        http.Response response = await http.post(
            'https://firestore.googleapis.com/v1/projects/cooky-e12a6/databases/(default)/documents:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4/projects/cooky-e12a6/databases/(default)/documents/RecipeFull:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${authenticatedUser.token}'
            },
            body: encode);

        var recipeDocument = json.decode(response.body);

        RecipeFull recipe =
            RecipeFull.fromMap(recipeDocument[0]['document']['fields']);

        recipeFull = recipe;

        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      hasError = true;
      isLoading = false;
      notifyListeners();
    }
    return recipeFull;
  }

  Future<List<RecipeHalf>> fetchRecipeHalf() async {
    try {
      if (isConnected) {
        isLoading = true;
        hasError = false;
        notifyListeners();
        var encode;
        if (cur_preference.compareTo("Veg") == 0) {
          encode = json.encode({
            "structuredQuery": {
              "from": [
                {"collectionId": "RecipeHalf"}
              ],
              "where": {
                "fieldFilter": {
                  "field": {"fieldPath": "isVeg"},
                  "op": "EQUAL",
                  "value": {"booleanValue": true}
                }
              },
            }
          });
        } else if (cur_preference.compareTo("Non-Veg") == 0) {
          encode = json.encode({
            "structuredQuery": {
              "from": [
                {"collectionId": "RecipeHalf"}
              ],
              "where": {
                "fieldFilter": {
                  "field": {"fieldPath": "isVeg"},
                  "op": "EQUAL",
                  "value": {"booleanValue": false}
                }
              },
            }
          });
        } else {
          encode = json.encode({
            "structuredQuery": {
              "from": [
                {"collectionId": "RecipeHalf"}
              ],
            }
          });
        }
        //***********************Getting all recipes responses from database *************//
        http.Response response = await http.post(
            'https://firestore.googleapis.com/v1/projects/cooky-e12a6/databases/(default)/documents:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4/projects/cooky-e12a6/databases/(default)/documents/RecipeHalf:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${authenticatedUser.token}'
            },
            body: encode);

        var recipeDocuments = json.decode(response.body);

        print(recipeDocuments);
        //***********************End*******************************//

        sf = await SharedPreferences
            .getInstance(); //local database of favourite list item for particular user id

        //*****adding recipe to recipe_all list ************//
        final List<RecipeHalf> fetchedRecipeList = [];

        for (int i = 0; i < recipeDocuments.length; i++) {
          fetchedRecipeList.add(RecipeHalf.fromMap(
              recipeDocuments[i]['document']['fields'], authenticatedUser, sf));
        }
        recipeHalfList_all = fetchedRecipeList;
        //********** End ************//

        //***************adding recipe to recipe_fav list from local database(SharedPref) based on title present in local databse .  ************//
        List<RecipeHalf> recipeLi = [];
        if (sf.getStringList(authenticatedUser.id) != null) {
          for (int i = sf.getStringList(authenticatedUser.id).length - 1;
              i >= 0;
              i--) {
            RecipeHalf recipe = recipeHalfList_all.singleWhere(
                (RecipeHalf recipe) =>
                    recipe.id == sf.getStringList(authenticatedUser.id)[i],
                orElse: () => null);
            if (recipe != null) {
              recipeLi.add(recipe);
            }
          }
          recipeHalfList_fav = recipeLi;
        }

        print(recipeHalfList_all[0].duration);
        //********** End ************//
        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      hasError = true;
      isLoading = false;
      notifyListeners();
    }
    return recipeHalfList_all;
  }

//////////////////////////////////////////////////
  void toggleProductFavorite() async {
    final bool isCurrentlyFavorite = selectedHalfRecipe.isFavourite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final RecipeHalf updatedRecipee = RecipeHalf(
      id: selectedHalfRecipe.id,
      title: selectedHalfRecipe.title,
      isVeg: selectedHalfRecipe.isVeg,
      category: selectedHalfRecipe.category,
      duration: selectedHalfRecipe.duration,
      referenceId: selectedHalfRecipe.referenceId,
      imageUrl: selectedHalfRecipe.imageUrl,
      isFavourite: newFavoriteStatus,
    );
    recipeHalfList_all[selectedHalfRecipeIndex] = updatedRecipee;
    notifyListeners();

    // Getting favlist from local database
    sf = await SharedPreferences.getInstance();
    List<String> favList = [];
    if (sf.getStringList(authenticatedUser.id) != null) {
      favList = sf.getStringList(authenticatedUser.id);
    }

    if (newFavoriteStatus) {
      //Adding items to the favourite list  both to the local list(whole recipe) as well as local data(only recipe title)
      print(selectedHalfRecipe.id);
      favList.add(selectedHalfRecipe.id);
      recipeHalfList_fav.add(recipeHalfList_all.singleWhere(
          (RecipeHalf recipe) => recipe.id == selectedHalfRecipe.id));
      print(favList);
      print(recipeHalfList_fav);
      notifyListeners();
      sf.setStringList(authenticatedUser.id, favList).catchError((error) {
        print(error);
        final RecipeHalf updatedRecipee = RecipeHalf(
            id: selectedHalfRecipe.id,
            title: selectedHalfRecipe.title,
            isVeg: selectedHalfRecipe.isVeg,
            category: selectedHalfRecipe.category,
            duration: selectedHalfRecipe.duration,
            referenceId: selectedHalfRecipe.referenceId,
            imageUrl: selectedHalfRecipe.imageUrl,
            isFavourite: !newFavoriteStatus);

        recipeHalfList_all[selectedHalfRecipeIndex] = updatedRecipee;
        notifyListeners();
      });
    } else {
      //Removing items to the favourite list  both to the local list(whole recipe) as well as local data(only recipe title)
      favList.remove(selectedHalfRecipe.id);
      recipeHalfList_fav.removeWhere(
          (RecipeHalf recipe) => recipe.id == selectedHalfRecipe.id);
      //print(favrecipeList);
      notifyListeners();
      sf.setStringList(authenticatedUser.id, favList).catchError((error) {
        print(error);
        final RecipeHalf updatedRecipee = RecipeHalf(
            id: selectedHalfRecipe.id,
            title: selectedHalfRecipe.title,
            isVeg: selectedHalfRecipe.isVeg,
            category: selectedHalfRecipe.category,
            duration: selectedHalfRecipe.duration,
            referenceId: selectedHalfRecipe.referenceId,
            imageUrl: selectedHalfRecipe.imageUrl,
            isFavourite: !newFavoriteStatus);
        recipeHalfList_all[selectedHalfRecipeIndex] = updatedRecipee;
        notifyListeners();
      });
      print(favList);
      print(recipeHalfList_fav);
    }
  }
}
