import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shabusystem/model/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class MinusStockPopup extends StatefulWidget {
  final String name;
  final String image;
  final String ID;
  MinusStockPopup({required this.name, required this.image, required this.ID});
  @override
  State<MinusStockPopup> createState() => _ExitConfirmationDialogState();
}

class _ExitConfirmationDialogState extends State<MinusStockPopup> {
  int _n = 1;
  CollectionReference menu = FirebaseFirestore.instance.collection('menu');
  CollectionReference order = FirebaseFirestore.instance.collection('order');
  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 1) _n--;
    });
  }

  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 400,
        width: 350,
        decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  widget.image,
                  height: 120,
                  width: 120,
                ),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
            SizedBox(
              height: 24,
            ),
            new Container(
              height: 100,
              child: new Center(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new FloatingActionButton(
                      onPressed: minus,
                      child: new Icon(Icons.remove, color: Colors.black),
                      backgroundColor: Colors.white,
                    ),
                    new Text('$_n', style: new TextStyle(fontSize: 60.0)),
                    new FloatingActionButton(
                      onPressed: add,
                      child: new Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Text(
                widget.name,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('cancel'),
                  textColor: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                RaisedButton(
                  onPressed: () async {
                    // print(_n);
                    final _am = Menu.fromJson(await menu.doc(widget.ID).get());
                    final amount = _am.amount - _n;
                    await menu.doc(widget.ID).update({'amount': amount});
                    return Navigator.of(context).pop(true);
                  },
                  child: Text('confirm'),
                  color: Colors.white,
                  textColor: Colors.redAccent,
                )
              ],
            )
          ],
        ),
      );
}
