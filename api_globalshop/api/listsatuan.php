<?php
//Import File Koneksi Database
include '../config/functions.php';

//Membuat SQL Query
$rssql = "SELECT * FROM flutter_satuan";

//mendapatkan hasil
$sql = mysqli_query($con, $rssql);

//Membuat array kosong
$response = array();

while($a = mysqli_fetch_array($sql))
{
    //Memasukkan Nama dan ID kedalam array kosong:
    $b['idSatuan'] = $a['idSatuan'];
    $b['namaSatuan'] = $a['namaSatuan'];
    $b['satuan'] = $a['satuan'];
    array_push($response, $b);
}

//menampilkan array dalam format json

echo json_encode($response);

?>