import 'package:crud_app_demo/create.dart';
import 'package:crud_app_demo/edit.dart';
import 'package:crud_app_demo/home.dart';
import 'package:crud_app_demo/login.dart';
import 'package:crud_app_demo/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context)=>const MyLogin(),
        'register': (context)=>const MyRegister(),
        'home': (context)=>const MyHome(),
        'create': (context)=>const CreatePage(),
        'edit': (context)=>const EditPage(),
      },
    )
  );
}