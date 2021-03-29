import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: -getBigDiameter(context) / 5,
            top: -getBigDiameter(context) / 3,
            bottom: getBigDiameter(context) / 1,
            child: Container(
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 50,
                    color: Colors.blue,
                  ),
                ),
              ),
              width: getBigDiameter(context),
              height: getBigDiameter(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade100,
              ),
            ),
          ),
          Positioned(
            left: -getSmallDiameter(context) / 3.8,
            top: -getSmallDiameter(context) / 2.5,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade100,
              ),
            ),
          ),
          Positioned(
            right: -getBigDiameter(context) / 4,
            bottom: -getBigDiameter(context) / 2,
            child: Container(
              width: getBigDiameter(context),
              height: getBigDiameter(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade100,
              ),
            ),
          ),
          Positioned(
            top: getBigDiameter(context) / 1,
            left: -getBigDiameter(context) / 2,
            bottom: -getBigDiameter(context) / 2,
            child: Container(
              width: getBigDiameter(context),
              height: getBigDiameter(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 300, 20, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          labelText: "Email: ",
                          labelStyle: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.blue,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          labelText: "Password: ",
                          labelStyle: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 20, 20),
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () {},
                              child: Center(
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                        ),
                      ),
                      FloatingActionButton(
                        elevation: 0,
                        mini: true,
                        backgroundColor: Colors.transparent,
                        child: Image(
                          image: AssetImage("asset/facebook.png"),
                        ),
                        onPressed: () {},
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        mini: true,
                        child: Image(
                          image: AssetImage("asset/twitter.png"),
                        ),
                        onPressed: () {},
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        mini: true,
                        child: Image(
                          image: AssetImage("asset/google-plus.png"),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        "Don't Have An Account?",
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      "SIGN UP",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
