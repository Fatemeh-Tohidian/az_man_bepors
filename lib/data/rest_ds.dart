import 'dart:async';

import 'package:az_man_bepors/data/DataBaseHelper.dart' as prefix0;
import 'package:az_man_bepors/utils/network_utils.dart';
import 'package:az_man_bepors/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DataBaseHelper.dart';

class RestDataSource {
  NetworkUtil _netUtil = new NetworkUtil();

//  static final LOGIN_URL = "http://10.0.2.2:5000/auth/mlogin";
  static final signUpURL = "http://10.0.2.2:5000/auth/mregister";
//  static final signUpURL = "http://127.0.0.1:5000/auth/mregister";
  static final tablesURL = "http://10.0.2.2:5000/initialize";
  static final apiKey = "somerandomkey";

  // ignore: missing_return
  Future<String> login(String username , String password) {
    getData();

    print('in do login in rest_ds');

    DatabaseHelper.instance.queryUser(username, password).then((dynamic response){
      if(response["error"]) throw new Exception(response["errorMessage"]);
     else{
      return response["username"];
     }
    });

  }

//completed
  Future<User> signUp(String username , int mobile , String password , String email) {

    print('in sign up  in rest_ds');

    return _netUtil.post(signUpURL, body: {
      "token": apiKey,
      "userName": username,
      "mobile":mobile,
      "password": password,
      "email" : email
    }
    ).then((dynamic res) {
      if(res["error"]) throw new Exception(res["errorMessage"]);
      else{
        print('h');
        print(res);
//        User user = new User(username,mobile,password.hashCode,email,res["server_user_id"]);
        User user = new User(username,mobile,password.hashCode,email,7);
        getData();
        DatabaseHelper.instance.insertUser(user);
//        DatabaseHelper.instance.insertUser(user);
        return user;
      }
    });
  }

 getData() async {
    print('in get data');

    print('in get data in rest_ds');
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  int counter = (prefs.getInt('counter'));
//  print('counter is :');
//  print(counter);

//  if(counter==null){
   print('above get tables');
     _netUtil.get(tablesURL).then((dynamic res) {


     //check connection error
print("above create table");

    DatabaseHelper.instance.createTables();
    DatabaseHelper.instance.initializeTables(res);

});
//     counter =1;
//     await prefs.setInt('counter', counter);
}
//  }
}