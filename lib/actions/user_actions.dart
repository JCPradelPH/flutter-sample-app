class FacebookLogin{
  final User user;
  final bool loading;
  FacebookLogin({this.user,this.loading});
}
class GoogleLogin{
  final User user;
  final bool loading;
  GoogleLogin({this.user,this.loading});
}

class User{
  final bool loading;
  final String displayName;
  final String email;
  final String photoUrl;
  User({this.loading,this.displayName,this.email,this.photoUrl});
}