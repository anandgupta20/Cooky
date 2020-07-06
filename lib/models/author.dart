import 'package:flutter/material.dart';


class Author {
  final String name;
  final String discription;
  final String fbUrl;
  final String youtubeUrl;
  final String instaUrl;
  final String websiteLink;
  final String imageUrl;

  Author({@required this.name, @required this.discription, @required this.imageUrl, this.fbUrl,this.instaUrl,this.youtubeUrl,this.websiteLink});

   Author.fromMap(Map<String, dynamic> data)
      : this(
          name:data['Name']['stringValue'],
          discription:data['Description']['stringValue'],
          youtubeUrl:data['YoutubeUrl']['stringValue'],
          fbUrl:data['FbUrl']['stringValue'],
          instaUrl:data['InstaUrl']['stringValue'],
          websiteLink:data['WebsiteUrl']['stringValue'],
          imageUrl:data['ImageUrl']['stringValue'],
        );

}