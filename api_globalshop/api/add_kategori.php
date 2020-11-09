<?php
include '../config/functions.php';

$namaKategori = $_POST['namaKategori'];
$namaTabel = "flutter_kategori";

$hasil = mysqli_query($con,"INSERT INTO $namaTabel VALUES(null, '$namaKategori')");

$responses = array("code" => null,"data" => null,"message" => null);
// var_dump($hasil);
if ($hasil) {
    $responses['code'] = 201;
    $responses['message'] = "Berhasil simpan";
} else {
    $responses["code"] = 400;
    $responses['message'] = "Gagal simpan";
}
// echo ($responses["data"]);
echo json_encode($responses);