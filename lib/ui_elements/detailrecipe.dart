import 'dart:io';
import 'package:cooky/models/recipeHalf.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/ui_elements/Youtube_Player.dart';
import 'package:cooky/widget/NoNetworkWidget.dart';
import 'package:cooky/widget/hasError.dart';
import 'package:cooky/widget/recipecard_detail.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'AuthorDetail.dart';
import 'FullScreenDialog.dart';
import 'MeterPainter.dart';
import 'NutritionScreenDailog.dart';

class DetailScreen extends StatefulWidget {
  final RecipeHalf recipe;
  final MainModel model;
  DetailScreen(this.recipe, this.model);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  double _yellowCirclefraction = 0.0;
  double _redCirclefraction = 0.0;
  double _greenCirclefraction = 0.0;
  Animation<double> yellowCircleAnimation;
  Animation<double> redCircleAnimation;
  Animation<double> greenCircleAnimation;

  AnimationController controller;

  void initState() {

    widget.model.checkConnection().whenComplete(() =>
    widget.model
        .fetchRecipeFull(widget.recipe.referenceId)
        .whenComplete(() => _startAnimation()));
    super.initState();
  }

  void _startAnimation() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    yellowCircleAnimation = Tween(begin: 0.0, end: widget.model.recipeFull.heathIndex[0]).animate(controller)
      ..addListener(() {
        setState(() {
          _yellowCirclefraction = yellowCircleAnimation.value;
        });
      });
    redCircleAnimation = Tween(begin: 0.0, end: widget.model.recipeFull.heathIndex[1]).animate(controller)
      ..addListener(() {
        setState(() {
          _redCirclefraction = redCircleAnimation.value;
        });
      });
    greenCircleAnimation = Tween(begin: 0.0, end: widget.model.recipeFull.heathIndex[2]).animate(controller)
      ..addListener(() {
        setState(() {
          _greenCirclefraction = greenCircleAnimation.value;
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
           widget.model.isLoading?Container():widget.model.hasError?Container(): FlatButton.icon(
              icon: Icon(Icons.play_circle_filled, color: Colors.red),
              label: Text("Watch Recipe"),
              onPressed: () {
                _openYouTubePage(context);
                // Toast.show("This feature will be available soon", context,
                //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            )
          ],
        ),
        body: ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
          return model.hasError? HasError(model): model.get_isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : !model.get_isConnected
                  ? NoNetwork(model)
                  : Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView(
                            //padding: EdgeInsets.all(20.0),
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: RecipeCardDetail(widget.recipe),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 10, top: 20, bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        widget.recipe.title.toUpperCase(),
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Author:",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          InkWell(
                                            child: Text(
                                              model.get_recipeFull.authorName,
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.redAccent),
                                            ),
                                            onTap: () {
                                              _openDetailPage(
                                                  context,
                                                  model.get_recipeFull
                                                      .authorName,
                                                  model);
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Introduction",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text(model.get_recipeFull.introduction,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15)),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                height: 30,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.dock),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text("65%")
                                        ],
                                      ),
                                    ),
                                    VerticalDivider(),
                                    Expanded(
                                      child: Text(
                                        "Vegetarian",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    VerticalDivider(),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.timer),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text("10 min")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    "Nutritional Information",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    height: height * 0.34,
                                    child: Card(
                                      elevation: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              height: height * 0.06,
                                              width: width * 0.7,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Nutritional Balance",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                  // height: 150,
                                                  //width: 100,
                                                  child: CustomPaint(
                                                child: Image.asset(
                                                    "assets/circe.png",
                                                    height: height * 0.18,
                                                    width: width * 0.33),
                                                painter: MeterPainter(
                                                    _yellowCirclefraction,
                                                    _redCirclefraction,
                                                    _greenCirclefraction),
                                              )),
                                              // SizedBox(width: 5),
                                              Expanded(
                                                //padding: EdgeInsets.all(10),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      "Nutrition Traffic light according to",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    InkWell(
                                                      //  onTap:
                                                      child: Text(
                                                        "Healthy Eating Plate method.",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                      onTap: () {
                                                        _showFullDialog();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                        ],
                                      ),
                                    )),
                                SizedBox(height: 25),
                                Container(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    height: height * 0.30,
                                    child: Card(
                                      elevation: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 5),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                  height: height * 0.06,
                                                  width: width * 0.64,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "Nutritional Values",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16),
                                                    ),
                                                  )),
                                              SizedBox(width: 0.027 * width),
                                              Container(
                                                  height: height * 0.06,
                                                  width: width * 0.25,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: FlatButton.icon(
                                                        onPressed: () {
                                                          _showNutritionDialog(model, model.get_recipeFull.nutritionId);
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          size: 40,
                                                        ),
                                                        label: Text(""),
                                                      )))
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              //  SizedBox(
                                              //    width:5,
                                              //  ),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Image.asset(
                                                        "assets/carbo.png",
                                                        height: height * 0.045,
                                                        width: width * 0.084,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      child: Image.asset(
                                                        "assets/proteins.png",
                                                        height: height * 0.045,
                                                        width: width * 0.084,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      child: Image.asset(
                                                        "assets/vitamins.png",
                                                        height: height * 0.045,
                                                        width: width * 0.084,
                                                      ),
                                                    ),
                                                  ]),
                                              // SizedBox(width: 10,),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                        child: Text(
                                                      "Value in grams of the main \n"
                                                      "nutrients of the dish and \n"
                                                      "percentage covered of \n"
                                                      "your daily needs.\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15),
                                                    ))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))
                              ]),
                              SizedBox(
                                height: 30.0,
                              ),
                              Center(
                                //padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  "Ingridients",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: ingridientsView(
                                    model.get_recipeFull.ingredients),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Center(
                                //padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  "Directions",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 5, right: 20),
                                child: preparationView(
                                    model.get_recipeFull.directions),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
        }));
  }

  Widget preparationView(List<String> preparationSteps) {
    List<Widget> textElements = List<Widget>();
    int i = 1;
    preparationSteps.forEach((value) {
      textElements.add(
        _buildStep(
          leadingTitle: "0${i.toString()}",
          title: "Step".toUpperCase(),
          content: value.toString(),
        ),
      );
      // Add spacing between the lines:
      textElements.add(
        SizedBox(
          height: 15.0,
        ),
      );
      i++;
    });
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      children: textElements,
    );
  }

  Widget _buildStep({String leadingTitle, String title, String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Colors.red,
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Text(leadingTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0)),
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              SizedBox(
                height: 10.0,
              ),
              Text(content, style: TextStyle(fontSize: 15)),
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showFullDialog() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new FullScreenDialog();
        },
        fullscreenDialog: true));
  }

  _openYouTubePage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                YoutubePlayerScreen())); //  AuthorDetailScreen(author.name,model)));
  }

  void _openDetailPage(BuildContext context, String author, MainModel model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AuthorDetailScreen(author, model)));
  }

  void _showNutritionDialog(MainModel model,String id) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new NutritionScreenDialog(model,id);
        },
        fullscreenDialog: true));
  }
}

@override
Widget ingridientsView(List<String> ingredients) {
  List<Widget> children = new List<Widget>();
  ingredients.forEach((item) {
    children.add(
      new Row(
        children: <Widget>[
          new Icon(Icons.done),
          new SizedBox(width: 5.0),
          new Text(item.toString()),
        ],
      ),
    );
    // Add spacing between the lines:
    children.add(
      new SizedBox(
        height: 5.0,
      ),
    );
  });
  return ListView(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    children: children,
  );
}
