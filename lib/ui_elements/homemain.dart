

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooky/ui_elements/categorytab.dart';
import 'package:cooky/ui_elements/hometab.dart';
import 'package:cooky/ui_elements/positiontab.dart';
import 'package:cooky/ui_elements/sharetab.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _children = [];
  List<String> _appBarTitle=['Home','Categories','Explore','Share'];
  final DocumentReference docRef =
      Firestore.instance.collection('India').document('categorycount');
       final List<int> categorycount = [];

  

  @override
  void initState() {
        docRef.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        categorycount.add(datasnapshot.data['Vegetarian']);
        categorycount.add(datasnapshot.data['Non Vegetarian']);
        categorycount.add(datasnapshot.data['Gujrati Recipes']);
        categorycount.add(datasnapshot.data['Malwa Recipes']);
        categorycount.add(datasnapshot.data['Punjabi Recipes']);
        categorycount.add(datasnapshot.data['South Indian Recipes']);
        categorycount.add(datasnapshot.data['Assamese Recipes']);
        categorycount.add(datasnapshot.data['Rajasthani Recipes']);
      }
    });

    

    _children.add(HomeTab());
    _children.add(CategoryTab(categorycount));
    _children.add(PositionsTab());
    _children.add(ShareTab());

     _buildAppBar();
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _buildAppBar(), 
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
     return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              //expandedHeight: 0.0,
              floating: true,
              pinned: true,
              snap: true,
              centerTitle:true, 
              title:Text(_appBarTitle[_currentIndex], style: TextStyle(color: Colors.black),),
              //centerTitle: 
              //flexibleSpace: FlexibleSpaceBar(
              //    centerTitle: true,
              //    title: Text("Collapsing Toolbar",
              //        style: TextStyle(
              //        color: Colors.white,
              //          fontSize: 16.0,
              //        )),
               //  ),
            ),
          ];
        },
       body: _children[_currentIndex],
        
      );
    
  }

 

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.pinkAccent[200],
      onTap: _onTabTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.category), title: Text("Category")),
        BottomNavigationBarItem(
            icon: Icon(Icons.explore), title: Text("Explore")),
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
