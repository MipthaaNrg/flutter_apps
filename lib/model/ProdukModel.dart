class ProdukModel {
  String id_barang;
  String idKategori;
  String idSatuan;
  String nama_barang;
  String harga;
  String image;
  String tglexpired;

  ProdukModel(this.id_barang, this.idKategori, this.idSatuan, this.nama_barang,
      this.harga, this.image, this.tglexpired);

  ProdukModel.fromJson(Map<String, dynamic> json) {
    id_barang = json['id_barang'];
    idKategori = json['idKategori'];
    idSatuan = json['idSatuan'];
    nama_barang = json['nama_barang'];
    harga = json['harga'];
    image = json['image'];
    tglexpired = json['tglexpired'];
  }
}
