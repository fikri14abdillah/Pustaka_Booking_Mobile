import 'package:flutter/material.dart';
import 'package:projek_mp/size_config.dart';
import 'package:projek_mp/utils/constants.dart';

import 'package:projek_mp/Components/User/Buku/BukuComponents.dart';

class DataBukuScreens extends StatelessWidget {
  static var routeName = '/list_buku_user_screens';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Daftar Buku",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: BukuComponents(),
    );
  }
}
