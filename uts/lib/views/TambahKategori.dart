import 'package:flutter/material.dart';
import 'package:flutter_apps/model/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TambahKategori extends StatefulWidget {
  final VoidCallback reload;
  TambahKategori(this.reload);
  @override
  _TambahKategoriState createState() => _TambahKategoriState();
}

class _TambahKategoriState extends State<TambahKategori> {
  String namaKategori;

  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      simpanBarang();
    }
  }

  simpanBarang() async {
    // print(namaKategori);
    // print(Kategori);
    try {
      // print(idKategori);
      final response = await http.post(BaseUrl.urlTambahKategori,
          body: {"namaKategori": namaKategori});
      final data = jsonDecode(response.body);
      int code = data['code'];
      String pesan = data['message'];
      if (code == 201 || code == 200) {
        print("reload");
        setState(() {
          Navigator.pop(context);
          widget.reload();
        });
      } else {
        print(pesan);
      }
    } catch (e) {
      print("prinerror");
      print(e);
      // debugPrint(e);
    }
  }

  @override
  void initState() {
    super.initState();
    // getPref();
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = Container(
      width: double.infinity,
      height: 150.0,
      child: Image.asset('./assets/img/placeholder.png'),
    );
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
          title: Text("Tambah Kategori"),
        ),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                validator: (e) {
                  if (e.isEmpty) {
                    return "Silahkan isi Nama Kategori";
                  } else {}
                },
                onSaved: (e) => namaKategori = e,
                decoration: InputDecoration(labelText: "Nama Kategori"),
              ),
              MaterialButton(
                onPressed: () {
                  check();
                },
                child: Text("Simpan"),
              )
            ],
          ),
        ));
  }
}
