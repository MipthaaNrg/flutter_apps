<?php
//Import File Koneksi Database
include '../config/functions.php';

//Membuat SQL Query
$rssql = "SELECT * FROM flutter_kategori";

//mendapatkan hasil
$sql = mysqli_query($con, $rssql);

//Membuat array kosong
$response = array();

while($a = mysqli_fetch_array($sql))
{
    //Memasukkan Nama dan ID kedalam array kosong:
    $b['idKategori'] = $a['idKategori'];
    $b['namaKategori'] = $a['namaKategori'];
    array_push($response, $b);
}

//menampilkan array dalam format json

echo json_encode($response);

?>