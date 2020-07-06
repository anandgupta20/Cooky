import 'package:cooky/models/author.dart';
import 'package:cooky/widget/NoNetworkWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
import 'AuthorDetail.dart';

class OurParteners extends StatefulWidget {
  final MainModel model;
  OurParteners(this.model);

  OurPartenersState createState() {
    return new OurPartenersState();
  }
}

class OurPartenersState extends State<OurParteners> {
  @override
  void initState() {
    widget.model
        .checkConnection()
        .whenComplete(() => widget.model.getauthorList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Parteners"),
        backgroundColor: Colors.redAccent,
      ),
      body: listCards(context),
    );
  }

  Widget listCards(BuildContext context) {
    return Container(child: ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : !model.isConnected
                ? NoNetwork(model)
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.model.get_allAuthor.length,
                    itemBuilder: (BuildContext context, int index) {
                      return makeCard(
                          context, widget.model.get_allAuthor, index, model);
                    },
                  );
      },
    ));
  }

  Widget makeCard(
      BuildContext context, List<Author> authors, int index, MainModel model) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Column(
      children: <Widget>[
        Center(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () => _openDetailPage(context, authors[index], model),
            child: Container(
              height: height * 0.19,
              child: Card(
                child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: ClipOval(
                            child: Image.network(
                              authors[index].imageUrl,
                              width: width * 0.22,
                              height: height * 0.14,
                              fit: BoxFit.cover,
                            ),
                          )),
                      SizedBox(width: 15),
                      Expanded(
                          flex: 2,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  authors[index].name,
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
                                ])
                              ]))
                    ]),
              ),
            ), //
          ),
        ),
      ],
    );
  }

  _openDetailPage(BuildContext context, Author author, MainModel model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                AuthorDetailScreen(author.name, model)));
  }

  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => OurParteners(model)));
  //     //  AuthorDetailScreen(author.name,model)));
  // }

}
