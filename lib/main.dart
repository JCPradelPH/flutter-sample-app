import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'components/ab_popup_menu.dart';
import 'utils/ab_menu_adapter.dart';

void main() => runApp(new HomePageContainer());

class HomePageContainer extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'MPA Development',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(title: 'MPA Devel'),
    );
  }
}

class HomePage extends StatefulWidget{

  final String title;

  final menuList = const <MenuAdpater>[
    const MenuAdpater(
      title: 'Login with Facebook', 
      icon: FontAwesomeIcons.facebookSquare,
      iconColor: const Color.fromRGBO(0,91,171, 1.0),
      actionId: 0,
      flag: false
    ),
    const MenuAdpater(
      title: 'Sign In with Google', 
      icon: FontAwesomeIcons.googlePlusSquare,
      iconColor: const Color.fromRGBO(200,50,0, 1.0),
      actionId: 1,
      flag: false
    ),
    const MenuAdpater(
      title: 'Email Login', 
      icon: FontAwesomeIcons.envelopeSquare,
      iconColor: const Color.fromRGBO(150,150,50, 1.0),
      actionId: 2,
      flag: false
    ),
    const MenuAdpater(
      title: 'My Profile', 
      icon: FontAwesomeIcons.userCircle,
      iconColor: const Color.fromRGBO(150,150,50, 1.0),
      actionId: 3,
      flag: true
    ),
  ];

  final _googleSignIn = new GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);
  final FacebookLogin facebookSignIn = new FacebookLogin();
  final _auth = FirebaseAuth.instance;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _State createState() => new _State();
}

class _State extends State<HomePage>{

  Widget _bodyContent = new Column(
    children: [
      new Text('Hello'),
      new Text('World')
    ]
  );
  
  bool _isLoggedIn = false;
  FirebaseUser _authUser = null;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: [
          new ABPopUpMenu(
            widget.menuList.where( (menu) => menu.flag==_isLoggedIn ).toList(),
            onSelect: _onSelect
          )
        ]
      ),
      body: _bodyContent,
    );
  }

  _onSelect(MenuAdpater menuItem) {
    switch(menuItem.actionId){
      case 0:// Login via Facebook
        _handleFacebookLogin()
          .then( (data) => setState( (){ 
            print("Facebook-----------------------------------------");
            print(data);
            print("-----------------------------------------");
            _authUser = data;
            _isLoggedIn=true; 
          } ) )
          .catchError( (err) => print('err $err') );
      break;
      case 1:// SignIn Via Google
        _handleGoogleSignIn()
          .then( (data) => setState( (){
            print("Google-----------------------------------------");
            print(data);
            print("-----------------------------------------");
            _isLoggedIn=true;
            _authUser = data;
          } ) )
          .catchError( (err) => print('err $err') );
      break;
      case 2:// Login via Email
        // show login via email page
      break;
      case 3:// My Profile
        setState( (){ _isLoggedIn=false; } );
      break;
    }
  }

  _handleGoogleSignIn() async {
    GoogleSignInAccount user = widget._googleSignIn.currentUser;
    if (user == null) user = await widget._googleSignIn.signInSilently();
    if (user == null) {
      final GoogleSignInAccount googleUser = await widget._googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final FirebaseUser user = await widget._auth.signInWithGoogle(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("Google-----------------------------------------");
      print(user);
      print("-----------------------------------------");
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await widget._auth.currentUser();
      assert(user.uid == currentUser.uid);
    }
    return user;
  }


  _handleFacebookLogin() async{
    final FacebookLoginResult result =
      await widget.facebookSignIn.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final FirebaseUser user = await widget._auth.signInWithFacebook(
          accessToken: accessToken.token
        );
        print("Facebook-----------------------------------------");
        print(user);
        print("-----------------------------------------");
        assert(user.email != null);
        assert(user.displayName != null);
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final FirebaseUser currentUser = await widget._auth.currentUser();
        assert(user.uid == currentUser.uid);
        return user;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }
}