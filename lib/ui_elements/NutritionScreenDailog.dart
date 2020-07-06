import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/widget/NoNetworkWidget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class NutritionScreenDialog extends StatefulWidget {
  final MainModel model;
  final String nutritionId;

  NutritionScreenDialog(this.model,this.nutritionId);
  @override
  NutritionDialogState createState() => new NutritionDialogState();
}

class NutritionDialogState extends State<NutritionScreenDialog> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.model.getNutritonrbyId(widget.nutritionId);

    
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      ),
      body: ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
          return model.get_isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : !model.get_isConnected
                  ? NoNetwork(model): ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[     
            Column(
             // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              SizedBox(
              height:10,
              ),
              Container(
              child:Text("Nutritional Values",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
               ),    
             SizedBox(
              height:20,
              ),
              Container(
               child:Text("Calories",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
             ),
              SizedBox(
              height:10,
            ),
            _nutritionColumn("assets/carbo.png","Calories",model.get_NutritionbyId.calories.split('|')[0],model.get_NutritionbyId.calories.split('|')[1]),
             SizedBox(
              height:5,
            ),
             SizedBox(
              height:15,
            ),
            Container(
             child:Text("Macronutrients",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
             ),
             SizedBox(
              height:15,
            ),
            _nutritionColumn("assets/carbo.png","Carbohydrate",model.get_NutritionbyId.calories.split('|')[0],model.get_NutritionbyId.calories.split('|')[1]),
             SizedBox(
              height:5,
            ),
             _nutritionColumn("assets/proteins.png","Proteins",model.get_NutritionbyId.proteins.split('|')[0],model.get_NutritionbyId.proteins.split('|')[1]),
             SizedBox(
              height:5,
             ),
              _nutritionColumn("assets/fats.png","Fats",model.get_NutritionbyId.fats.split('|')[0],model.get_NutritionbyId.fats.split('|')[1]),
               SizedBox(
              height:15 ,
             ),
              Container(
              child:Text("How much fiber does it give me?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
              SizedBox(
               height:15,
              ),
              _nutritionColumn("assets/fibre.png","Fibre",model.get_NutritionbyId.fibre.split('|')[0],model.get_NutritionbyId.fibre.split('|')[1]),
              SizedBox(
              height:5,
             ),
              _nutritionColumn("assets/vitamins.png","Vitamins",model.get_NutritionbyId.vitamins.split('|')[0],model.get_NutritionbyId.vitamins.split('|')[1]),
               SizedBox(
              height:5,
             ),
              _nutritionColumn("assets/minerals.png","Minerals",model.get_NutritionbyId.minerals.split('|')[0],model.get_NutritionbyId.minerals.split('|')[1]),
              ],
            ),  
          ],
      );
    } )
    );
  }

  Widget _nutritionColumn(String icon,String nutrient,String weight,String percentage)
  {
    return  new Container(
              height: 50,
              width: double.maxFinite,
              margin: EdgeInsets.all(8),
              child:Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(icon,height: 30,width: 30,)
                    ),
                  Expanded(
                    flex: 3,
                    child: Text(nutrient)
                    ),
                  Expanded(
                    flex: 1,
                    child: Text(weight)
                    ),
                  Expanded(
                    flex: 1,
                     child: Text(percentage)
                    ),      
                ],
              ),  
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )     
             );
  }
}