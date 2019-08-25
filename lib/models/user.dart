import 'package:flutter/material.dart';


class User {
  final String id;
  final String email;
  final String token;
  final String refreshtoken;

  User({@required this.id, @required this.email, @required this.token, @required this.refreshtoken});
}
