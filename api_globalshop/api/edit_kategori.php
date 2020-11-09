<?php
include '../config/functions.php';

$id = $_POST['id'] ;
$namaKategori = $_POST['namaKategori'];
$namaTabel = "flutter_kategori";
// header('Content-Type: text/xml');
$query = "UPDATE $namaTabel SET namaKategori = '$namaKategori' WHERE idKategori = '$id'";
$sql = mysqli_query($con, $query);
$hasil = $sql;
$responses = array("code" => null,"data" => null,"message" => null);
// var_dump($hasil);
if ($hasil) {
    $responses['code'] = 200;
    $responses['message'] = "Berhasil simpan";
} else {
    $responses["code"] = 400;
    $responses['message'] = "Gagal simpan";
}
// echo ($responses["data"]);
echo json_encode($responses);