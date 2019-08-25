import 'package:flutter/material.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserlState createState() => _RegisterUserlState();
}

class _RegisterUserlState extends State<RegisterUser> {
  String _userName = "";
  String _userEmail = "";
  String _userMobileNo = "";

  final _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                'Welcome',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
            ),
            Text(
              "Great to see you !",
              style: TextStyle(color: Colors.grey[800], fontSize: 12),
            ),
          ],
        ),
        Container(
            padding: EdgeInsets.all(20),
            child: Builder(
                builder: (context) => Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              autofocus: true,
                              decoration:
                                  InputDecoration(labelText: 'Full Name'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                              },
                              onSaved: (val) => setState(() => _userName = val),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Text(
                              "Mobile Number",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[600]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  width: 80,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.white70,
                                        height: 35,
                                        width: 65,
                                        padding: EdgeInsets.only(
                                            top: 5, bottom: 5, left: 5),
                                        child: DropdownButton<String>(
                                          //  value: _countryCode,
                                          // iconSize: 30,

                                          items: <String>[
                                            '+91',
                                            '+42',
                                            '+73',
                                            '+94',
                                            '+25',
                                            '+76',
                                            '+17',
                                            '+48',
                                            '+90',
                                            '+10',
                                            '+11',
                                            '+12'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              // _countryCode = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: 0,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.grey,
                                            width: 2.0,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5),
                                  width: 220,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 5),
                                        child: TextFormField(
                                          autofocus: true,
                                          keyboardType: TextInputType.number,
                                          // controller: _phoneNumberController,
                                          style: TextStyle(color: Colors.black),
                                          cursorColor: Colors.grey,
                                          decoration: InputDecoration(
                                            hintText: "Mobile Number",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            fillColor: Colors.grey[300],
                                            border: InputBorder.none,

                                            // enabledBorder: UnderlineInputBorder(borderSide: BorBderSide(color: Colors.grey))
                                          ),
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return 'Phone number (+x xxx-xxx-xxxx)';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: 0,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.grey,
                                            width: 2.0,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _userEmail = val),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: MaterialButton(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 13, bottom: 13),
                                color: Colors.redAccent,
                                textColor: Colors.white,
                                textTheme: ButtonTextTheme.accent,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text('       Register        '),
                                onPressed: () {
                                  // _verifyPhoneNumber();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 75,
                            ),
                            Center(child:Column(children: <Widget>[
                              Text(
                              "Already have an account?",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 15),
                            ),
                             FlatButton(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              onPressed: () {},
                            )
                            ],) ,)
                            
                           
                          ],
                        ),
                      ),
                    )))
      ],
    ));
  }
}
