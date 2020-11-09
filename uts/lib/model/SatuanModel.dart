class SatuanModel {
  String idSatuan;
  String namaSatuan;
  String satuan;

  SatuanModel(this.idSatuan, this.namaSatuan, this.satuan);

  SatuanModel.fromJson(Map<String, dynamic> json) {
    idSatuan = json['idSatuan'];
    namaSatuan = json['namaSatuan'];
    satuan = json['satuan'];
  }
}
