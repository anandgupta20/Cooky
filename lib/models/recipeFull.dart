import 'package:flutter/material.dart';
import 'package:cooky/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeFull {
  final String id;
  final String authorName;
  final String introduction;
  final List<double> heathIndex;
  final String nutritionId;
  final List<String> ingredients;
  final List<String> directions;
  final String youtubeId;
  final String serveNumber;

  RecipeFull(
      {@required this.id,
      @required this.authorName,
      @required this.introduction,
      @required this.heathIndex,
      @required this.nutritionId,
      @required this.ingredients,
      @required this.directions,
      @required this.youtubeId,
      @required this.serveNumber,
     });

  RecipeFull.fromMap(Map<String, dynamic> data)
      : this(
          id: data['id']['stringValue'],
          authorName: data['authorName']['stringValue'],
          introduction: data['introduction']['stringValue'],
          heathIndex: convertInteger(data['healthIndex']['arrayValue']['values']),
          nutritionId:data['nutritionId']['stringValue'],
          ingredients: convertString(data['ingredients']['arrayValue']['values']),
          directions: convertString(data['directions']['arrayValue']['values']),
          serveNumber: data['serveNumber']['stringValue'],
          youtubeId:data['youtubeId']['stringValue'],
        );
}

List<double>  convertInteger(List<dynamic> list)
{
   List<double> list1 = [];
  for (int i = 0; i < list.length; i++) {
    list1.add(list[i]['doubleValue']);
  }
  return list1;

}

List<String> convertString(List<dynamic> list) {
  List<String> list1 = [];
  for (int i = 0; i < list.length; i++) {
    list1.add(list[i]['stringValue']);
  }
  return list1;
}
 