import 'package:flutter/material.dart';
import 'package:cooky/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Recipe {
  final String id;
  final String author;
  final String title;
  final String description;
  final Duration duration;
  final List<String> ingredients;
  final List<String> preparation;
  final String category;
  final String imageUrl;
  final String favouriteCount;
  final String userEmail;
  final String userId;
  final bool isFavourite;
  final bool isVeg;

  Recipe(
      {
      @required this.id,
      @required this.duration,
      @required this.ingredients,
      @required this.preparation,
      @required this.author,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.userEmail,
      @required this.userId,
      @required this.favouriteCount,
      @required this.category,
      this.isFavourite = false,
      this.isVeg=false});

  Recipe.fromMap(Map<String, dynamic> data, String id, User _authenticatedUser,
      SharedPreferences fav)
      : this(
          id: id,
          author: data['author']['stringValue'],
          title: data['title']['stringValue'],
          duration: data['duration'],
          ingredients: convert(data['ingridients']['arrayValue']['values']),
          preparation: convert(data['preparation']['arrayValue']['values']),
          description: data['description']['stringValue'],
          userEmail: data['userEmail'],
          userId: data['userId'],
          category: data['category']['stringValue'],
          imageUrl: data['image']['stringValue'],
          isVeg:data['isVeg']['booleanValue'],
          isFavourite: fav.getStringList(_authenticatedUser.id) == null
              ? false
              : fav.getStringList(_authenticatedUser.id).contains(data['title']['stringValue']),
          favouriteCount: data['favouriteCount']['integerValue'],
        );
}

List<String> convert(List<dynamic> list) {
  List<String> list1 = [];
  for (int i = 0; i < list.length; i++) {
    list1.add(list[i]['stringValue']);
  }
  return list1;
}
