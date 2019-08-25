import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:cooky/models/auth.dart';


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
      // decoration: InputDecoration(
      //     labelText: 'E-Mail', filled: true, fillColor: Colors.white),
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
      // decoration: InputDecoration(
      //     labelText: 'Password', filled: true, fillColor: Colors.white),
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

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation =
        await authenticate(_formData['email'], _formData['password'], authMode);
    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
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
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: 100.0, right: 100.0, top: 60, bottom: 50),
              child: Center(
                child: Icon(
                  Icons.headset_mic,
                  color: Colors.redAccent,
                  size: 50.0,
                ),
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
                    height: 10,
                  ),
                ],
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: new FlatButton(
                    child: new Text(
                      "Already have an account ?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
              return model.isLoading
                 ? Center(child: CircularProgressIndicator())
                   : Container(
                      // padding: EdgeInsets.all(30),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.redAccent,
                        child: MaterialButton(
                          height: 50,
                          minWidth: 300,
                          onPressed: () => {
                                changeAuthModeSign(),
                                print(authMode),
                                _submitForm(model.authenticate)
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
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 200.0),
            child: Center(
              child: Icon(
                Icons.headset_mic,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Awesome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "App",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.redAccent,
                    highlightedBorderColor: Colors.white,
                    onPressed: () => gotoSignup(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
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
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => gotoLogin(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
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
      ),
    );
  }

  Widget loginPage(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('assets/images/mountains.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: 100.0, right: 100.0, top: 60, bottom: 50),
                child: Center(
                  child: Icon(
                    Icons.headset_mic,
                    color: Colors.redAccent,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
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
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ScopedModelDescendant<MainModel>(builder:
                  (BuildContext context, Widget child, MainModel model) {
                return model.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        // padding: EdgeInsets.all(30),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.redAccent,
                          child: MaterialButton(
                            height: 50,
                            minWidth: 300,
                            onPressed: () => {
                                  changeAuthModeLog(),
                                  print(authMode),
                                  _submitForm(model.authenticate)
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
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        margin: EdgeInsets.all(8.0),
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.25)),
                      ),
                    ),
                    Text(
                      "OR CONNECT WITH",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    new Expanded(
                      child: new Container(
                        margin: EdgeInsets.all(8.0),
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.25)),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        margin: EdgeInsets.only(right: 8.0),
                        alignment: Alignment.center,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new FlatButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                color: Color(0Xff3B5998),
                                onPressed: () => {},
                                child: new Container(
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new FlatButton(
                                          onPressed: () => {},
                                          padding: EdgeInsets.only(
                                            top: 20.0,
                                            bottom: 20.0,
                                          ),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                const IconData(0xea90,
                                                    fontFamily: 'icomoon'),
                                                color: Colors.white,
                                                size: 15.0,
                                              ),
                                              Text(
                                                "FACEBOOK",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
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
                    ),
                    new Expanded(
                      child: new Container(
                        margin: EdgeInsets.only(left: 8.0),
                        alignment: Alignment.center,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new FlatButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                color: Color(0Xffdb3236),
                                onPressed: () => {},
                                child: new Container(
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: new FlatButton(
                                          onPressed: () => {},
                                          padding: EdgeInsets.only(
                                            top: 20.0,
                                            bottom: 20.0,
                                          ),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Icon(
                                                const IconData(0xea88,
                                                    fontFamily: 'icomoon'),
                                                color: Colors.white,
                                                size: 15.0,
                                              ),
                                              Text(
                                                "GOOGLE",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  changeAuthModeSign() {
    if (authMode == AuthMode.Login) {
      setState(() {
        authMode = AuthMode.Signup;
      });
    }
  }

  changeAuthModeLog() {
    if (authMode == AuthMode.Signup) {
      setState(() {
        authMode = AuthMode.Login;
      });
    }
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }
}

// new Row(
//   children: <Widget>[
//     new Expanded(
//       child: new Padding(
//         padding: const EdgeInsets.only(left: 40.0),
//         child: new Text(
//           "EMAIL",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.redAccent,
//             fontSize: 15.0,
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
// new Container(
//   width: MediaQuery.of(context).size.width,
//   margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
//   alignment: Alignment.center,
//   decoration: BoxDecoration(
//     border: Border(
//       bottom: BorderSide(
//           color: Colors.redAccent,
//           width: 0.5,
//           style: BorderStyle.solid),
//     ),
//   ),
//   padding: const EdgeInsets.only(left: 0.0, right: 10.0),
//   child: new Row(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: <Widget>[
//       new Expanded(
//         child: TextField(
//           obscureText: true,
//           textAlign: TextAlign.left,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: 'samarthagarwal@live.com',
//             hintStyle: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
// Divider(
//   height: 24.0,
// ),
// new Row(
//   children: <Widget>[
//     new Expanded(
//       child: new Padding(
//         padding: const EdgeInsets.only(left: 40.0),
//         child: new Text(
//           "PASSWORD",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.redAccent,
//             fontSize: 15.0,
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
// new Container(
//   width: MediaQuery.of(context).size.width,
//   margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
//   alignment: Alignment.center,
//   decoration: BoxDecoration(
//     border: Border(
//       bottom: BorderSide(
//           color: Colors.redAccent,
//           width: 0.5,
//           style: BorderStyle.solid),
//     ),
//   ),
//   padding: const EdgeInsets.only(left: 0.0, right: 10.0),
//   child: new Row(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: <Widget>[
//       new Expanded(
//         child: TextField(
//           obscureText: true,
//           textAlign: TextAlign.left,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: '*********',
//             hintStyle: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
// Divider(
//   height: 24.0,
// ),
