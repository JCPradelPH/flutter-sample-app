import 'package:redux/redux.dart';

import '../actions/user_actions.dart';

final userReducer = combineReducers<User>([
  new TypedReducer<User,User>(_facebookLogin),
  new TypedReducer<User,User>(_googleLogin),
]);
final userLogStateReducer = combineReducers<bool>([
  new TypedReducer<bool,User>(_userLoggedIn),
]);

final userLoaderReducer = combineReducers<bool>([
  new TypedReducer<bool,FacebookLogin>(_facebookLoaderLogin),
  new TypedReducer<bool,GoogleLogin>(_googleLoaderLogin),
]);

User _facebookLogin(User prevUser, User user) {
  return user;
}

User _googleLogin(User prevUser, User user) {
  return user;
}

bool _facebookLoaderLogin(bool loading, FacebookLogin action) {
  return action.loading;
}

bool _googleLoaderLogin(bool loading, GoogleLogin action) {
  return action.loading;
}

bool _userLoggedIn(bool loggedIn, User user) {
  return true;
}