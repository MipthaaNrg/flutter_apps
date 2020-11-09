class KategoriModel {
  String idKategori;
  String namaKategori;

  KategoriModel(this.idKategori, this.namaKategori);

  KategoriModel.fromJson(Map<String, dynamic> json) {
    idKategori = json['idKategori'];
    namaKategori = json['namaKategori'];
  }
}
