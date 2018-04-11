import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialMediaAuth{
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  static final _auth = FirebaseAuth.instance;
  static final _googleSignIn = new GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  static execFacebookLogin() async{
    return _getFBUser(await _fbLogResult());
  }

  static _getFBUser(result) async{
    assert(result.status==FacebookLoginStatus.loggedIn);
    return await _firebaseFBUser(result.accessToken.token);
  }

  static _firebaseFBUser(token) => _auth.signInWithFacebook( accessToken: token );

  static _fbLogResult() => facebookSignIn.logInWithReadPermissions(['email','public_profile']);

  
  static execGoogleSignIn() async {
    GoogleSignInAuthentication gAuth = await _googleAuth();
    return await _auth.signInWithGoogle(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
  }

  static _googleAuth() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    return await googleUser.authentication;
  }
}