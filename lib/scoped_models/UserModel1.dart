import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cooky/models/auth.dart';
import 'package:cooky/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ConnectedModel.dart';

class UserModel extends ConnectedModel {
  PublishSubject<bool> _userSubject = PublishSubject();

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  User get user {
    return authenticatedUser;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool hasError = true;
    String message = 'Something went wrong.';

    if (responseData.containsKey('idToken')) {
      if (mode == AuthMode.Signup) {
        final Map<String, dynamic> request_data = {
          'requestType': "VERIFY_EMAIL",
          'idToken': responseData['idToken'],
        };
        http.Response verification_Email = await http.post(
          'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
          body: json.encode(request_data),
          headers: {'Content-Type': 'application/json'},
        );
        final Map<String, dynamic> verify_response =
            json.decode(verification_Email.body);
        print(verify_response);
        message =
            "";
      } else {
        final Map<String, dynamic> id_VerifyData = {
          'idToken': responseData['idToken'],
        };
        http.Response is_Verify = await http.post(
          'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4',
          body: json.encode(id_VerifyData),
          headers: {'Content-Type': 'application/json'},
        );
        final Map<String, dynamic> verify_response =
            json.decode(is_Verify.body);
        // print("XXX"+verify_response['users'][0]['photoUrl']);

        if (!verify_response['users'][0]['emailVerified']) {
          message = 'Please Verify Your Email.';
        } else {
          hasError = false;
          message = 'Authentication succeeded!';
          authenticatedUser = User(
              id: responseData['localId'],
              email: email,
              token: responseData['idToken'],
              refreshtoken: responseData['refreshToken']);
          _userSubject.add(true);
          print("refreshToken");
          print(responseData['refreshToken']);
          //  final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', responseData['idToken']);
          prefs.setString('userEmail', email);
          prefs.setString('userId', responseData['localId']);
          prefs.setString('refreshtoken', responseData['refreshToken']);
        }
      }
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists.';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found.';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'The password is invalid.';
    }

    isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  Future<String> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = await GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    AuthResult res = await auth.signInWithCredential(credential);
    // Checking if email and name is null
    assert(res.user.email != null);
    assert(res.user.displayName != null);
    assert(res.user.photoUrl != null);
    IdTokenResult tokenp = await res.user.getIdToken(refresh: true);
    authenticatedUser = User(
      id: res.user.uid,
      email: res.user.email,
      token: tokenp.token,
      refreshtoken: null,
    );
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('token', tokenp.token);
    prefs.setString('userEmail', res.user.email);
    prefs.setString('userId', res.user.uid);
    prefs.setString('refreshtoken', null);

    return 'Success';
  }


  Future<void> autoAuthenticate() async {
    isLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString("userEmail");
    final String userId = prefs.getString("userId");
    final String refreshToken = prefs.getString("refreshtoken");
    final String token = prefs.getString('token');

    if (token != null && refreshToken != null) {
      print("in if loop");
      http.Response response = await http.post(
        "https://securetoken.googleapis.com/v1/token?key=AIzaSyARDt_hJ8_47_OEV0Ef4DqKuK7-A8rDgJ4",
        body: 'grant_type=refresh_token&refresh_token=${refreshToken}',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      final Map<String, dynamic> newresponseData = json.decode(response.body);
      print(newresponseData);
      authenticatedUser = User(
          id: userId,
          email: email,
          token: newresponseData['id_token'],
          refreshtoken: newresponseData['refresh_token']);
      prefs.setString('token', newresponseData['id_token']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', userId);
      prefs.setString('refreshtoken', newresponseData['refresh_token']);
      _userSubject.add(true);
      isLoading = false;
      notifyListeners();
    } else if (token != null && refreshToken == null) {
      FirebaseUser currentUser = await auth.currentUser();
      IdTokenResult tokenp = await currentUser.getIdToken(refresh: true);

      authenticatedUser = User(
          id: userId, email: email, token: tokenp.token, refreshtoken: null);
      _userSubject.add(true);
      isLoading = false;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  void logout() async {
    authenticatedUser = null;
    _userSubject.add(false);
    isLoading = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('refreshtoken') == null) {
      await googleSignIn.signOut();
      //print("google sign out");
    }
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
    prefs.remove('refreshtoken');
    // notifyListeners();
  }
}

//*******************************User Model Ends*************************************///
