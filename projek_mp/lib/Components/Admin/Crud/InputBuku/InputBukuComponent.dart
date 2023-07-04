import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:projek_mp/Components/Admin/Crud/InputBuku/InputBukuForm.dart';
import 'package:projek_mp/Components/Login/LoginForm.dart';
import 'package:projek_mp/size_config.dart';
import 'package:projek_mp/utils/constants.dart';

class InputBukuComponent extends StatefulWidget {
  @override
  _InputBukuComponent createState() => _InputBukuComponent();
}

class _InputBukuComponent extends State<InputBukuComponent> {
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
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Input Data Buku",
                          style: mTitleStyle,
                        )
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                FormInputBuku()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
