import 'package:flutter/material.dart';
import 'package:shabusystem/screen/detail_order_popup.dart';
import 'package:shabusystem/screen/login.dart';
import 'package:shabusystem/screen/menupage.dart';
import 'package:shabusystem/screen/orderpage.dart';
import 'package:shabusystem/screen/stockingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: orderpage(), 
    );
  }
}
