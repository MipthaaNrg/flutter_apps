import 'package:flutter/material.dart';
import 'package:flutter_apps/model/SatuanModel.dart';
import 'package:flutter_apps/model/api.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class EditSatuan extends StatefulWidget {
  final VoidCallback reload;
  final SatuanModel model;
  EditSatuan(this.model, this.reload);
  @override
  _EditSatuanState createState() => _EditSatuanState();
}

class _EditSatuanState extends State<EditSatuan> {
  String namaSatuan, satuan, idSatuan;

  final _key = new GlobalKey<FormState>();

  TextEditingController txtIdSatuan, txtNamaSatuan, txtSatuan;
  setup() async {
    txtIdSatuan = TextEditingController(text: widget.model.idSatuan);
    txtNamaSatuan = TextEditingController(text: widget.model.namaSatuan);
    txtSatuan = TextEditingController(text: widget.model.satuan);
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
      // print(idSatuan);
      // print(namaSatuan);
      // print(satuan);
      final response = await http.post(BaseUrl.urlEditSatuan, body: {
        "idSatuan": idSatuan == null ? widget.model.idSatuan : idSatuan,
        "namaSatuan": namaSatuan,
        "satuan": satuan
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
      print("print error");
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
          title: Text("Edit Satuan"),
        ),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: txtNamaSatuan,
                validator: (e) {
                  if (e.isEmpty) {
                    return "Silahkan isi Nama Satuan";
                  } else {
                    return null;
                  }
                },
                onSaved: (e) => namaSatuan = e,
                decoration: InputDecoration(labelText: "Nama Satuan"),
              ),
              TextFormField(
                controller: txtSatuan,
                validator: (e) {
                  if (e.isEmpty) {
                    return "Silahkan isi Satuan";
                  } else {
                    return null;
                  }
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
