import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooky/models/author.dart';
import 'package:cooky/models/nutritionInfo.dart';
import 'package:cooky/models/recipeHalf.dart';
import 'package:cooky/models/recipeFull.dart';
import 'package:cooky/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectedModel extends Model {

  Firestore db = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      "https://www.googleapis.com/auth/userinfo.email",
      //'https://www.googleapis.com/auth/datastore',
    ],
  );
  
  SharedPreferences sf; 

  ////Error///
  
  bool hasError;

   String cur_preference;
  ////////////////Nutrition Model Things///////////////
   NutritionInfo nutritionObj;
   ///////////////////////////////

   ////RecipeFull Model things//////  
   RecipeFull recipeFull; 
   ////RecipeHalf Model things//////
  String selHalfRecipeId;
  List<RecipeHalf> recipeHalfList_fav = [];
  List<RecipeHalf> recipeHalfList_all = [];
  List<RecipeHalf> categoryHalfList_wise = [];
  List<RecipeHalf> recipeHalfList_mostpopular = [];
  List<RecipeHalf> recipeHalfList_byCategory = [];
  //////////////////////////////////////
 

  ////Author Model things//////
  Author author;
  List<Author> author_list = [];
  //////////////////////////////

  ////User Model things//////
  User authenticatedUser;
  ////////////////////////

  ////Utility Model things//////
  bool isLoading = false;
  bool isConnected = true;
  //////////////////////////////
}
