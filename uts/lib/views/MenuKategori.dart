import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_apps/model/api.dart';
import 'package:flutter_apps/model/KategoriModel.dart';
import 'package:flutter_apps/views/EditKategori.dart';
import 'package:flutter_apps/views/TambahKategori.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'TambahKategori.dart';

class MenuKategori extends StatefulWidget {
  @override
  _MenuKategoriState createState() => _MenuKategoriState();
}

class _MenuKategoriState extends State<MenuKategori> {
  var loading = false;
  final list = new List<KategoriModel>();
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
    final response = await http.get(BaseUrl.urlDataKategori);
    print(response.body);
    if (response.contentLength > 2) {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new KategoriModel(
          api['idKategori'],
          api['namaKategori'],
        );
        list.add(ab);
      });

      setState(() {
        loading = false;
      });
    }
  }

  _proseshapus(String idkategori) async {
    final response = await http
        .post(BaseUrl.urlHapusKategori, body: {"idKategori": idkategori});
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

  dialogHapus(String idkategori) {
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
                    _proseshapus(idkategori);
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
                "Data Kategori",
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
                  builder: (context) => new TambahKategori(_lihatData)));
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
                                "No." + x.idKategori,
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(x.namaKategori,
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
                                      EditKategori(x, _lihatData)));
                            }),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            dialogHapus(x.idKategori);
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
