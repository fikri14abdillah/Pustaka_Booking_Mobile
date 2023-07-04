import 'package:flutter/material.dart';
import 'package:projek_mp/Screens/Login/LoginScreens.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  runApp(MaterialApp(
      title: "Toko Buku",
      theme: theme(),
      initialRoute: LoginScreen.routeName,
      debugShowCheckedModeBanner: false,
      routes: routes));
}
