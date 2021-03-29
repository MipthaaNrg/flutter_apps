import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_apps/MenuUser.dart';
import 'package:flutter_apps/models/api.dart';
import 'package:flutter_apps/views/Login/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  static var routeName;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

enum RegisterStatus { notSignUp, signUp }

class _RegisterPageState extends State<RegisterPage> {
  static String routeName = "/RegisterPage";
  RegisterStatus _RegisterStatus = RegisterStatus.notSignUp;
  var user_id, username, password, fullname, phone_number, address;
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  var _autoValidate = false;

  check() {
    final form = _key.currentState;

    register();
    if (form.validate()) {
    } else {
      _autoValidate = true;
    }
  }

  register() async {
    try {
      print("nulls");
      print(username);
      print(fullname);
      print(phone_number);
      print(address);

      print(password);
      final response = await http.post(BaseURL.apiRegister, body: {
        "username": username,
        "password": password,
        "fullname": fullname,
        "phone_number": phone_number,
        "address": address
      });
      final data = jsonDecode(response.body);
      int code = data['code'];
      String pesan = data['message'];

      // from api
      // String usernameApi, fullnameApi;
      // int useridApi, userstatus;

      // data['data'].forEach((api) {
      //   usernameApi = api['username'];
      //   fullnameApi = api['fullname'];
      //   useridApi = api['userid'];
      //   userstatus = api['status'];
      // });
      print(code);
      if (code == 200) {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
          // _RegisterStatus = RegisterStatus.signUp;
          // savePref(code, usernameApi, fullnameApi, useridApi, userstatus);
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

  // savePref(int code, String usernameApi, String fullnameApi, int useridApi,
  //     int userstatus) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     preferences.setInt("code", code);
  //     preferences.setString("username", usernameApi);
  //     preferences.setString("fullname", fullnameApi);
  //     preferences.setInt("userid", useridApi);
  //     preferences.setInt("status", userstatus);
  //     preferences.commit();
  //   });
  // }

  var code;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      code = preferences.getInt("code");

      if (code == 200) {
        _RegisterStatus = RegisterStatus.signUp;
      } else {
        _RegisterStatus = RegisterStatus.notSignUp;
      }
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      code = preferences.setInt("code", null);

      preferences.commit();
      _RegisterStatus = RegisterStatus.notSignUp;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_RegisterStatus) {
      case RegisterStatus.notSignUp:
        return Scaffold(
            appBar: AppBar(
              title: new Text("Sign Up"),
            ),
            body: Form(
              key: _key,
              autovalidate: _autoValidate,
              child: ListView(
                padding: EdgeInsets.only(top: 90.0, left: 20.0, right: 20.0),
                children: <Widget>[
                  Image.asset('assets/img/logo1.jpg', height: 100, width: 100),
                  SizedBox(height: 20, width: 20),
                  TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "username Harus Diisi";
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
                  SizedBox(height: 20, width: 20),
                  TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "fullname Harus Diisi";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (e) => fullname = e,
                    decoration: InputDecoration(
                      labelText: "Fullname",
                      icon: Icon(Icons.supervised_user_circle),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                    ),
                  ),
                  SizedBox(height: 20, width: 20),
                  SizedBox(height: 20, width: 20),
                  TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Phone Number Harus Diisi";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (e) => phone_number = e,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      icon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                    ),
                  ),
                  SizedBox(height: 20, width: 20),
                  TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Address Harus Diisi";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (e) => address = e,
                    decoration: InputDecoration(
                      labelText: "Address",
                      icon: Icon(Icons.location_city),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                    ),
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
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    color: Colors.red,
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
                ],
              ),
            ));

        break;
      case RegisterStatus.signUp:
        return MenuUser(signOut);
        break;
    }
  }
}
