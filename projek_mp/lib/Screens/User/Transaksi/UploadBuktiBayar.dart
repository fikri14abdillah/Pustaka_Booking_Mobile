import 'package:flutter/material.dart';
import 'package:projek_mp/size_config.dart';
import 'package:projek_mp/utils/constants.dart';

import '../../../Components/User/Transaksi/UploadBuktiPembayaran/UploadPembayaranComponent.dart';

class UploadBuktiPembayaranScreens extends StatelessWidget {
  static var routeName = '/upload_bukti_pembayaran';
  static var dataTransaksi;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataTransaksi = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Upload Bukti Peminjaman",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: UploadPembayaranComponent(),
    );
  }
}
