import 'package:az_man_bepors/models/User.dart';
import 'package:az_man_bepors/data/rest_ds.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(String userName);

  void onLoginError(String errorText);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  RestDataSource api = new RestDataSource();
  LoginScreenPresenter(this._view);


  doLogin(String username, String password) {
    api.login(username, password).then((String username) {
      _view.onLoginSuccess(username);
    }).catchError((Object error) {
      print(error.toString());
      return _view.onLoginError(error.toString());
    });
    }

  doSignUp(String username,int mobile , String password ,String email) {
    print('in do sign up');

    api.signUp(username, mobile , password , email).then((User user) {
      _view.onLoginSuccess(user.username);
    }).catchError((Object error) {
      print(error.toString());
      return _view.onLoginError(error.toString());
    });
  }
  doGetData(){
    print('in do get data in presenter');
    //connection error
    api.getData();
  }
}