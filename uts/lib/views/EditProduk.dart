import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_apps/custom/currency.dart';
import 'package:flutter_apps/custom/datePicker.dart';
import 'package:flutter_apps/model/ProdukModel.dart';
import 'package:flutter_apps/model/api.dart';
import 'package:flutter_apps/model/KategoriModel.dart';
import 'package:flutter_apps/model/SatuanModel.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as p;

class EditProduk extends StatefulWidget {
  final VoidCallback reload;
  final ProdukModel model;
  EditProduk(this.model, this.reload);

  @override
  _EditProdukState createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  String idBarang,
      namaBarang,
      harga,
      tglexpired,
      tglExpired,
      userid,
      kategoriID,
      idKategori,
      idSatuan,
      satuanID;
  final _key = new GlobalKey<FormState>();
  //TAMBAH FILE FOTO
  File _imageFile;

  TextEditingController txtIdBarang, txtnamaBarang, txtHarga;

  get path => null;
  setup() async {
    tglExpired = widget.model.tglexpired;
    txtnamaBarang = TextEditingController(text: widget.model.nama_barang);
    txtHarga = TextEditingController(text: widget.model.harga);
    txtIdBarang = TextEditingController(text: widget.model.id_barang);
  }

  //tambah ddl
  KategoriModel _currentKategori;
  SatuanModel _currentSatuan;
  final listKategori = new List<KategoriModel>();
  final listSatuan = new List<SatuanModel>();
  final String linkKategori = BaseUrl.urlListKategori;
  final String linkSatuan = BaseUrl.urlListSatuan;

  Future<List<KategoriModel>> _fetchKategori() async {
    var response = await http.get(linkKategori);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<KategoriModel> listOfKategori = items.map<KategoriModel>((json) {
        return KategoriModel.fromJson(json);
      }).toList();

      return listOfKategori;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<List<SatuanModel>> _fetchSatuan() async {
    var response = await http.get(linkSatuan);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<SatuanModel> listOfSatuan = items.map<SatuanModel>((json) {
        return SatuanModel.fromJson(json);
      }).toList();

      return listOfSatuan;
    } else {
      throw Exception('Failed to load Internet');
    }
  }

