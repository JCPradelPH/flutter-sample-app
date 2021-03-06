import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map_view/map_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'actions/user_actions.dart';
import 'actions/view_actions.dart';
import 'app_state.dart';
import 'components/ab_popup_menu.dart';
import 'components/shared_components.dart';
import 'containers/home/home_container.dart';
import 'containers/home/movies/movies_stream.dart';
import 'containers/home/users/users_list.dart';
import 'containers/map/map.dart';
import 'containers/profile/profile.dart';
import 'utils/global_adapter.dart';
import 'utils/push_notif_service.dart';
import './reducers/appstate_reducer.dart';
import './middlewares/user_middleware.dart';

// main app entry
void main(){
  runApp(new MainContainer());
}
  
class MainContainer extends StatelessWidget{
  static final allEpics = combineEpics<AppState>([fbLoginEpic,googleLoginEpic]);
  final store = Store<AppState>( 
    appStateReducer, 
    initialState: new AppState(), 
    middleware: [new EpicMiddleware(allEpics)] 
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        title: 'MPA Development',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MainPage(title: 'MPA Devel'),
      )
    );
  }
}

// MainPage stateful widget
class MainPage extends StatefulWidget{
  final String title;

  // action bar menus with icons and other props
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

// MainPage state
class _State extends State<MainPage>{

  Widget _bodyContent; // dynamically changes on setState. Container for the content of MainPage
  
  BuildContext _scaffoldContext; // context to be passed to child components
  
  @override
  void initState() {
    super.initState();
    PushNotificationService.init(_onFirebaseMessage); // initialize firebase push notif
    _bodyContent = new HomePage();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: [
          new StoreConnector<AppState,dynamic>( // redux store connector to access logged in state
            converter: (store) => store,
            builder: (context, store){
              return new ABPopUpMenu( // validate menu content depending on logged in state
                widget.menuList.where( (menu) => menu.flag==store.state.loggedIn || menu.alwaysOn ).toList(),
                onSelect: _onSelect,
                store: store
              );
            }
          ),
        ]
      ),
      body: new Builder(
        builder: (BuildContext context){
          _scaffoldContext = context; //(side effect) store context on global reference
          return new StoreConnector<AppState,bool>( // access login loading state from redux
            converter: (store) => store.state.loginLoading,
            builder: (context,loading) => loading ? loader() : _bodyContent // 
          );
        }
      )
    );
  }
  
  // event when a menu is selected
  _onSelect(MenuAdapter menuItem, store) {
    switch(menuItem.actionId){
      case 0:// Login via Facebook
        store.dispatch(new FacebookLogin(loading:true));
      break;
      case 1:// SignIn Via Google
        store.dispatch(new GoogleLogin(loading:true));
      break;
      case 2:// Login via Email
        // show login via email page
      break;
      case 3:// My Profile
        _navigateToProfile();
      break;
      case 4:// Map
        Location initialPos = new Location(12.8797, 121.7740);
        LocationMap.show(initialPos);
      break;
      case 5:// REST API Listview
        store.dispatch( new SetView( new MovieStream() ) );
      break;
      case 6:// Firestore Listview
        store.dispatch( new SetView( new UsersList() ) );
      break;
    }
  }

  // function to redirect to profile page
  _navigateToProfile(){
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new Profile()),
    );
  }

  // callback when a new push notification has been received
  _onFirebaseMessage(message){
    generateSnackbar(_scaffoldContext,new Text(message['msg']),10);
  }
}