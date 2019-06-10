

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooky/Services/getRecipees.dart';
import 'package:cooky/ui_elements/detail.dart';

import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
   final List<String> _category=["New Arrivals", "Most Popular", "Vegetarian", "Festival dishes", ""];
   
  @override
  Widget build(BuildContext context) {

   
    // TODO: implement build
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          if (index % 2 == 0) {
            return _buildCarousel(context, index ~/ 2);
          } else {
            return Divider(
              indent: 15.0,
              height: 25.0,
            );
          }
        },
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {

    print("no" + "$carouselIndex");
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildListHeader( _category[carouselIndex], "SEE ALL"),
        SizedBox(
          height: 25.0,
        ),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 220.0,
        
          
          child: StreamBuilder<QuerySnapshot>(
            stream: _getCarousal(carouselIndex),
            builder: (context, snapshot){

              if(!snapshot.hasData){
                return Text('Loading Data, please wait');
              }else{
                return  PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.9, initialPage: 1),
            itemCount: 5,
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(context, carouselIndex, itemIndex, snapshot);
            },
          );
              }

            },
          )
          
        )
        ],
    );
  }
          
          

  Widget _buildCarouselItem(
      BuildContext context, int carouselIndex, int itemIndex, AsyncSnapshot snapshot) {
    return GestureDetector(
      
     onTap: ()=>_openDetailPage(context, snapshot.data.documents[itemIndex]),
      //child: Padding(
      //padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        
        padding: EdgeInsets.symmetric( horizontal: 10.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 160.0,
                width: double.infinity,
                child: Image.asset('assets/food.jpg', fit: BoxFit.cover)),
          
            Container(
              padding: EdgeInsets.only(top: 10.0, ),
              color: Color(0xFFFFFFFF),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          width: 125,
                         
                          child:  Text(snapshot.data.documents[itemIndex]['title'],
                          
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .merge(TextStyle(fontSize: 14.0))),)
                       
                       
                      
                      ],
                    ),
                  ),
                  SizedBox( 
                    width: 80.0,
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                      Text(snapshot.data.documents[itemIndex]['favouriteCount'].toString(),style: TextStyle(fontSize: 16.0),),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ));
    
  }

  Widget _buildListHeader(String left, String right) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, top: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          color: Colors.pinkAccent[200],
          child: Text(
            left,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10.0, top: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: InkWell(
            onTap: () {},
            child: Text(
              right,
              style: TextStyle(
                color: Colors.pinkAccent[200],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  
   _getCarousal(int carouselIndex){
        switch(carouselIndex){
             
             case 0 : return GetRecipesService().getLatest();
                      break;
             case 1:  return  GetRecipesService().getfavourite();
                      break;

             default: return GetRecipesService().getByCategory(_category[carouselIndex]);


        }

   }


   _openDetailPage(BuildContext context, DocumentSnapshot document) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Detail(document)
    ));
  }
}




