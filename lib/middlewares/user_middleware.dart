import 'dart:async';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import '../actions/user_actions.dart';
import '../app_state.dart';
import '../utils/social_media_auth.dart';

Stream<dynamic> fbLoginEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions)
    .ofType(new TypeToken<FacebookLogin>())
    .switchMap( (_) => new Observable.fromFuture(
      SocialMediaAuth.execFacebookLogin()
    ) )
    .map( (data){
      return new User( 
        loading: false, 
        displayName: data.displayName, 
        email: data.email, 
        photoUrl: data.photoUrl 
      );
    } );
}

Stream<dynamic> googleLoginEpic(Stream<dynamic> actions, EpicStore<AppState> store) {
  return new Observable(actions)
    .ofType(new TypeToken<GoogleLogin>())
    .switchMap( (_) => new Observable.fromFuture(
      SocialMediaAuth.execGoogleSignIn()
    ) )
    .map( (data){
      return new User( 
        loading: false, 
        displayName: data.displayName, 
        email: data.email, 
        photoUrl: data.photoUrl 
      );
    } );
}