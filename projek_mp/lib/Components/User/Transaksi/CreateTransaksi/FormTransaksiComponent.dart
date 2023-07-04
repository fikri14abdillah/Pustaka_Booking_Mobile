import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:projek_mp/Api/configAPI.dart';
import 'package:projek_mp/Components/default_button_custome_color.dart';
import 'package:projek_mp/Screens/User/HomeUserScreens.dart';
import 'package:projek_mp/Screens/User/Transaksi/TransaksiScreens.dart';
import 'package:projek_mp/size_config.dart';
import 'package:projek_mp/utils/constants.dart';

class TransaksiForm extends StatefulWidget {
  @override
  State<TransaksiForm> createState() => _TransaksiFormState();
}

class _TransaksiFormState extends State<TransaksiForm> {
  Response? response;
  var dio = Dio();
  @override
  Widget build(BuildContext context) {
    print(TransaksiScreens.dataBuku);
    return Form(
        child: Column(
      children: [
        Image.network(
          "$baseUrl/${TransaksiScreens.dataBuku['gambar']}",
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama Buku",
                style: mTitleStyle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${TransaksiScreens.dataBuku['nama_buku']}",
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pengarang Buku",
                style: mTitleStyle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${TransaksiScreens.dataBuku['pengarang']}",
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sinopsis Buku",
                style: mTitleStyle,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${TransaksiScreens.dataBuku['sinopsis']}",
              )
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        DefaultButtonCustomeColor(
          color: kPrimaryColor,
          text: "Pinjam Buku",
          press: () {
            AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    animType: AnimType.RIGHSLIDE,
                    title: 'Peringatan',
                    desc:
                        'Yakin ingin melakukan peminjaman ${TransaksiScreens.dataBuku['nama_buku']} ?',
                    btnOkOnPress: () {
                      prosesTransaksi(TransaksiScreens.dataBuku['_id'],
                          HomeUserScreen.dataUserLogin['_id']);
                    },
                    btnCancelOnPress: () {})
                .show();
          },
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
      ],
    ));
  }

  void prosesTransaksi(idBuku, idUser) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.post(createTransaksi, data: {
        'idBuku': idBuku,
        'idUser': idUser,
      });

      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.RIGHSLIDE,
          title: 'Peringatan',
          desc: 'Berhasil Transaksi',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
            Navigator.pushNamed(context, HomeUserScreen.routeName,
                arguments: HomeUserScreen.dataUserLogin);
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          title: 'Peringatan',
          desc: 'Gagal Transaksi => $msg',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        title: 'Peringatan',
        desc: 'Terjadi Kesalahan Pada Server',
        btnOkOnPress: () {
          utilsApps.hideDialog(context);
        },
      ).show();
    }
  }
}
