import 'package:cooky/models/recipe.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:cooky/models/user.dart';
import 'package:cooky/models/auth.dart';
import 'package:rxdart/subjects.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Firestore db = Firestore.instance;
SharedPreferences fav;

class ConnectedProductsModel extends Model {
  // List<Recipe> _recipes = [];

  List<Recipe> favrecipeList = [];
  List<Recipe> recipeList = [];
  List<Recipe> mostPopularecipe = [];
  List<Recipe> recipeListbyCategory = [];
  String _selRecipeId;
  User _authenticatedUser;
  bool _isLoading = false;
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}

class RecipeModel extends ConnectedProductsModel {
  int get selectedRecipeIndex {
    return recipeList.indexWhere((Recipe recipe) {
      return recipe.id == _selRecipeId;
    });
  }

  String get selectedRecipetId {
    return _selRecipeId;
  }

  Recipe get selectedRecipe {
    if (selectedRecipetId == null) {
      return null;
    }

    return recipeList.firstWhere((Recipe recipe) {
      return recipe.id == _selRecipeId;
    });
  }

  void selectRecipe(String recipeId) {
    _selRecipeId = recipeId;
    notifyListeners();
  }

  List<Recipe> get allRecipe {
    return List.from(recipeList);
  }

  List<Recipe> get displayRecipe {
    return List.from(favrecipeList);
  }

  List<Recipe> get mostPopularecipeList {
    List<Recipe> mostPopular = recipeList;
    mostPopular.sort((recipe1, recipe) =>
        recipe.favouriteCount.compareTo(recipe1.favouriteCount));

    return mostPopular;
  }

  List<Recipe> get recipeListbyCategory {
    List<Recipe> _result = [];

    for (int i = 0; i < recipeList.length; i++) {
      if (recipeList[i].category == "Vegetarian") _result.add(recipeList[i]);
    }
    return List.from(_result);
  }

  Future<List<Recipe>> fetchRecipe() async {
    _isLoading = true;
    notifyListeners();
    http.Response response = await http.get(
      'https://firestore.googleapis.com/v1/projects/cooky-e12a6/databases/(default)/documents/India?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
      //  body: json.encode(authData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_authenticatedUser.token}'
      },
    ).catchError((e) => {print(e)});
    fav = await SharedPreferences.getInstance();

    final List<Recipe> fetchedRecipeList = [];
    print(response.body);
    var recipeDocuments = json.decode(response.body);
    // var recipeDocuments = await db.collection("India").getDocuments();
    //List<Map<String, dynamic>> list=recipeDocuments['documents'][0]['fields']['ingridients']['arrayValue']['values'];
   

