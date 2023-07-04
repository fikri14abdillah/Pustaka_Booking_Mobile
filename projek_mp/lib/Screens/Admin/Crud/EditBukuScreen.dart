import 'package:flutter/material.dart';
import 'package:projek_mp/size_config.dart';
import 'package:projek_mp/utils/constants.dart';

import '../../../Components/Admin/Crud/EditBuku/EditBukuComponent.dart';

class EditBukuScreens extends StatelessWidget {
  static var routeName = '/edit_buku_screens';
  static var dataBuku;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dataBuku = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        title: Text(
          "Edit Data Buku",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: EditBukuComponent(),
    );
  }
}
