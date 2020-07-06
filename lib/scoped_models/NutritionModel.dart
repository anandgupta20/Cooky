import 'dart:convert';
import 'package:cooky/models/nutritionInfo.dart';
import 'package:http/http.dart' as http;
import 'package:cooky/models/author.dart';
import 'ConnectedModel.dart';

class NutritionModel extends ConnectedModel {
  

   NutritionInfo get get_NutritionbyId {
    return nutritionObj;
  }

  Future<NutritionInfo> getNutritonrbyId(String id) async {
    if (isConnected) {
      isLoading = true;
      notifyListeners();
      var encode = json.encode({
        "structuredQuery": {
          "from": [
            {"collectionId": "Nutrition"}
          ],
          "where": {
            "fieldFilter": {
              "field": {"fieldPath": "id"},
              "op": "EQUAL",
              "value": {"stringValue":id}
            }
          },
        }
      }); ;

      http.Response response = await http
          .post(
              'https://firestore.googleapis.com/v1/projects/cooky-e12a6/databases/(default)/documents:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4/projects/cooky-e12a6/databases/(default)/documents/Nutrition:runQuery?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${authenticatedUser.token}'
              },
              body: encode)
          .catchError((error) => print(error));
       var recipeDocument = json.decode(response.body);
       print(recipeDocument);

       NutritionInfo nutrition= NutritionInfo.fromMap(
         recipeDocument[0]['document']['fields']
       );
       
      nutritionObj=nutrition;
      print(nutritionObj);
      isLoading=false;
       notifyListeners();

    }
    return nutritionObj;
  }

}