    for (int i = 0; i < recipeDocuments['documents'].length; i++) {
      if (i != 3) {
        fetchedRecipeList.add(Recipe.fromMap(
            recipeDocuments['documents'][i]['fields'],
            recipeDocuments['documents'][i]['name'],
            _authenticatedUser,
            fav));
      }
    }
    recipeList = fetchedRecipeList;
    List<Recipe> recipeLi = [];
    if (fav.getStringList(_authenticatedUser.id) != null) {
      for (int i = fav.getStringList(_authenticatedUser.id).length-1;
          i >= 0;
          i--) {
        Recipe recipe = recipeList.singleWhere((Recipe recipe) =>
            recipe.title == fav.getStringList(_authenticatedUser.id)[i]);
        recipeLi.add(recipe);
      }
      favrecipeList = recipeLi;
    }
    _isLoading = false;
    notifyListeners();
    return recipeList;
    //recipeList[0].
  }

  Future fetcRecipe() async {
    _isLoading = true;
    notifyListeners();

    http.Response response = await http.get(
      'https://firestore.googleapis.com/v1/projects/cooky-e12a6/databases/(default)/documents/India?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
      //  body: json.encode(authData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_authenticatedUser.token}'
      },
    ).catchError((e) => {print(e)});
    //  var recipeDocuments=json.decode(response.body);

    //  final List<Recipe> fetchedRecipeList = [];

    print(json.decode(response.body));
  }

  void toggleProductFavoriteStatus() async {
    final bool isCurrentlyFavorite = selectedRecipe.isFavourite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Recipe updatedRecipee = Recipe(
        id: selectedRecipe.id,
        title: selectedRecipe.title,
        description: selectedRecipe.description,
        author: selectedRecipe.author,
        ingredients: selectedRecipe.ingredients,
        preparation: selectedRecipe.preparation,
        duration: selectedRecipe.duration,
        imageUrl: selectedRecipe.imageUrl,
        category: selectedRecipe.category,
        userEmail: selectedRecipe.userEmail,
        userId: selectedRecipe.userId,
        favouriteCount: selectedRecipe.favouriteCount,
        isFavourite: newFavoriteStatus);
    recipeList[selectedRecipeIndex] = updatedRecipee;
    notifyListeners();

    http.Response response = await http
        .patch(
            'https://firestore.googleapis.com/v1/projects/cooky-e12a6/databases/(default)/documents/India/EWx1TZtFSUCofPKpcaa1/?updateMask.fieldPaths=description&updateMask.fieldPaths=category&updateMask.fieldPaths=wishlistuser',
            //  body: json.encode(authData),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${_authenticatedUser.token}'
            },
            body: json.encode({
              "fields": {
                "description": {
                  "stringValue":
                      "ed in the 196tware like Aldus PageMaker including versions of Lorem Ipsum."
                },
                "category": {"stringValue": "Vegeiloijij"},
                "wishlistuser": {
                  "${FieldValue.arrayUnion([_authenticatedUser.id])}"
                }
              }
            }))
        .catchError((e) => {print(e)});

    print(json.decode(response.body));
    // if (newFavoriteStatus) {
    //   // Atomically add a new region to the "regions" array field.
    //   ref.updateData({
    //     "wishlistuser": FieldValue.arrayUnion([_authenticatedUser.id])
    //   }).catchError((error) {
    //     print(error);
    //     final Recipe updatedRecipee = Recipe(
    //         id: selectedRecipe.id,
    //         title: selectedRecipe.title,
    //         description: selectedRecipe.description,
    //         author: selectedRecipe.author,
    //         ingredients: selectedRecipe.ingredients,
    //         preparation: selectedRecipe.preparation,
    //         duration: selectedRecipe.duration,
    //         imageUrl: selectedRecipe.imageUrl,
    //         category: selectedRecipe.category,
    //         userEmail: selectedRecipe.userEmail,
    //         userId: selectedRecipe.userId,
    //         favouriteCount: selectedRecipe.favouriteCount,
    //         isFavourite: !newFavoriteStatus);
    //     recipeList[selectedRecipeIndex] = updatedRecipee;
    //      notifyListeners();
    //   });
    // } else {
    //   // Atomically remove a region from the "regions" array field.
    //   ref.updateData({
    //     "wishlistuser": FieldValue.arrayRemove([_authenticatedUser.id])
    //   }).catchError((error) {
    //     print(error);
    //     final Recipe updatedRecipee = Recipe(
    //         id: selectedRecipe.id,
    //         title: selectedRecipe.title,
    //         description: selectedRecipe.description,
    //         author: selectedRecipe.author,
    //         ingredients: selectedRecipe.ingredients,
    //         preparation: selectedRecipe.preparation,
    //         duration: selectedRecipe.duration,
    //         imageUrl: selectedRecipe.imageUrl,
    //         category: selectedRecipe.category,
    //         userEmail: selectedRecipe.userEmail,
    //         userId: selectedRecipe.userId,
    //         favouriteCount: selectedRecipe.favouriteCount,
    //         isFavourite:! newFavoriteStatus);
    //     recipeList[selectedRecipeIndex] = updatedRecipee;
    //      notifyListeners();
    //   });
  }

  // void toggleProductFavoriteStatus() async {
  //   final bool isCurrentlyFavorite = selectedRecipe.isFavourite;
  //   final bool newFavoriteStatus = !isCurrentlyFavorite;
  //   final Recipe updatedRecipee = Recipe(
  //       id: selectedRecipe.id,
  //       title: selectedRecipe.title,
  //       description: selectedRecipe.description,
  //       author: selectedRecipe.author,
  //       ingredients: selectedRecipe.ingredients,
  //       preparation: selectedRecipe.preparation,
  //       duration: selectedRecipe.duration,
  //       imageUrl: selectedRecipe.imageUrl,
  //       category: selectedRecipe.category,
  //       userEmail: selectedRecipe.userEmail,
  //       userId: selectedRecipe.userId,
  //       favouriteCount: selectedRecipe.favouriteCount,
  //       isFavourite: newFavoriteStatus);
  //   recipeList[selectedRecipeIndex] = updatedRecipee;
  //   notifyListeners();
  //   DocumentReference ref =
  //       db.collection("India").document(recipeList[selectedRecipeIndex].id);

  //   if (newFavoriteStatus) {
  //     // Atomically add a new region to the "regions" array field.
  //     ref.updateData({
  //       "wishlistuser": FieldValue.arrayUnion([_authenticatedUser.id])
  //     }).catchError((error) {
  //       print(error);
  //       final Recipe updatedRecipee = Recipe(
  //           id: selectedRecipe.id,
  //           title: selectedRecipe.title,
  //           description: selectedRecipe.description,
  //           author: selectedRecipe.author,
  //           ingredients: selectedRecipe.ingredients,
  //           preparation: selectedRecipe.preparation,
  //           duration: selectedRecipe.duration,
  //           imageUrl: selectedRecipe.imageUrl,
  //           category: selectedRecipe.category,
  //           userEmail: selectedRecipe.userEmail,
  //           userId: selectedRecipe.userId,
  //           favouriteCount: selectedRecipe.favouriteCount,
  //           isFavourite: !newFavoriteStatus);
  //       recipeList[selectedRecipeIndex] = updatedRecipee;
  //        notifyListeners();
  //     });
  //   } else {
  //     // Atomically remove a region from the "regions" array field.
  //     ref.updateData({
  //       "wishlistuser": FieldValue.arrayRemove([_authenticatedUser.id])
  //     }).catchError((error) {
  //       print(error);
  //       final Recipe updatedRecipee = Recipe(
  //           id: selectedRecipe.id,
  //           title: selectedRecipe.title,
  //           description: selectedRecipe.description,
  //           author: selectedRecipe.author,
  //           ingredients: selectedRecipe.ingredients,
  //           preparation: selectedRecipe.preparation,
  //           duration: selectedRecipe.duration,
  //           imageUrl: selectedRecipe.imageUrl,
  //           category: selectedRecipe.category,
  //           userEmail: selectedRecipe.userEmail,
  //           userId: selectedRecipe.userId,
  //           favouriteCount: selectedRecipe.favouriteCount,
  //           isFavourite:! newFavoriteStatus);
  //       recipeList[selectedRecipeIndex] = updatedRecipee;
  //        notifyListeners();
  //     });
  //   }
  // }

  void toggleProductFavorite() async {
    final bool isCurrentlyFavorite = selectedRecipe.isFavourite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Recipe updatedRecipee = Recipe(
        id: selectedRecipe.id,
        title: selectedRecipe.title,
        description: selectedRecipe.description,
        author: selectedRecipe.author,
        ingredients: selectedRecipe.ingredients,
        preparation: selectedRecipe.preparation,
        duration: selectedRecipe.duration,
        imageUrl: selectedRecipe.imageUrl,
        category: selectedRecipe.category,
        userEmail: selectedRecipe.userEmail,
        userId: selectedRecipe.userId,
        favouriteCount: selectedRecipe.favouriteCount,
        isFavourite: newFavoriteStatus);
    recipeList[selectedRecipeIndex] = updatedRecipee;
    notifyListeners();

    fav = await SharedPreferences.getInstance();
    List<String> favList = [];
    if (fav.getStringList(_authenticatedUser.id) != null) {
      favList = fav.getStringList(_authenticatedUser.id);
    }
    print(favList);

    if (newFavoriteStatus) {
      // Atomically add a new region to the "regions" array field.
      print(selectedRecipe.title);
      favList.add(selectedRecipe.title);
      favrecipeList.add(recipeList.singleWhere(
          (Recipe recipe) => recipe.title == selectedRecipe.title));
      print(favrecipeList);
      notifyListeners();
      fav.setStringList(_authenticatedUser.id, favList).catchError((error) {
        print(error);
        final Recipe updatedRecipee = Recipe(
            id: selectedRecipe.id,
            title: selectedRecipe.title,
            description: selectedRecipe.description,
            author: selectedRecipe.author,
            ingredients: selectedRecipe.ingredients,
            preparation: selectedRecipe.preparation,
            duration: selectedRecipe.duration,
            imageUrl: selectedRecipe.imageUrl,
            category: selectedRecipe.category,
            userEmail: selectedRecipe.userEmail,
            userId: selectedRecipe.userId,
            favouriteCount: selectedRecipe.favouriteCount,
            isFavourite: !newFavoriteStatus);
        recipeList[selectedRecipeIndex] = updatedRecipee;
        notifyListeners();
      });
    } else {
      // Atomically remove a region from the "regions" array field.
      favList.remove(selectedRecipe.title);
      favrecipeList
          .removeWhere((Recipe recipe) => recipe.title == selectedRecipe.title);
      print(favrecipeList);
      notifyListeners();
      fav.setStringList(_authenticatedUser.id, favList).catchError((error) {
        print(error);
        final Recipe updatedRecipee = Recipe(
            id: selectedRecipe.id,
            title: selectedRecipe.title,
            description: selectedRecipe.description,
            author: selectedRecipe.author,
            ingredients: selectedRecipe.ingredients,
            preparation: selectedRecipe.preparation,
            duration: selectedRecipe.duration,
            imageUrl: selectedRecipe.imageUrl,
            category: selectedRecipe.category,
            userEmail: selectedRecipe.userEmail,
            userId: selectedRecipe.userId,
            favouriteCount: selectedRecipe.favouriteCount,
            isFavourite: !newFavoriteStatus);
        recipeList[selectedRecipeIndex] = updatedRecipee;
        notifyListeners();
      });
    }
  }
}

