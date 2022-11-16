import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider with ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount googleAccount;
  GoogleSignInAuthentication auth;

  Future<void> login() async {
    print('Start google login');
    this.googleAccount = await _googleSignIn.signIn();
    if(googleAccount==null){
      notifyListeners();
      return;
    }
     notifyListeners();
    auth = await googleAccount.authentication;
    print('displayName===>${googleAccount.displayName}\n');
    print('end google login');

    notifyListeners();
  }

  logout() async {
    if(_googleSignIn.isSignedIn()==true)
    this.googleAccount = await _googleSignIn.signOut();
    notifyListeners();
  }
}
