import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier{
  String _token;
  DateTime _expiredToken;
  String _userId;

  bool get isAuth{
    return token != null;
  }

  String get token{
    if(_token != null && _userId != null && _expiredToken.isAfter(DateTime.now())){
      return _token;
    }

    return null;
  }

  String get userId{
     if(_token != null && _userId != null && _expiredToken.isAfter(DateTime.now())){
      return _userId;
    }

    return null;
  }

  Future<void> _authentication(String email, String password, String urlParams) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlParams?key=AIzaSyCvbiqZMNpvRCGm0PdKF2bfMkXGB19SOkU';

    try{
        final response = await http.post(url, body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true
        }));

        final responseData = json.decode(response.body);
        if(responseData['error'] != null){
          throw HttpException(responseData['error']['message']);
        }

        _token        = responseData['idToken'];
        _expiredToken = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
        _userId       = responseData['localId'];

        notifyListeners();

    }catch(err){
      throw err;
    }

  }

  Future<void> signUp(String email, String password) async {
   return _authentication(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
   return _authentication(email, password, 'signInWithPassword');
  }


}