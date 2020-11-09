<?php
include '../config/functions.php';

$idProduk = $_POST['idProduk'];

$namaTabel = "flutter_barang";
header("Content-Type: text/xml");

$hasil = $db->query("DELETE FROM $namaTabel WHERE id_barang = $idProduk");
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