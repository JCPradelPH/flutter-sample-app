import 'package:redux/redux.dart';

import '../actions/loader_actions.dart';

// redux reducer for loading states
final loaderReducer = combineReducers<bool>([
  new TypedReducer<bool,AppLoading>(_applicationLoading),
  new TypedReducer<bool,AppLoading>(_applicationLoaded),
]);

bool _applicationLoading(bool loading, AppLoading action) {
  return true;
}
bool _applicationLoaded(bool loading, AppLoading action) {
  return false;
}