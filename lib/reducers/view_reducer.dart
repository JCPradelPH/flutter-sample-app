import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../actions/view_actions.dart';

// redux reducer for dynamically changing widgets
final viewReducer = combineReducers<Widget>([
  new TypedReducer<Widget,SetView>(_currentView),
]);

Widget _currentView(Widget prevView, SetView action) {
  return action.view;
}