import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier{
  String _token;
  DateTime _expiredToken;
  String _userId;
  Timer _timer;

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

        _autoLogout();
        notifyListeners();
        
        final prefs     = await SharedPreferences.getInstance();
        final userData  = json.encode({
          'token' : _token,
          'userId': _userId,
          'expiredDate': _expiredToken.toIso8601String()
        });

        prefs.setString('userData', userData);

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

  Future<void> tryToAutoLogin() async {
    final prefs       = await SharedPreferences.getInstance();
    final extractData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiredDate = DateTime.parse(extractData['expiredDate']);

    if(expiredDate.isBefore(DateTime.now())){
      return false;
    }
    _token  = extractData['token'];
    _userId = extractData['userId'];
    _expiredToken = expiredDate;
    notifyListeners(); 
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _expiredToken = null;
    _userId = null;
    if(_timer != null){
      _timer.cancel();
      _timer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  Future<void> _autoLogout(){
    if(_timer != null){
      _timer.cancel();
    }
    final timeExpired = _expiredToken.difference(DateTime.now()).inSeconds;
     _timer = Timer(Duration(seconds: timeExpired), logout);

  }
}