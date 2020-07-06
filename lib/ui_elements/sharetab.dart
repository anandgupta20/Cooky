import 'package:flutter/material.dart';

class ShareTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return SingleChildScrollView(
      child: Card(
          margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          elevation: 2.0,
          clipBehavior: Clip.antiAlias,
          child: Container(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "If you are a food lover and cooking passionate you. Then you can have your impact on food community by joining our team. If you are intrested you can mail us on anandguptanits@gmail.com for further details .",
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aperiam, ullam? Fuga doloremque repellendus aut sequi officiis dignissimos, enim assumenda tenetur reprehenderit quam error, accusamus kmjikmm ikjipiop obniiop kjujjjj  uu jjjj jjjjm ikjijiojijij  ipsa? Officiis voluptatum sequi voluptas omnis. Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aperiam, ullam? Fuga doloremque repellendus aut sequi officiis dignissimos, enim assumenda tenetur reprehenderit quam error, accusamus ipsa? Officiis voluptatum sequi voluptas omnis.",
                    textAlign: TextAlign.justify,
                  )
                ],
              ))),
    );
  }
}
