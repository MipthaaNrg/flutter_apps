<?php

//import file
include '../config/functions.php';

//query sql
$rssql = "SELECT * FROM flutter_satuan";
//dapatkan hasil
$sql = mysqli_query($con,$rssql);

//deklarasi array
$response = array();

while($a = mysqli_fetch_array($sql))
{
    //memasukan data field kedallam variabel
    $b['idSatuan'] = $a['idSatuan'];
    $b['namaSatuan'] = $a['namaSatuan'];
    $b['satuan'] = $a['satuan'];
    array_push($response, $b);

}

echo json_encode($response);

?>