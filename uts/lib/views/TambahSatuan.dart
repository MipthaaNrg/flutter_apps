import 'package:flutter/material.dart';
import 'package:flutter_apps/model/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TambahSatuan extends StatefulWidget {
  final VoidCallback reload;
  TambahSatuan(this.reload);
  @override
  _TambahSatuanState createState() => _TambahSatuanState();
}

class _TambahSatuanState extends State<TambahSatuan> {
  String namaSatuan, satuan;

  final _key = new GlobalKey<FormState>();

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      simpanBarang();
    }
  }

  simpanBarang() async {
    // print(namaSatuan);
    // print(satuan);
    try {
      // print(idSatuan);
      final response = await http.post(BaseUrl.urlTambahSatuan,
          body: {"nama_satuan": namaSatuan, "satuan": satuan});
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
      print("print error");
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
          title: Text("Tambah Satuan"),
        ),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                validator: (e) {
                  if (e.isEmpty) {
                    return "Silahkan isi Nama Satuan";
                  } else {}
                },
                onSaved: (e) => namaSatuan = e,
                decoration: InputDecoration(labelText: "Nama Satuan"),
              ),
              TextFormField(
                validator: (e) {
                  if (e.isEmpty) {
                    return "Silahkan isi Satuan";
                  } else {}
                },
                onSaved: (e) => satuan = e,
                decoration: InputDecoration(labelText: "Satuan"),
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
