import 'package:flutter/material.dart';
import 'package:projek_mp/Screens/Admin/Crud/EditBukuScreen.dart';
import 'package:projek_mp/Screens/Admin/Crud/InputBukuScreen.dart';
import 'package:projek_mp/Screens/Admin/HomeAdminScreens.dart';
import 'package:projek_mp/Screens/Register/RegistrasiScreens.dart';
import 'package:projek_mp/Screens/Login/LoginScreens.dart';
import 'package:projek_mp/Screens/User/Buku/DataBukuScreens.dart';
import 'package:projek_mp/Screens/User/HomeUserScreens.dart';

import 'Screens/User/Transaksi/DataTransaksiUser.dart';
import 'Screens/User/Transaksi/TransaksiScreens.dart';
import 'Screens/User/Transaksi/UploadBuktiBayar.dart';

final Map<String, WidgetBuilder> routes = {
  // Login registrasi
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),

  //routes user biasa
  HomeUserScreen.routeName: (context) => HomeUserScreen(),
  DataBukuScreens.routeName: (context) => DataBukuScreens(),
  TransaksiScreens.routeName: (context) => TransaksiScreens(),
  DataTransaksiScreens.routeName: (context) => DataTransaksiScreens(),
  UploadBuktiPembayaranScreens.routeName: (context) =>
      UploadBuktiPembayaranScreens(),

  //routes admin
  HomeAdminScreens.routeName: (context) => HomeAdminScreens(),
  InputBukuScreens.routeName: (context) => InputBukuScreens(),
  EditBukuScreens.routeName: (context) => EditBukuScreens(),
};
