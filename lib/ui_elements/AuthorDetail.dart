
import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/widget/NoNetworkWidget.dart';
import 'package:cooky/widget/hasError.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AuthorDetailScreen extends StatefulWidget {
  final MainModel model;
  final String authorName;

  AuthorDetailScreen(this.authorName, this.model);

  AuthorDetailState createState() => new AuthorDetailState();
}

class AuthorDetailState extends State<AuthorDetailScreen> {
  @override
  void initState() {
    widget.model.checkConnection().whenComplete(() => widget.model.getauthorbyName(widget.authorName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 3.0,
          backgroundColor: Colors.white,
          title: Text(
            widget.authorName,
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
          return  model.hasError? HasError(model):  model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                ): !model.isConnected?NoNetwork(model)
              : SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 25, right: 25),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: height*0.179,
                            child: Row(
                                //crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(width: 10),
                                  Expanded(
                                      flex: 1,
                                      child: ClipOval(
                                        child: Image.network(
                                          widget.model.get_authorbyName.imageUrl,
                                          width: width*0.23,
                                          height: height*0.134,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  SizedBox(width: 15),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              widget.model.get_authorbyName.name,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            SizedBox(height: 8),
                                            Row(children: <Widget>[
                                              Icon(
                                                Icons.star,
                                                color: Colors.redAccent,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.redAccent,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.redAccent,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.redAccent,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.redAccent,
                                              ),
                                            ]),
                                           ]))
                                ]),
                          ), //
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            widget.model.get_authorbyName.discription,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                                Expanded(
                                  flex: 2,
                                child: IconButton(
                                  color: Colors.red,
                                  icon: Icon(MdiIcons.link,size: 30,),
                                  onPressed: () {
                                    //  _launchURL("https://facebook.com/lohanidamodar");
                                  },
                                ),
                              ),
                               Expanded(
                                 flex: 6,
                                child:Container(
                                  padding: EdgeInsets.only(top:10),
                                  child: Text(
                                 "www.cookyourrecipe.com",
                                  style: TextStyle(color: Colors.blueAccent),
                                         
                                ),
                                ),
                              ),
                             ], 
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(width: 30.0),
                              Expanded(
                                child: IconButton(
                                  color: Colors.red,
                                  icon: Icon(MdiIcons.youtube,size: 40,),
                                  onPressed: () {
                                    //  _launchURL("https://facebook.com/lohanidamodar");
                                  },
                                ),
                              ),

                              //  SizedBox(width: 5.0),
                              Expanded(
                                child: IconButton(
                                  color: Colors.indigo,
                                  icon: Icon(MdiIcons.facebook,size: 30,),
                                  onPressed: () {
                                    // _launchURL("https://github.com/lohanidamodar");
                                  },
                                ),
                              ),

                              // SizedBox(width: 5.0),
                              Expanded(
                                child: IconButton(
                                  color: Colors.red,
                                  icon: Icon(MdiIcons.instagram,size: 30,),
                                  onPressed: () {
                                    //_launchURL("https://youtube.com/c/reactbits");
                                  },
                                ),
                              ),

                              SizedBox(width: 30.0),
                            ],
                          ),
                        ],
                      )),
                );
        }));
  }
}
