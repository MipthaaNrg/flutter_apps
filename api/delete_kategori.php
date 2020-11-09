<?php
include '../config/functions.php';

$idKategori = $_POST['idKategori'];

$namaTabel = "flutter_kategori";
header("Content-Type: text/xml");

$hasil = $db->query("DELETE FROM $namaTabel WHERE idKategori = $idKategori");
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