class UserModel extends ConnectedProductsModel {
  PublishSubject<bool> _userSubject = PublishSubject();

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  User get user {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong.';
    print(responseData);
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedUser = User(
          id: responseData['localId'],
          email: email,
          token: responseData['idToken'],
          refreshtoken: responseData['refreshToken']);
      _userSubject.add(true);
      print("refreshToken");
      print(responseData['refreshToken']);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('refreshtoken', responseData['refreshToken']);
      // prefs.setString('expiryTime', expiryTime.toIso8601String());
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists.';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found.';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'The password is invalid.';
    }

    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString("userEmail");
    final String userId = prefs.getString("userId");
    final String refreshToken = prefs.getString("refreshtoken");
    
    http.Response response = await http.post(
      "https://securetoken.googleapis.com/v1/token?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4",
      body: 'grant_type=refresh_token&refresh_token=${refreshToken}',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    final Map<String, dynamic> newresponseData = json.decode(response.body);
    print(newresponseData);
    if (newresponseData.containsKey('id_token')) {
      print("in if loop");

      _authenticatedUser = User(
          id: userId,
          email: email,
          token: newresponseData['id_token'],
          refreshtoken: newresponseData['refresh_token']
          );

      prefs.setString('token', newresponseData['id_token']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', userId);
      prefs.setString('refreshtoken', newresponseData['refresh_token']);
       _userSubject.add(true);
       notifyListeners();
    }
   
  }

  void logout() async {
    _authenticatedUser = null;
    _userSubject.add(false);
    _isLoading = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
  }
}
