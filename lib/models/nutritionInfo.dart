import 'package:flutter/material.dart';

class NutritionInfo {
  final String id;
  final String calories;
  final String carbohydrate;
  final String proteins;
  final String fats;
  final String fibre;
  final String vitamins;
  final String minerals;

  NutritionInfo(
      {@required this.id,
      @required this.calories,
      @required this.carbohydrate,
      @required this.proteins,
      @required this.fats,
      @required this.fibre,
      @required this.vitamins,
      @required this.minerals});

  NutritionInfo.fromMap(Map<String, dynamic> data)
      : this(
          id: data['id']['stringValue'],
          calories: data['calories']['stringValue'],
          carbohydrate: data['carbohydrate']['stringValue'],
          proteins: data['proteins']['stringValue'],
          fats: data['fats']['stringValue'],
          fibre: data['fibre']['stringValue'],
          vitamins: data['vitamins']['stringValue'],
          minerals: data['minerals']['stringValue'],
        );
}
