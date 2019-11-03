import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url) {
    print(url);
    print('in get ');
    Future<Response> respo =  http.get(url);
    print("above amin");
    print(url);
    print(respo.toString());
    return respo.then((http.Response response) {
      print ("hoooooooooooooo");
      print(response);
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
  Future<dynamic> post(String url , {Map headers , body , encoding}){
    print('in post function');
    print(url);
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      print('in post response');

      final String res = response.body;
      final int statusCode = response.statusCode;
        print('abov if');
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print('in if');
        print(statusCode);
        print(json);
        throw new Exception("Error while fetching data");
      }

      print('end of post');
      return _decoder.convert(res);
    });

  }
}
