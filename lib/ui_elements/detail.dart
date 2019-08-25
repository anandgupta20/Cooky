import 'package:cooky/Services/getRecipees.dart';
import 'package:cooky/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';



 

class Detail extends StatefulWidget {
  final  Recipe recipe;
  Detail(this.recipe);
  

  @override
  State<StatefulWidget> createState(){

    return _DetailPageState();
  }
  }

   class _DetailPageState extends State<Detail>{
     
      bool _isFavouriteclick=true;
      Recipe recipe;
       String favouriteCount;
      @override
  void initState() {
    // TODO: implement initState
     recipe=widget.recipe;
     favouriteCount=recipe.favouriteCount;
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    String image = "assets/img/2.jpg";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Article Two',style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: (){
            final RenderBox box = context.findRenderObject();
                              Share.share("Want to share",
                                  sharePositionOrigin:
                                      box.localToGlobal(Offset.zero) &
                                          box.size);
          },)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.asset(image,fit: BoxFit.cover,)),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 250.0,16.0,16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Text(recipe.title, style: Theme.of(context).textTheme.title,),
                      SizedBox(height: 10.0),
                     // Text("${document['timeStamp']} ${document['author']}"),
                      SizedBox(height: 10.0),
                      Divider(),
                      SizedBox(height: 10.0,),
                      Row(children: <Widget>[
                        IconButton(
                        //  onPressed:(){
                        //           if(_isFavouriteclick){
                        //    GetRecipesService().favCountincrement(recipe.favouriteCount,recipe);
                        //     setState(() {
                        //        favouriteCount=recipe.favouriteCount+1;
                        //        _isFavouriteclick=false;
                        //     });}} ,
                         
                         icon: Icon(Icons.favorite_border,),
                        ),
                        Text(favouriteCount.toString()),
                        SizedBox(width: 16.0,),
                        Icon(Icons.comment),
                        SizedBox(width: 5.0,),
                        Text("2.2k"),
                      ],),
                      SizedBox(height: 10.0,),
                      Text(recipe.description, textAlign: TextAlign.justify,),
                      SizedBox(height: 10.0),
                      Text(recipe.description, textAlign: TextAlign.justify,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}