<?php

//import file
include '../config/functions.php';

//query sql
$rssql = "SELECT * FROM flutter_barang";
//dapatkan hasil
$sql = mysqli_query($con,$rssql);

//deklarasi array
$response = array();

while($a = mysqli_fetch_array($sql))
{
    //memasukan data field kedallam variabel
    $b['id_barang'] = $a['id_barang'];
    $b['idKategori'] = $a['idKategori'];
    $b['idSatuan'] = $a['idSatuan'];
    $b['nama_barang'] = $a['nama_barang'];
    $b['harga'] = $a['harga'];
    $b['image'] = $a['image'];
    $b['tglexpired'] = $a['tglexpired'];
    array_push($response, $b);

}

echo json_encode($response);

?>