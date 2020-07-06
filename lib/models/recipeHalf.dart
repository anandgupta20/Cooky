import 'package:flutter/material.dart';
import 'package:cooky/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeHalf {
  
  final String id;
  final String title;
  final String category;
  final String imageUrl; 
  final bool isVeg;
  final String duration;
  final String referenceId;
  final bool isFavourite;

  RecipeHalf(
      {@required this.id,
      @required this.title,
      @required this.category,
      @required this.duration,
      @required this.imageUrl,
      @required this.referenceId,
      this.isVeg=false,
      this.isFavourite=false,
      });

  RecipeHalf.fromMap(Map<String, dynamic> data, User _authenticatedUser,
      SharedPreferences fav)
      : this(
          id: data['id']['stringValue'],
          title: data['title']['stringValue'],
          category: data['category']['stringValue'],
          duration: data['duration']['stringValue'],
          imageUrl: data['image']['stringValue'],
          referenceId:data['referenceId']['stringValue'],
          isVeg:data['isVeg']['booleanValue'],
          isFavourite: fav.getStringList(_authenticatedUser.id) == null
              ? false
              : fav.getStringList(_authenticatedUser.id).contains(data['id']['stringValue']),   
        );
}

List<String> convert(List<dynamic> list) {
  List<String> list1 = [];
  for (int i = 0; i < list.length; i++) {
    list1.add(list[i]['stringValue']);
  }
  return list1;
}
 