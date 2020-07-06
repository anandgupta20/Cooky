import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/ui_elements/homemain.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cooky/ui_elements/login/loginmain.dart';
import 'package:scoped_model/scoped_model.dart';

//void main() => runApp(MyHomePage());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyHomePage());
  });
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<MyHomePage> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuthenticate();

    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });

    // _model.getrecipebyCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Open Sans',
            accentColor: Colors.redAccent,
            primaryColor: Colors.redAccent),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        //home: LoginScreen3(),
        routes: {
          '/': (BuildContext context) =>
              !_isAuthenticated ? LoginScreen3() : HomePage(_model),

          // '/': (BuildContext context) =>
          //  MyApp() ,
          // '/': (BuildContext context)=>DetailScreen(_model.recipeList, inFavorites),
          '/home': (BuildContext context) => HomePage(_model),
          // '/admin': (BuildContext context) => ProductsAdminPage(model),
        },
      ),
    );
  }
}
