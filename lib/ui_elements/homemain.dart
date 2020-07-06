import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/ui_elements/Profile.dart';
import 'package:cooky/ui_elements/category.dart';
import 'package:cooky/ui_elements/hometab.dart';
import 'package:cooky/ui_elements/favouritetab.dart';
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
  List<String> _appBarTitle = ['Home', 'Categories', 'Favourite', 'Settings'];

  @override
  void initState() {
    super.initState();

    widget.model.checkConnection()
    .whenComplete(() => widget.model.get_preferences()
        .whenComplete(() => widget.model.fetchRecipeHalf()));
    // widget.model.fetchRecipe().whenComplete(() => );
    // widget.model.getrecipebyCategory("Vegetarian");
    //widget.model.getauthorList();
   
    _children.add(HomeTab(widget.model));
    _children.add(Category(widget.model));
    _children.add(DisplayfavouriteTab(widget.model));
    _children.add(Profile(widget.model));

    _buildAppBar();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
          body: _buildAppBar(),
          bottomNavigationBar: _buildBottomNavigationBar(),
          //drawer: HomeDrawer(),
        ));
  }

  Widget buildAppBar() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: appBar(),
        ),
        SingleChildScrollView(
          child: _children[_currentIndex],
        )
      ],
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
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text("Settings")),
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

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      new BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    Icons.menu,
                    color: Colors.redAccent,
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _appBarTitle[_currentIndex],
                  style: new TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
