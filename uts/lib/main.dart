import 'package:flutter/material.dart';
import 'package:flutter_apps/MenuUser.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: MenuUser(),
  ));
}
