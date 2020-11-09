<?php 
    include  '../config/functions.php';


    $idBarang = $_POST['id_barang'];
    $idKategori = $_POST['idKategori'];
    $idSatuan = $_POST['idSatuan'];
    $userid = $_POST['userid'];
    $imgServe = $_FILES['image']['name'];
    $tempName = $_FILES['image']['tmp_name'];
    
    $nama_barang = $_POST['nama_barang'];
    $harga = $_POST['harga'];
    $tglexpired = $_POST['tglexpired'];
    $namaTabel = "flutter_barang";

    header('Content-Type: text/xml');
    
    $queryImg = "";
    if ($imgServe != "") {
        $image = date('dmYHis').str_replace(" ","",basename($imgServe));
        $imagePath = sprintf('../uploads/%s',$image);
        move_uploaded_file($tempName,$imagePath);
        $queryImg = ",image='$image'";
    }

    $hasil = $db->query("UPDATE $namaTabel SET nama_barang = '$nama_barang' , harga='$harga' $queryImg , idKategori='$idKategori', idSatuan='$idSatuan', tglexpired = '$tglexpired'WHERE id_barang = '$idBarang'");

    // $sql = mysqli_query($con, $query);

    // $responses = [];
    $responses = array("code" => null,"data" => null,"message" => null);
    $idx = 0;

    if ($hasil) {
        $responses['code'] = 200;
        $responses['message'] = "Berhasil Update Data";
    } else {
        $responses["code"] = 400;
        $responses['message'] = "Gagal Update Data";
    }
    

    // echo ($responses["data"]);
    echo json_encode($responses);
