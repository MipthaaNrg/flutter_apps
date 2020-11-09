<?php
include '../config/functions.php';

$UserID = $_POST['userid'];
$idKategori = $_POST['idKategori'];
$idSatuan = $_POST['idSatuan'];
$nama_barang = $_POST['nama_barang'];
$harga = $_POST['harga'];
$image = date('dmYHis').str_replace(" ","",
        basename($_FILES['image']['name']));
$imagePath = "../upload/".$image;
move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);
$tglexpired = $_POST['tglexpired'];
$namaTabel = 'flutter_barang';
header('Content-Type: text/xml');

$hasil = $db->query("INSERT INTO $namaTabel VALUES(NULL,'$idKategori', '$idSatuan', '$UserID','$nama_barang','$harga', '$image', '$tglexpired', NOW()) ");

if($hasil)
{
    $response['success'] = 1;
    $response['message'] = "Berhasil disimpan";
    echo json_encode($response);

}
else{
    $response['success'] = 0;
    $response['message'] = "Data gagal disimpan";
    echo json_encode($response);

}
?>