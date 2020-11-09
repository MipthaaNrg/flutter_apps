<?php

//import file
include '../config/functions.php';

//query sql
$rssql = "SELECT * FROM flutter_kategori";
//dapatkan hasil
$sql = mysqli_query($con,$rssql);

//deklarasi array
$response = array();

while($a = mysqli_fetch_array($sql))
{
    //memasukan data field kedallam variabel
    $b['idKategori'] = $a['idKategori'];
    $b['namaKategori'] = $a['namaKategori'];
   
    array_push($response, $b);

}

echo json_encode($response);

?>