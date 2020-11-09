import 'package:flutter/material.dart';
import 'package:flutter_apps/views/ListMenu.dart';

class MenuUser extends StatefulWidget {
  @override
  _MenuUserState createState() => _MenuUserState();
}

class _MenuUserState extends State<MenuUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: IconButton(
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            icon: Icon(
              Icons.menu,
              size: 32,
              color: Colors.black,
            ),
          ),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
          child: Image.asset("assets/img/logo.png"),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(left: 24, top: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 12,
              ),
              Text('Welcome to Dashboard')
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text("Maftuhah Nurhasanah"),
              accountEmail: new Text("1118100105@stmikglobal.ac.id"),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: AssetImage('assets/img/user.png'),
              ),
            ),
            ListTile(
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Master Data"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new ListMenu()));
              },
            ),
            ListTile(
              title: Text("Riwayat Transaksi"),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
