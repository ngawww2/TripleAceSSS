// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shabusystem/screen/menupage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginpage extends StatefulWidget {
  loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _nameState();
}

class _nameState extends State<loginpage> {
  login() async {
    final firestore = FirebaseFirestore.instance.collection("user");
    final res = await firestore
        .where("username", isEqualTo: username.text)
        .where("password", isEqualTo: password.text)
        .get();
    if (res.docs.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username.text);
      Navigator.push(context, MaterialPageRoute(builder: (_) => menupage()));
    }
  }

  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                "Stocking Shabu System",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                    fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 400),
              child: TextField(
                controller: username,
                decoration: InputDecoration(labelText: "Username"),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 400),
              child: TextField(
                controller: password,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: RaisedButton(
                onPressed: () {
                  login();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: 200,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    color: Colors.deepOrange,
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
