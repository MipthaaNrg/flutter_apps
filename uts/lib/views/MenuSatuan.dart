import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_apps/model/api.dart';
import 'package:flutter_apps/model/SatuanModel.dart';
import 'package:flutter_apps/views/EditSatuan.dart';
import 'package:flutter_apps/views/TambahSatuan.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'TambahSatuan.dart';

class MenuSatuan extends StatefulWidget {
  @override
  _MenuSatuanState createState() => _MenuSatuanState();
}

class _MenuSatuanState extends State<MenuSatuan> {
  var loading = false;
  final list = new List<SatuanModel>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  getPref() async {
    _lihatData();
  }

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.urlDataSatuan);
    print(response.body);
    if (response.contentLength > 2) {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new SatuanModel(
          api['idSatuan'],
          api['namaSatuan'],
          api['satuan'],
        );
        list.add(ab);
      });

      setState(() {
        loading = false;
      });
    }
  }

  _proseshapus(String idsatuan) async {
    final response =
        await http.post(BaseUrl.urlHapusSatuan, body: {"idSatuan": idsatuan});
    final data = jsonDecode(response.body);
    int value = data['success'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
        _lihatData();
      });
    } else {
      print(pesan);
    }
  }

  dialogHapus(String idsatuan) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ListView(
          padding: EdgeInsets.all(16.0),
          shrinkWrap: true,
          children: <Widget>[
            Text(
              "Apakah Anda Yakin Ingin Menghapus Data ini? ",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Tidak",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 25.0),
                InkWell(
                  onTap: () {
                    _proseshapus(idsatuan);
                  },
                  child: Text(
                    "Ya",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Data Satuan",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new TambahSatuan(_lihatData)));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(255, 82, 48, 1),
      ),
      body: RefreshIndicator(
        onRefresh: _lihatData,
        key: _refresh,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "No." + x.idSatuan,
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(x.namaSatuan,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              Text(x.satuan,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditSatuan(x, _lihatData)));
                            }),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            dialogHapus(x.idSatuan);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
