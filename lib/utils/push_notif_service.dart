import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationService{
  
  static final _firebaseMessaging = new FirebaseMessaging();

  static init(onMessage){
    _firebaseMessaging.configure(
      onMessage: (message) {
        print("FIREBASE onMessage: $message");
        onMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) {
        print("FIREBASE onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) {
        print("FIREBASE onResume: $message");
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    })
    .catchError( (err) => print("FIREBASE ERROR: $err") );
  }
}