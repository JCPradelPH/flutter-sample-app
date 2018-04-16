import 'package:flutter/material.dart';

import 'actions/user_actions.dart';

class AppState {
  final bool loading, loginLoading, loggedIn;
  final User user;
  final Widget view;

  AppState({
    this.loading = false,
    this.loginLoading = false,
    this.loggedIn = false,
    this.user,
    this.view,
  });

  AppState copyWith({bool loading, bool loginLoading, bool loggedIn, User user, Widget view}) => new AppState(
    loading: loading ?? this.loading,
    loginLoading: loginLoading ?? this.loginLoading,
    loggedIn: loggedIn ?? this.loggedIn,
    user: this.user,
    view: this.view,
  );
}