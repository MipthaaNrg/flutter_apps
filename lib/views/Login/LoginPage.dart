import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_apps/MenuUser.dart';
import 'package:flutter_apps/models/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_apps/views/Register/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  var username, password;
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  var _autoValidate = false;

  check() {
    // final form = _key.currentState;

    login();
    // if (form.validate()) {
    // } else {
    //   _autoValidate = true;
    // }
  }

  login() async {
    try {
      print("nulls");
      print(username);
      print(password);
      final response = await http.post(BaseURL.apiLogin,
          body: {"username": username, "password": password});
      final data = jsonDecode(response.body);
      int code = data['code'];
      String pesan = data['message'];

      // from api
      String usernameApi, namaApi;
      int useridApi, userLevel;

      data['data'].forEach((api) {
        usernameApi = api['username'];
        namaApi = api['nama'];
        useridApi = api['userid'];
        userLevel = api['level'];
      });

      if (code == 200) {
        setState(() {
          _loginStatus = LoginStatus.signIn;
          savePref(code, usernameApi, namaApi, useridApi, userLevel);
        });
        print(pesan);
      } else {
        print(pesan);
      }
    } catch (e) {
      print("error : ");
      print(e);
    }
  }

  savePref(int code, String usernameApi, String namaApi, int useridApi,
      int userLevel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("code", code);
      preferences.setString("username", usernameApi);
      preferences.setString("nama", namaApi);
      preferences.setInt("userid", useridApi);
      preferences.setInt("level", userLevel);
      preferences.commit();
    });
  }

  var code, level;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      code = preferences.getInt("code");
      level = preferences.getInt("level");

      if (code == 200) {
        _loginStatus = LoginStatus.signIn;
      } else {
        _loginStatus = LoginStatus.notSignIn;
      }
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      code = preferences.setInt("code", null);
      level = preferences.setInt("level", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
            body: Form(
          key: _key,
          autovalidate: _autoValidate,
          child: ListView(
            padding: EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
            children: <Widget>[
              Image.asset('assets/img/logo1.jpg', height: 100, width: 100),
              TextFormField(
                validator: (e) {
                  if (e.isEmpty) {
                    return "Username Harus Diisi";
                  } else {
                    return null;
                  }
                },
                onSaved: (e) => username = e,
                decoration: InputDecoration(
                  labelText: "Username",
                  icon: Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                ),
              ),
              SizedBox(height: 20, width: 20),
              TextFormField(
                obscureText: _secureText,
                validator: (e) {
                  if (e.isEmpty) {
                    return "Password Harus Diisi";
                  } else {
                    return null;
                  }
                },
                onSaved: (e) => password = e,
                decoration: InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    suffixIcon: IconButton(
                      icon: Icon(_secureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        showHide();
                      },
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green)),
                color: Colors.green,
                onPressed: () {
                  if (_key.currentState.validate()) {
                    _key.currentState.save();
                    check();
                  } else {
                    _autoValidate = true;
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Don't have account?",
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ],
          ),
        ));
        break;
      case LoginStatus.signIn:
        return MenuUser(signOut);
        break;
        
    }
  }
}
