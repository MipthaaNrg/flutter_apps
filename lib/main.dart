import 'package:flutter/material.dart';
import 'package:flutter_apps/views/Login/LoginPage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      home: LoginPage(),
    ),
  );
}
