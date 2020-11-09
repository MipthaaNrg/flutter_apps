-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Nov 2020 pada 03.24
-- Versi server: 10.1.36-MariaDB
-- Versi PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobile_globalshop`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `flutter_barang`
--

CREATE TABLE `flutter_barang` (
  `id_barang` int(11) NOT NULL,
  `idKategori` int(11) NOT NULL,
  `idSatuan` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `harga` decimal(10,0) NOT NULL,
  `image` text NOT NULL,
  `tglexpired` date NOT NULL,
  `tglinput` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `flutter_barang`
--

INSERT INTO `flutter_barang` (`id_barang`, `idKategori`, `idSatuan`, `userid`, `nama_barang`, `harga`, `image`, `tglexpired`, `tglinput`) VALUES
(1, 3, 1, 1, 'T-shirt Army', '300000', 'bts.jpg', '2020-10-16', '2020-10-15'),
(5, 1, 2, 1, 'Some by Mi AHA BHA PHA', '650000', '31102020131750scaled_image_picker3345264792061061566.jpg', '2020-11-30', '2020-10-31'),
(6, 1, 2, 1, 'Some by Mi Yuja Niacin', '600000', '31102020131907scaled_image_picker4865672868782429699.jpg', '2024-11-30', '2020-10-31'),
(7, 1, 2, 1, 'Some by Mi AC SOS ', '500000', '31102020131952scaled_image_picker8219703881512108299.jpg', '2024-11-30', '2020-10-31'),
(8, 5, 2, 1, 'Velvet Matte Lipstick ', '250000', '31102020132055scaled_image_picker7923833836466461328.jpg', '2024-11-30', '2020-10-31'),
(10, 4, 1, 1, 'HandWatch Cartier', '25000000', '31102020132303scaled_image_picker5420990796256009731.jpg', '2024-11-30', '2020-10-31'),
(11, 2, 1, 1, 'EyeGlasses Gold Cartier', '5000000', '31102020132412scaled_image_picker1656877399175854799.jpg', '2024-11-30', '2020-10-31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `flutter_kategori`
--

CREATE TABLE `flutter_kategori` (
  `idKategori` int(11) NOT NULL,
  `namaKategori` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `flutter_kategori`
--

INSERT INTO `flutter_kategori` (`idKategori`, `namaKategori`) VALUES
(1, 'Skincare'),
(2, 'Glasses'),
(3, 'T-Shirt'),
(4, 'Accesories'),
(5, 'Make Up'),
(6, 'Healthy');

-- --------------------------------------------------------

--
-- Struktur dari tabel `flutter_penjualan`
--

CREATE TABLE `flutter_penjualan` (
  `id_faktur` int(11) NOT NULL,
  `id_faktur_m` varchar(100) NOT NULL,
  `id_toko` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `tgl_penjualan` date NOT NULL,
  `grandtotal` decimal(10,0) NOT NULL,
  `nilaibayar` decimal(10,0) NOT NULL,
  `nilaikembali` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `flutter_penjualan_detail`
--

CREATE TABLE `flutter_penjualan_detail` (
  `id` int(11) NOT NULL,
  `id_faktur` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `harga` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `flutter_satuan`
--

CREATE TABLE `flutter_satuan` (
  `idSatuan` int(11) NOT NULL,
  `namaSatuan` varchar(225) NOT NULL,
  `satuan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `flutter_satuan`
--

INSERT INTO `flutter_satuan` (`idSatuan`, `namaSatuan`, `satuan`) VALUES
(1, 'peces', 'pcs'),
(2, 'Pack', 'Pack'),
(4, 'piece', 'pc');

-- --------------------------------------------------------

--
-- Struktur dari tabel `flutter_shopping_cart`
--

CREATE TABLE `flutter_shopping_cart` (
  `id_cart` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `harga` decimal(10,0) NOT NULL,
  `createDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `flutter_users`
--

CREATE TABLE `flutter_users` (
  `userid` int(11) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `level` int(11) NOT NULL,
  `nama` text NOT NULL,
  `status` int(11) NOT NULL,
  `createDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `flutter_barang`
--
ALTER TABLE `flutter_barang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indeks untuk tabel `flutter_kategori`
--
ALTER TABLE `flutter_kategori`
  ADD PRIMARY KEY (`idKategori`);

--
-- Indeks untuk tabel `flutter_penjualan`
--
ALTER TABLE `flutter_penjualan`
  ADD PRIMARY KEY (`id_faktur`);

--
-- Indeks untuk tabel `flutter_penjualan_detail`
--
ALTER TABLE `flutter_penjualan_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `flutter_satuan`
--
ALTER TABLE `flutter_satuan`
  ADD PRIMARY KEY (`idSatuan`);

--
-- Indeks untuk tabel `flutter_shopping_cart`
--
ALTER TABLE `flutter_shopping_cart`
  ADD PRIMARY KEY (`id_cart`);

--
-- Indeks untuk tabel `flutter_users`
--
ALTER TABLE `flutter_users`
  ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `flutter_barang`
--
ALTER TABLE `flutter_barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `flutter_kategori`
--
ALTER TABLE `flutter_kategori`
  MODIFY `idKategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `flutter_penjualan`
--
ALTER TABLE `flutter_penjualan`
  MODIFY `id_faktur` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `flutter_penjualan_detail`
--
ALTER TABLE `flutter_penjualan_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `flutter_satuan`
--
ALTER TABLE `flutter_satuan`
  MODIFY `idSatuan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `flutter_shopping_cart`
--
ALTER TABLE `flutter_shopping_cart`
  MODIFY `id_cart` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `flutter_users`
--
ALTER TABLE `flutter_users`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
