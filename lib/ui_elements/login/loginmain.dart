import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/models/auth.dart';
import 'package:toast/toast.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _passwordTextController = TextEditingController();

class LoginScreen3 extends StatefulWidget {
  @override
  _LoginScreen3State createState() => new _LoginScreen3State();
}

class _LoginScreen3State extends State<LoginScreen3>
    with TickerProviderStateMixin {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
  };

  AuthMode authMode = AuthMode.Login;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: _controller,
                physics: new AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  loginPage(context),
                  homePage(context),
                  signupPage(context)
                ],
                scrollDirection: Axis.horizontal,
              ))
        ],
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          labelText: "Email",
          border: OutlineInputBorder()),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "Password",
          border: OutlineInputBorder()),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "Confirm Password",
          border: OutlineInputBorder()),
      obscureText: true,
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Passwords do not match.';
        }
        return null;
      },
    );
  }

  void _submitForm(Function authenticate, BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      Navigator.of(context).pop();
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation =
        await authenticate(_formData['email'], _formData['password'], authMode);
    if (successInformation['success']) {
      if (authMode==AuthMode.Signup)
      {
        Toast.show(
                            " Signing Up Successfull !!! ",
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
      }
      Navigator.pushNamedAndRemoveUntil(context,'/home', (route) => false);
     // Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  Widget signupPage(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
     double width=MediaQuery.of(context).size.width;
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: 100.0, right: 100.0, top: 60, bottom: 50),
              child: Center(
                 child: Image.asset("assets/halflogo.png",height: 90,),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
              child: Column(
                children: <Widget>[
                  _buildEmailTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  _buildPasswordTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  _buildPasswordConfirmTextField(),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
              return Container(
                // padding: EdgeInsets.all(30),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.redAccent,
                  child: MaterialButton(
                    height: 0.075*height,
                      minWidth: 0.84*width,
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                     changeAuthModeSign();
                     // print(authMode),
                      _submitForm(model.authenticate, context);
                    },
                    child: Text(
                      "Signup",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget homePage(BuildContext context) {
     double height=MediaQuery.of(context).size.height;
     double width=MediaQuery.of(context).size.width;
    return new Container(

      decoration: BoxDecoration(
        color: Colors.redAccent,
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: height*0.23),
            child: Center(
              child: Image.asset("assets/colorlogo.png",height:height*0.14,),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Cooky",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return model.isLoading
                ? Container(
                    padding: EdgeInsets.only(top:0.14*height),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                : Column(
                    children: <Widget>[
                      Container(
                        //width: MediaQuery.of(context).size.width,
                        margin:  EdgeInsets.only(
                            left: 30.0, right: 30.0, top:height*0.11),
                        alignment: Alignment.center,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0)),
                                color: Colors.white,
                                //   highlightedBorderColor: Colors.white,
                                onPressed: (){
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      });
                                  googlesignIn(
                                      model.signInWithGoogle(), context);
                                },
                                child: new Container(
                                  padding:  EdgeInsets.symmetric(
                                    vertical: 0.017*height,
                                    horizontal:0.028*width,
                                  ),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Expanded(
                                        flex: 1,
                                        child: Image.asset(
                                          "assets/googleicon.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                      new Expanded(
                                        flex: 3,
                                        child: Text(
                                          "SIGNIN WITH GOOGLE",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 30.0),
                        alignment: Alignment.center,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new OutlineButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Colors.redAccent,
                                highlightedBorderColor: Colors.white,
                                onPressed: () => gotoSignup(),
                                child: new Container(
                                  padding:  EdgeInsets.symmetric(
                                    vertical: 0.03*height,
                                    horizontal: 0.06* width,
                                  ),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: Text(
                                          "SIGN UP",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 30.0),
                        alignment: Alignment.center,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Colors.white,
                                onPressed: () => gotoLogin(),
                                child: new Container(
                                  padding:  EdgeInsets.symmetric(
                                   vertical: 0.03*height,
                                    horizontal: 0.06* width,
                                  ),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: Text(
                                          "LOGIN",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
          })
        ],
      ),
    );
  }

  Widget loginPage(BuildContext context) {
     double height=MediaQuery.of(context).size.height;
     double width=MediaQuery.of(context).size.width;
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: 100.0, right: 100.0, top: 80, bottom: 50),
                child: Center(
                  child: Image.asset("assets/halflogo.png",height: 90,),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 15),
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(height: 20),
                    _buildPasswordTextField(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: new FlatButton(
                      child: new Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      onPressed: () {
                        Toast.show(
                            "This feature will be available soon.Till then please remember your password",
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ScopedModelDescendant<MainModel>(builder:
                  (BuildContext context, Widget child, MainModel model) {
                return Container(
                  // padding: EdgeInsets.all(30),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.redAccent,
                    child: MaterialButton(
                      height: 0.075*height,
                      minWidth: 0.84*width,
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        changeAuthModeLog();
                       // print(authMode),
                        _submitForm(model.authenticate, context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ));
  }

  void googlesignIn(Future<String> googlesignIn, BuildContext context) async {
    String info = await googlesignIn;
    print(info.toString());
    if (info == "Success") {
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.of(context).pop();
      Toast.show("Something went wrong", context);
    }
  }

  void changeAuthModeSign() {
    if (authMode == AuthMode.Login) {
      setState(() {
        authMode = AuthMode.Signup;
      });
    }
  }

  void changeAuthModeLog() {
    if (authMode == AuthMode.Signup) {
      setState(() {
        authMode = AuthMode.Login;
      });
    }
  }

  void gotoLogin() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  void gotoSignup() {
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }
}
