import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projek_mp/Api/configAPI.dart';
import 'package:projek_mp/Components/custom_surfix_icon.dart';
import 'package:projek_mp/Components/default_button_custome_color.dart';
import 'package:projek_mp/Screens/Admin/HomeAdminScreens.dart';
import 'package:projek_mp/Screens/Register/RegistrasiScreens.dart';
import 'package:projek_mp/Screens/User/HomeUserScreens.dart';
import 'package:projek_mp/Screens/User/Transaksi/UploadBuktiBayar.dart';
import 'package:projek_mp/size_config.dart';
import 'package:projek_mp/utils/constants.dart';
import 'dart:convert';

class FormUploadPembayaran extends StatefulWidget {
  @override
  _FormUploadPembayaran createState() => _FormUploadPembayaran();
}

class _FormUploadPembayaran extends State<FormUploadPembayaran> {
  FocusNode focusNode = new FocusNode();
  File? image;
  Response? response;
  var dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loginProses();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          image == null
              ? Container()
              : Image.file(
                  image!,
                  // width: 250,
                  // height: 250,
                  fit: BoxFit.cover,
                ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButtonCustomeColor(
            color: kColorBlue,
            text: "Pilih Bukti Peminjaman",
            press: () {
              pilihGambar();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "SUBMIT",
            press: () {
              uploadBukti(image!.path);
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future pilihGambar() async {
    try {
      final image = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print("Gagal mengambil foto : $e");
    }
  }

  void uploadBukti(gambar) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap(
          {'buktiPembayaran': await MultipartFile.fromFile(gambar)});

      response = await dio.put(
          '$uploadBuktiPembayaran/${UploadBuktiPembayaranScreens.dataTransaksi['_id']}',
          data: formData);
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            title: 'Peringatan',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
              Navigator.pushNamed(context, HomeUserScreen.routeName,
                  arguments: HomeUserScreen.dataUserLogin);
            }).show();
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            title: 'Peringatan',
            desc: '$msg',
            btnOkOnPress: () {
              utilsApps.hideDialog(context);
            }).show();
      }
    } catch (e) {
      print(e);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Peringatan',
          desc: 'Terjadi Kesalahan Pada Server Kami!!!!!!',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
