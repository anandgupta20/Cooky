

import 'package:flutter/material.dart';


class ShareTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Card(
               
              margin: EdgeInsets.fromLTRB(16.0, 16.0,16.0,16.0),
              //decoration: BoxDecoration(
              
                // color: Colors.white,
                //  borderRadius: BorderRadius.circular(5.0)
             // ),
               // padding: const EdgeInsets.all(16.0),
               elevation: 2.0,
               clipBehavior:Clip.antiAlias ,
               child:Container(
                    padding: EdgeInsets.only(top:20.0, bottom: 20.0,left: 20.0, right: 20.0),

                 child:Column(children: <Widget>[
                      Text("Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aperiam, ullam? Fuga doloremque repellendus aut sequi officiis dignissimos, enim assumenda tenetur reprehenderit quam error, accusamus ipsa? Officiis voluptatum sequi voluptas omnis. Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aperiam, ullam? Fuga doloremque repellendus aut sequi officiis dignissimos, enim assumenda tenetur reprehenderit quam error, accusamus ipsa? Officiis voluptatum sequi voluptas omnis.", textAlign: TextAlign.justify,),
                      SizedBox(height: 10.0),
                      Text("Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aperiam, ullam? Fuga doloremque repellendus aut sequi officiis dignissimos, enim assumenda tenetur reprehenderit quam error, accusamus ipsa? Officiis voluptatum sequi voluptas omnis. Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aperiam, ullam? Fuga doloremque repellendus aut sequi officiis dignissimos, enim assumenda tenetur reprehenderit quam error, accusamus ipsa? Officiis voluptatum sequi voluptas omnis.", textAlign: TextAlign.justify,)


                 ],))
                     
                      
                  
                ),
              );
    
  }
}