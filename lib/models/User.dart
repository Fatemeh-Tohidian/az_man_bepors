class User {
//  bool _isLogedin;
  int _id;
  String _username;
  int _mobile;
  int _hashedPassword;
  String _email;
  int _serverUserId;

   User(this._username , this._mobile, this._hashedPassword , this._email, this._serverUserId);

  int get id => _id;

  String get username => _username;

  int get mobile => _mobile;

  int get password => _hashedPassword;

  String get email => _email;

  int get serverUserId => _serverUserId;

//  bool get isLogedin => _isLogedin;

  Map<String, dynamic> toMap() {

    var map = new Map<String, dynamic>();

    map["username"] = _username;
    map["mobile"] = _mobile;
    map["password"] = _hashedPassword;
    map["email"] = _email;

//    map["isLogedin"] = _isLogedin;
    return map;
  }
  int  getServerUserID(dynamic object) {

    _serverUserId = object["server_user_id"];

   return _serverUserId;

  }
  User  formMap(dynamic object) {

    return new User (object["username"],object ["mobile"],object["password"],object["emial"],object["server_user_id"]);

  }
}
