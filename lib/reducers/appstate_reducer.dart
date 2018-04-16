import '../actions/user_actions.dart';
import '../app_state.dart';
import '../containers/home/users/users_list.dart';
import './user_reducer.dart';
import './view_reducer.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return new AppState(
    user: state.user!=null?userReducer(state.user, action):new User(loading:false),
    loginLoading: userLoaderReducer(state.loading, action),
    loggedIn: userLogStateReducer(state.loading, action),
    view: state.view==null?new UsersList():viewReducer(state.view, action),
  );
}