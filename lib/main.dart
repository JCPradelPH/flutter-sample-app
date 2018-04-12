import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_view/map_view.dart';

import 'components/ab_popup_menu.dart';
import 'components/shared_components.dart';
import 'containers/map/map.dart';
import 'containers/screens/movies/movies_list.dart';
import 'containers/screens/users/users_list.dart';
import 'containers/user_profile/profile.dart';
import 'utils/global_adapter.dart';
import 'utils/push_notif_service.dart';
import 'utils/social_media_auth.dart';

void main(){
  runApp(new MainContainer());
}

  
class MainContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'MPA Development',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainPage(title: 'MPA Devel'),
    );
  }
}

class MainPage extends StatefulWidget{

  final String title;

  final menuList = const <MenuAdapter>[
    const MenuAdapter(
      title: 'Login with Facebook', 
      icon: FontAwesomeIcons.facebookSquare,
      iconColor: const Color.fromRGBO(0,91,171, 1.0),
      actionId: 0,
      flag: false
    ),
    const MenuAdapter(
      title: 'Sign In with Google', 
      icon: FontAwesomeIcons.googlePlusSquare,
      iconColor: const Color.fromRGBO(200,50,0, 1.0),
      actionId: 1,
      flag: false
    ),
    const MenuAdapter(
      title: 'Email Login', 
      icon: FontAwesomeIcons.envelopeSquare,
      iconColor: const Color.fromRGBO(150,150,50, 1.0),
      actionId: 2,
      flag: false
    ),
    const MenuAdapter(
      title: 'My Profile', 
      icon: FontAwesomeIcons.userCircle,
      iconColor: const Color.fromRGBO(150,150,50, 1.0),
      actionId: 3,
      flag: true
    ),
    const MenuAdapter(
      title: 'Map', 
      icon: FontAwesomeIcons.mapMarker,
      iconColor: const Color.fromRGBO(150,150,50, 1.0),
      actionId: 4,
      alwaysOn: true
    ),
    const MenuAdapter(
      title: 'Movies', 
      icon: FontAwesomeIcons.camera,
      iconColor: const Color.fromRGBO(150,150,50, 1.0),
      actionId: 5,
      alwaysOn: true
    ),
    const MenuAdapter(
      title: 'Contacts', 
      icon: FontAwesomeIcons.list,
      iconColor: const Color.fromRGBO(150,150,50, 1.0),
      actionId: 6,
      alwaysOn: true
    ),
  ];

  
  
  MainPage({Key key, this.title}) : super(key: key);

  @override
  _State createState() => new _State();
}

class _State extends State<MainPage>{

  Widget _bodyContent = new MoviesList();
  // Widget _bodyContent = new UsersList();
  
  bool _isLoggedIn = false, _isLoading = false;
  FirebaseUser _authUser;
  BuildContext _scaffoldContext;
  
  @override
  void initState() {
    super.initState();
    PushNotificationService.init(_onFirebaseMessage);
    print('INIT STATE==========================================');
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: [
          new ABPopUpMenu(
            widget.menuList.where( (menu) => menu.flag==_isLoggedIn || menu.alwaysOn ).toList(),
            onSelect: _onSelect
          )
        ]
      ),
      body: new Builder(
        builder: (BuildContext context){
          _scaffoldContext = context;
          return _isLoading ? loader() : _bodyContent;
        }
      )
    );
  }
  
  _onSelect(MenuAdapter menuItem) {
    setState((){ _isLoading=true; });
    switch(menuItem.actionId){
      case 0:// Login via Facebook
        _handleFacebookLogin();
      break;
      case 1:// SignIn Via Google
        _handleGoogleSignIn();
      break;
      case 2:// Login via Email
        // show login via email page
      break;
      case 3:// My Profile
        _navigateToProfile();
      break;
      case 4:// My Profile
        setState((){ _isLoading=false; });
        Location initialPos = new Location(12.8797, 121.7740);
        LocationMap.show(initialPos);
      break;
      case 5:// My Profile
        setState((){ 
          _isLoading=false; 
          _bodyContent = new MoviesList();
        });
      break;
      case 6:// My Profile
        setState((){ 
          _isLoading=false; 
          _bodyContent = new UsersList();
        });
      break;
    }
  }

  _handleGoogleSignIn() async {
    SocialMediaAuth.execGoogleSignIn()
      .then( _onLoginSuccess )
      .catchError( _errCatcher );
  }

  _handleFacebookLogin(){
    SocialMediaAuth.execFacebookLogin()
      .then( _onLoginSuccess  )
      .catchError( _errCatcher );
  }

  _onLoginSuccess(data){
    _setLoggedInState(data);
    _navigateToProfile();
  }

  _setLoggedInState(data) => setState((){ 
    _authUser = data;
    _isLoading=false; 
    _isLoggedIn=true; 
  });

  _navigateToProfile(){
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new Profile(_authUser)),
    );
  }

  _onFirebaseMessage(message){
    generateSnackbar(_scaffoldContext,new Text(message['msg']),10);
  }

  _errCatcher(err) => print('error: $err');
}