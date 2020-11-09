import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apps/custom/currency.dart';
import 'package:flutter_apps/custom/datePicker.dart';
import 'package:flutter_apps/model/KategoriModel.dart';
import 'package:flutter_apps/model/SatuanModel.dart';
import 'package:flutter_apps/model/api.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class TambahProduk extends StatefulWidget {
  final VoidCallback reload;
  TambahProduk(this.reload);

  @override
  _TambahProdukState createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  String namaBarang,
      harga,
      userid,
      idKategori,
      tglexpired,
      idSatuan,
      kategoriID,
      namaSatuan,
      satuanID;

  final _key = new GlobalKey<FormState>();

  File _imageFile;

  KategoriModel _currentKategori;
  SatuanModel _currentSatuan;

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
      throw Exception('Failed to load Internet...');
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
      throw Exception('Failed to load Internet...');
    }
  }

  _pilihGalerry() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080);
    setState(() {
      _imageFile = image;
      Navigator.pop(context);
    });
  }

  _pilihCamera() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080);
    setState(() {
      _imageFile = image;
      Navigator.pop(context);
    });
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
      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      var length = await _imageFile.length();
      var uri = Uri.parse(BaseUrl.urlTambahProduk);
      var request = http.MultipartRequest("POST", uri);
      request.fields['nama_barang'] = namaBarang;
      request.fields['harga'] = harga.replaceAll(",", "");
      request.fields['tglexpired'] = "$tgl";
      request.fields['userid'] = "1";
      request.fields['idKategori'] = kategoriID;
      request.fields['idSatuan'] = satuanID;
      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(_imageFile.path)));

      var response = await request.send();
      if (response.statusCode > 2) {
        print("image Upload");
        if (this.mounted) {
          widget.reload();
          Navigator.pop(context);
        }
      } else {
        print("failed upload");
      }
    } catch (e) {
      debugPrint(e);
    }
  }

  String pilihTanggal, labelText;
  DateTime tgl = new DateTime.now();
  final TextStyle valueStyle = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: tgl,
        firstDate: DateTime(1992),
        lastDate: DateTime(2099));

    if (picked != null && picked != tgl) {
      setState(() {
        tgl = picked;
        pilihTanggal = new DateFormat.yMd().format(tgl);
      });
    } else {}
  }

  dialogFileFoto() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  "Silahkan pilih file",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _pilihGalerry();
                      },
                      child: Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    InkWell(
                        onTap: () {
                          _pilihCamera();
                        },
                        child: Text(
                          "Camera",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          );
        });
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
        title: Text("Tambah Produk"),
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
                        ? placeholder
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
                        kategoriID = _currentKategori.idKategori;
                      });
                    },
                    isExpanded: false,
                    hint: Text(kategoriID == null
                        ? "0"
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
                        satuanID = _currentSatuan.idSatuan;
                      });
                    },
                    isExpanded: false,
                    hint: Text(
                        satuanID == null ? "0" : _currentSatuan.namaSatuan),
                  );
                }),
            TextFormField(
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
              validator: (e) {
                if (e.isEmpty) {
                  return "Silahkan isi harga produk";
                } else {
                  return null;
                }
              },
              onSaved: (e) => harga = e,
              decoration: InputDecoration(labelText: "Harga Produk"),
              keyboardType: TextInputType.number,
            ),
            Text("Tgl Expired"),
            DateDropDown(
              labelText: labelText,
              valueText: new DateFormat.yMd().format(tgl),
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
