import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projek_mp/Api/configAPI.dart';
import 'package:projek_mp/Components/custom_surfix_icon.dart';
import 'package:projek_mp/Components/default_button_custome_color.dart';
import 'package:projek_mp/Screens/Admin/Crud/EditBukuScreen.dart';
import 'package:projek_mp/Screens/User/HomeUserScreens.dart';
import 'package:projek_mp/size_config.dart';
import 'package:projek_mp/utils/constants.dart';
import 'dart:convert';

import '../../../../Screens/Admin/HomeAdminScreens.dart';

class FormEditBuku extends StatefulWidget {
  @override
  _FormEditBuku createState() => _FormEditBuku();
}

class _FormEditBuku extends State<FormEditBuku> {
  TextEditingController txtNamaBuku = TextEditingController(
          text: '${EditBukuScreens.dataBuku['nama_buku']}'),
      txtPengarangBuku = TextEditingController(
          text: '${EditBukuScreens.dataBuku['pengarang']}'),
      txtSinopsisBuku = TextEditingController(
          text: '${EditBukuScreens.dataBuku['sinopsis']}');

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
          buildNamaBuku(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPengarangBuku(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSinopsisBuku(),
          SizedBox(height: getProportionateScreenHeight(30)),
          image == null
              ? Image.network(
                  '$baseUrl/${EditBukuScreens.dataBuku['gambar']}',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  image!,
                  // width: 250,
                  // height: 250,
                  fit: BoxFit.cover,
                ),
          DefaultButtonCustomeColor(
            color: kColorBlue,
            text: "Pilih Gambar Buku",
            press: () {
              pilihGambar();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "SUBMIT",
            press: () {
              if (txtNamaBuku.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Peringatan',
                        desc: 'Nama Buku tidak boleh kosong',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtPengarangBuku.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Peringatan',
                        desc: 'Pengarang Buku tidak boleh kosong',
                        btnOkOnPress: () {})
                    .show();
              } else if (txtSinopsisBuku.text == '') {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHSLIDE,
                        title: 'Peringatan',
                        desc: 'Sinopsis Buku tidak boleh kosong',
                        btnOkOnPress: () {})
                    .show();
              } else {
                editDataBuku(txtNamaBuku.text, txtPengarangBuku.text,
                    txtSinopsisBuku.text, image?.path);
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  TextFormField buildNamaBuku() {
    return TextFormField(
      controller: txtNamaBuku,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Nama Buku',
          hintText: 'Masukan Nama Buku',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_chart_sharp)),
    );
  }

  TextFormField buildPengarangBuku() {
    return TextFormField(
      controller: txtPengarangBuku,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Pengarang Buku',
          hintText: 'Masukan Pengarang Buku',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_chart_sharp)),
    );
  }

  TextFormField buildSinopsisBuku() {
    return TextFormField(
      controller: txtSinopsisBuku,
      keyboardType: TextInputType.number,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Sinopsis Buku',
          hintText: 'Masukan Sinopsis Buku',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_chart_sharp)),
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

  void editDataBuku(
      txtNamaBuku, txtPengarangBuku, txtSinopsisBuku, gambar) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      var formData = FormData.fromMap({
        'nama_buku': txtNamaBuku,
        'pengarang': txtPengarangBuku,
        'sinopsis': txtSinopsisBuku,
        'gambar': image == null ? '' : await MultipartFile.fromFile(gambar)
      });

      response = await dio.put('$editBuku/${EditBukuScreens.dataBuku['_id']}',
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
              Navigator.pushNamed(context, HomeAdminScreens.routeName);
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
