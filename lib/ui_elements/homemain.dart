import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/ui_elements/category.dart';
import 'package:cooky/ui_elements/hometab.dart';
import 'package:cooky/ui_elements/favouritetab.dart';
import 'package:cooky/ui_elements/sharetab.dart';
import 'drawer/home_drawer.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final MainModel model;
  HomePage(this.model);
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _children = [];
  List<String> _appBarTitle = ['Home', 'Categories', 'Explore', 'Share'];
  final DocumentReference docRef =
      Firestore.instance.collection('India').document('categorycount');
  final List<int> categorycount = [];

  @override
  void initState() {
    widget.model.fetchRecipe();
    _children.add(HomeTab());
    _children.add(Category());
    _children.add(DisplayfavouriteTab());
    _children.add(ShareTab());

    _buildAppBar();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      drawer: HomeDrawer(),
    );
  }

  Widget _buildAppBar() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            iconTheme: new IconThemeData(color: Colors.redAccent),
            actions: <Widget>[],
            floating: true,
            pinned: true,
            snap: true,
            centerTitle: true,
            title: Text(
              _appBarTitle[_currentIndex],
              style: TextStyle(color: Colors.black),
            ),
          ),
        ];
      },
      body: _children[_currentIndex],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      // selectedItemColor: Colors.pinkAccent[200],
      onTap: _onTabTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.category), title: Text("Categories")),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite), title: Text("Favourite")),
        BottomNavigationBarItem(icon: Icon(Icons.edit), title: Text("Share")),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
    );
  }

  _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
