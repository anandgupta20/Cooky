import 'package:cooky/ui_elements/drawer/AboutUs.dart';
import 'package:cooky/ui_elements/drawer/TermAndcondi.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'OurParteners.dart';

class Profile extends StatefulWidget {
  final MainModel _model;
  Profile(this._model);
  @override
  ProfileState createState() => new ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    widget._model.get_preferences();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: height * 0.22,
            width: width,
            color: Colors.redAccent,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Welcome!",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  model.user.email,
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
            leading: Icon(Icons.pan_tool),
            title: Text('Preferences'),
            onTap: () {
              _preDialog(context, model);
            },
          ),
          Divider(
            height: 5,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
            leading: Icon(Icons.share),
            title: Text('Share App'),
            onTap: () {
              Share.share("App Link");
            },
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
            leading: Icon(Icons.rate_review),
            title: Text('Rate Us'),
            onTap: () {
              _launchURL();
            },
          ),
          Divider(height: 2),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
            leading: Icon(Icons.help_outline),
            title: Text('About us'),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Aboutus()));
            },
          ),
          Divider(height: 2),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
            leading: Icon(Icons.people),
            title: Text('Our Partners'),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new OurParteners(model)));
            },
          ),
          Divider(height: 2),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
            leading: Icon(Icons.library_books),
            title: Text('Terms of use'),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new TermAndcondi()));
            },
          ),
          Divider(height: 2),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
            leading: Icon(Icons.phone),
            title: Text('Contact Us'),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Aboutus()));
            },
          ),
          Divider(height: 2),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/',(route)=>false);
              model.logout();
            },
          ),
          Divider(height: 2),
        ],
      );
    });
  }
}

_launchURL() async {
  const url = 'https://play.google.com/store/apps/details?id=com.anand.cooky';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_preDialog(BuildContext context, MainModel model) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return PreDialog(model);
      });
}

class PreDialog extends StatefulWidget {
  final MainModel model;
  PreDialog(this.model);
  @override
  PreDialogState createState() => new PreDialogState();
}

class PreDialogState extends State<PreDialog> {
  String cur_pre;
  @override
  void initState() {
    super.initState();
    cur_pre = widget.model.get_cur_pre;
    //widget.model.checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Center(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
       
          height: height * 0.5,
          width: width * 0.3,
          child: Column(children: <Widget>[
            SizedBox(height: 0.03 * height),
            Text("Show Me",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 0.03 * height),
            Container(
              child: Column(children: <Widget>[
                RadioListTile<String>(
                  title: const Text('Only Vegetarian Recipes'),
                  value: 'Veg',
                  groupValue: cur_pre,
                  onChanged: (value) {
                    setState(() {
                      widget.model.save_preferences(value);
                      cur_pre = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Only Non-Vegetarian Recipes'),
                  value: 'Non-Veg',
                  groupValue: cur_pre,
                  onChanged: (value) {
                    setState(() {
                      widget.model.save_preferences(value);
                      cur_pre = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Both Recipes'),
                  value: 'Both',
                  groupValue: cur_pre,
                  onChanged: (value) {
                    setState(() {
                      widget.model.save_preferences(value);
                      cur_pre = value;
                    });
                  },
                ),
              ]),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  ///icon: Icon(Icons.play_circle_filled, color: Colors.red),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  child: Text("Ok"),
                  onPressed: () {
                    widget.model.fetchRecipeHalf();
                    Navigator.of(context).pop();
                    Toast.show(
                        "Your preference is succesfully updated.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  },
                )),
          ]),
        ),
      ),
    );
  }
}
