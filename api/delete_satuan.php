<?php
include '../config/functions.php';

$idSatuan = $_POST['idSatuan'];

$namaTabel = "flutter_satuan";
header("Content-Type: text/xml");

$hasil = $db->query("DELETE FROM $namaTabel WHERE idSatuan = $idSatuan");
if($hasil)
{
    $response['success'] = 1;
    $response['message'] = " Data Berhasil Dihapus";
    echo json_encode($response);
}
else
{
    $response['success'] = 0;
    $response['message'] = " Data Gagal Dihapus";
    echo json_encode($response);
}
?>