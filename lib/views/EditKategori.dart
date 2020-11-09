import 'package:flutter/material.dart';
import 'package:flutter_apps/model/KategoriModel.dart';
import 'package:flutter_apps/model/api.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class EditKategori extends StatefulWidget {
  final VoidCallback reload;
  final KategoriModel model;
  EditKategori(this.model, this.reload);
  @override
  _EditKategoriState createState() => _EditKategoriState();
}

class _EditKategoriState extends State<EditKategori> {
  String namaKategori, idKategori;

  final _key = new GlobalKey<FormState>();

  TextEditingController txtIdKategori, txtNamaKategori, txtKategori;
  setup() async {
    txtIdKategori = TextEditingController(text: widget.model.idKategori);
    txtNamaKategori = TextEditingController(text: widget.model.namaKategori);
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      simpanBarang();
    }
  }

  simpanBarang() async {
    try {
      // print(idKategori);
      // print(namaKategori);
      // print(Kategori);
      final response = await http.post(BaseUrl.urlEditKategori, body: {
        "id": (idKategori == null ? widget.model.idKategori : idKategori),
        "namaKategori": namaKategori
      });
      final data = jsonDecode(response.body);
      int code = data['code'];
      String pesan = data['message'];
      if (code == 200) {
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
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        appBar: AppBar(
          title: Text("Edit Kategori"),
        ),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: txtNamaKategori,
                validator: (e) {
                  if (e.isEmpty) {
                    return "Silahkan isi Nama Kategori";
                  } else {
                    return null;
                  }
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
