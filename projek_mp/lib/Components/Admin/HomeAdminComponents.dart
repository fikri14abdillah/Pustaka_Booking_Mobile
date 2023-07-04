import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:projek_mp/Api/configAPI.dart';
import 'package:projek_mp/Screens/Admin/Crud/EditBukuScreen.dart';
import 'package:projek_mp/Screens/Admin/HomeAdminScreens.dart';
import 'package:projek_mp/size_config.dart';
import 'package:projek_mp/utils/constants.dart';

class HomeAdminComponent extends StatefulWidget {
  @override
  _HomeAdminComponent createState() => _HomeAdminComponent();
}

class _HomeAdminComponent extends State<HomeAdminComponent> {
  Response? response;
  var dio = Dio();
  var dataBuku;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataBuku();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: dataBuku == null ? 0 : dataBuku.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardDataBuku(dataBuku[index]);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardDataBuku(data) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 253, 253, 253)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child: Image.network('$baseUrl/${data['gambar']}'),
          ),
          title: Text(
            '${data['nama_buku']}',
            style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, EditBukuScreens.routeName,
                    arguments: data);
              },
              child: Row(children: [
                Icon(
                  Icons.edit,
                  color: kColorYellow,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Edit",
                  style: TextStyle(
                      color: mTitleColor, fontWeight: FontWeight.bold),
                )
              ]),
            ),
            GestureDetector(
              onTap: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.ERROR,
                    animType: AnimType.RIGHSLIDE,
                    title: 'Peringatan',
                    desc: 'Yakin Ingin Menghapus ${data['nama_buku']} ?.....',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      hapusDataBuku('${data['_id']}');
                    }).show();
              },
              child: Row(children: [
                Icon(
                  Icons.delete,
                  color: kColorRedSlow,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Hapus",
                  style: TextStyle(
                      color: mTitleColor, fontWeight: FontWeight.bold),
                )
              ]),
            )
          ]),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: mTitleColor,
            size: 30.0,
          ),
        ),
      ),
    );
  }

  void getDataBuku() async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.get(getAllBuku);
      status = response!.data['sukses'];
      msg = response!.data['msg'];
      if (status) {
        setState(() {
          dataBuku = response!.data['data'];
        });
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
          desc: 'Terjadi kesalahan pada server kami',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }

  void hapusDataBuku(id) async {
    utilsApps.showDialog(context);
    bool status;
    var msg;
    try {
      response = await dio.delete('$hapusBuku/$id');
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
              // Navigator.pushAndRemoveUntil(
              //     context, HomeAdminScreens.routeName, (route) => false);
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
          desc: 'Terjadi kesalahan pada server kami',
          btnOkOnPress: () {
            utilsApps.hideDialog(context);
          }).show();
    }
  }
}
