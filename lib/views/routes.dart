import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_apps/MenuUser.dart';
import 'package:flutter_apps/models/api.dart';
import 'package:flutter_apps/views/Login/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_apps/views/Register/RegisterPage.dart';

final Map<String, WidgetBuilder> routes = {
  RegisterPage.routeName: (context) => RegisterPage(),
};