  _pilihGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080);

    setState(() {
      _imageFile = image;
      Navigator.pop(this.context);
    });
  } // end pilih galery

  _pilihCamera() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080);

    setState(() {
      _imageFile = image;
      Navigator.pop(context);
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      prosesbarang();
    }
  }

  prosesbarang() async {
    try {
      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      var length = await _imageFile.length();
      var uri = Uri.parse(BaseUrl.urlEditProduk);
      var request = http.MultipartRequest("POST", uri);
      request.fields['nama_barang'] = namaBarang;
      request.fields['harga'] = harga.replaceAll(",", "");
      request.fields['tglexpired'] = "$tglExpired";
      request.fields['userid'] = "1";
      request.fields['idKategori'] =
          kategoriID == null ? widget.model.idKategori : kategoriID;
      request.fields['idSatuan'] =
          satuanID == null ? widget.model.idSatuan : satuanID;
      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(_imageFile.path)));

      var response = await request.send();
      if (response.statusCode > 2) {
        print("image Upload");
        if (this.mounted) {
          setState(() {
            widget.reload();
            Navigator.pop(context);
          });
        }
      } else {
        print("failed upload");
      }
    } catch (e) {
      debugPrint(e);
    }
  }

  prosesbiasa() async {
    final response = await http.post(BaseUrl.urlEditProduk, body: {
      "nama_barang": namaBarang,
      "id_kategori": kategoriID == null ? widget.model.idKategori : kategoriID,
      "id_satuan": satuanID == null ? widget.model.idSatuan : satuanID,
      "harga": harga.replaceAll(",", ""),
      "tglExpired": "$tglExpired",
      "idProduk": widget.model.id_barang
    });
    final data = jsonDecode(response.body);
    int value = data['success'];
    String pesan = data['message'];

    if (value == 1) {
      setState(() {
        print(pesan);
        widget.reload();
        Navigator.pop(context);
      });
    } else {
      print(pesan);
    }
  }

  //dialog
  dialogFileFoto() {
    showDialog(
        context: this.context,
        builder: (context) {
          return Dialog(
            child: ListView(
                padding: EdgeInsets.all(16.0),
                shrinkWrap: true,
                children: [
                  Text(
                    "Silahkan Pilih Sumber File",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 18.0),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    InkWell(
                      onTap: () {
                        _pilihCamera();
                      },
                      child: Text(
                        "Kamera",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 25.0),
                    InkWell(
                      onTap: () {
                        _pilihGallery();
                      },
                      child: Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ]),
          );
        });
  }

  String labelText;
  DateTime tgl = new DateTime.now();
  var formatTgl = new DateFormat('yyyy-MM-dd');
  final TextStyle valueStyle = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate(BuildContext context) async {
    tgl = DateTime.parse(widget.model.tglexpired);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: tgl,
        firstDate: DateTime(1992),
        lastDate: DateTime(2099));

    if (picked != null && picked != tgl) {
      setState(() {
        tgl = picked;
        tglExpired = formatTgl.format(tgl);
      });
    } else {}
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
        title: Text("Edit Produk"),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Text("Foto Produk"),
            Container(
                width: double.infinity,
                height: 150.0,
                child: InkWell(
                    onTap: () {
                      dialogFileFoto();
                    },
                    child: _imageFile == null
                        ? Image.network(BaseUrl.paths + widget.model.image)
                        : Image.file(_imageFile, fit: BoxFit.fill))),
            Text("Kategori Produk"),
            FutureBuilder<List<KategoriModel>>(
                future: _fetchKategori(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<KategoriModel>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return DropdownButton<KategoriModel>(
                    items: snapshot.data
                        .map((listkategori) => DropdownMenuItem<KategoriModel>(
                              child: Text(listkategori.namaKategori),
                              value: listkategori,
                            ))
                        .toList(),
                    onChanged: (KategoriModel value) {
                      setState(() {
                        _currentKategori = value;
                        idKategori = _currentKategori.idKategori;
                      });
                    },
                    isExpanded: false,
                    hint: Text(kategoriID == null ||
                            kategoriID == widget.model.idKategori
                        ? widget.model.idKategori
                        : _currentKategori.namaKategori),
                  );
                }),
            Text("Satuan Produk"),
            FutureBuilder<List<SatuanModel>>(
                future: _fetchSatuan(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<SatuanModel>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return DropdownButton<SatuanModel>(
                    items: snapshot.data
                        .map((listsatuan) => DropdownMenuItem<SatuanModel>(
                              child: Text(listsatuan.namaSatuan),
                              value: listsatuan,
                            ))
                        .toList(),
                    onChanged: (SatuanModel value) {
                      setState(() {
                        _currentSatuan = value;
                        idSatuan = _currentSatuan.idSatuan;
                      });
                    },
                    isExpanded: false,
                    hint: Text(
                        satuanID == null || satuanID == widget.model.idSatuan
                            ? widget.model.idSatuan
                            : _currentSatuan.namaSatuan),
                  );
                }),
            TextFormField(
              controller: txtnamaBarang,
              validator: (e) {
                if (e.isEmpty) {
                  return "Silahkan isi nama produk";
                } else {
                  return null;
                }
              },
              onSaved: (e) => namaBarang = e,
              decoration: InputDecoration(labelText: "Nama Produk"),
            ),
            TextFormField(
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                CurrencyFormat()
              ],
              controller: txtHarga,
              validator: (e) {
                if (e.isEmpty) {
                  return "Silahkan isi harga produk";
                } else {
                  return null;
                }
              },
              onSaved: (e) => harga = e,
              decoration: InputDecoration(labelText: "Harga Produk"),
            ),
            Text("Tgl Expired"),
            DateDropDown(
              labelText: labelText,
              valueText: tglExpired,
              valueStyle: valueStyle,
              onPressed: () {
                _selectedDate(context);
              },
            ),
            MaterialButton(
              onPressed: () {
                check();
              },
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}
