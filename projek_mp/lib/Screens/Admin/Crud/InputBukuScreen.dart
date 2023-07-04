import 'package:flutter/material.dart';
import 'package:projek_mp/Components/Admin/Crud/InputBuku/InputBukuComponent.dart';
import 'package:projek_mp/utils/constants.dart';

class InputBukuScreens extends StatelessWidget {
  static var routeName = '/input_buku_screens';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Input Data Buku",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: InputBukuComponent(),
    );
  }
}
