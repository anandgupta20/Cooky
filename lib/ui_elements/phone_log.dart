import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class PhoneSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhoneSignInSectionState();
}

class _PhoneSignInSectionState extends State<PhoneSignInSection> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _message = '';
  String _verificationId;
  String _countryCode = "+91";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text('Login' ,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.redAccent),),
            margin: EdgeInsets.only(top: 50),
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
          ),
           Text("Great to see you again!", style: TextStyle(color: Colors.grey[800], fontSize: 12),),

          // Container(
          //   alignment:Alignment.centerLeft,
          //   child: Text("Mobile Number", style:TextStyle(color: Colors.pinkAccent[100], fontSize: 15)),
          // ),
          SizedBox(height: 70,),
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
                      padding: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                      child: DropdownButton<String>(
                        value: _countryCode,
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
                            _countryCode = value;
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
                width: 200,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _phoneNumberController,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          hintText: "Mobile Number",
                          hintStyle: TextStyle(color: Colors.grey),
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
          SizedBox(height: 50,),

          Text("We will send a 6 digit OTP to verify", style: TextStyle(color: Colors.grey[800], fontSize: 12),),
           SizedBox(height: 10,),
          MaterialButton(
            padding: EdgeInsets.only(left: 20, right: 20, top: 13, bottom: 13),
            color: Colors.redAccent,
            textColor: Colors.white,
            textTheme: ButtonTextTheme.accent,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text('       Next        '),
            onPressed: () {
              _verifyPhoneNumber();
            },
          ),
          // TextField(
          //   controller: _smsController,
          //   decoration: InputDecoration(labelText: 'Verification code'),
          // ),

          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 16.0),
          //   alignment: Alignment.center,
          //   child: RaisedButton(
          //     onPressed: () async {
          //       _signInWithPhoneNumber();
          //     },
          //     child: const Text('Sign in with phone number'),
          //   ),
          // ),
          // Container(
          //   alignment: Alignment.center,
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Text(
          //     _message,
          //     style: TextStyle(color: Colors.red),
          //   ),
          //)
           SizedBox(height: 120,),
           Text("Create a new account", style: TextStyle(color: Colors.grey[800], fontSize: 15),),
           FlatButton(
             child: Text("Register", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 20),),
             onPressed: (){},
           )

        ],
      )
      ),
    );
  }

  // Exmaple code of how to veify phone number
  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _message = 'Received phone auth credential: $phoneAuthCredential';
        print(_message);
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
        print(_message);
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      //widget._scaffold.showSnackBar(SnackBar(
      // content:
      print("kmgaeklgm");
      //  Text('Please check your phone for the verification code.'),
      // ));
      _verificationId = verificationId;
      print("kmgaek]");
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      print(_verificationId);
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneNumberController.text,
      timeout: const Duration(seconds: 0),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  // Example code of how to sign in with phone.
  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );
    print(credential);
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    
    print("object");

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        // _message = 'Successfully signed in, uid: ' + user.uid;
        //   Navigator.of(context).pushReplacement(MaterialPageRoute(
        //              builder: (_) =>FreeSamplePaper(),
        //           ));

        print(_message);
      } else {
        _message = 'Sign in failed';
        print(_message);
      }
    });
  }
}
