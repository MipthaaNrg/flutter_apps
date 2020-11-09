<?php
include '../config/functions.php';

$idSatuan = $_POST['idSatuan'] ;
$namaSatuan = $_POST['namaSatuan'];
$satuan = $_POST['satuan'];
$namaTabel = "flutter_satuan";
// header('Content-Type: text/xml');
$query = "UPDATE $namaTabel SET namaSatuan = '$namaSatuan', satuan = '$satuan' WHERE idSatuan = '$idSatuan'";
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