String baseUrl = 'http://172.20.169.58:5001';

//AUTH
String urlRegister = '$baseUrl/user/register';
String urlLogin = '$baseUrl/user/login';

//Crud Buku
String inputBuku = '$baseUrl/buku/create';
String editBuku = '$baseUrl/buku/edit';
String getAllBuku = '$baseUrl/buku/getall';
String hapusBuku = '$baseUrl/buku/hapus';
String getByIdBuku = '$baseUrl/buku/getbyid';

//Transaksi
String createTransaksi = '$baseUrl/transaksi/create';
String getTransaksiUser = '$baseUrl/transaksi/getbyiduser';
String getTransaksiUserLimit = '$baseUrl/transaksi/getbyiduserlimit';
String uploadBuktiPembayaran = '$baseUrl/transaksi/upload-bukti';
