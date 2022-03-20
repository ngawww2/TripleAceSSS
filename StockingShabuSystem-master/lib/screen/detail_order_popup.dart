import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shabusystem/model/menu.dart';
import 'package:shabusystem/model/order.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class DetailOrderPopup extends StatefulWidget {
  final Menu menu;
  final Order order;
  DetailOrderPopup({required this.menu, required this.order});
  @override
  State<DetailOrderPopup> createState() => _ExitConfirmationDialogState();
}

class _ExitConfirmationDialogState extends State<DetailOrderPopup> {
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
                  //images
                  widget.menu.image,
                  height: 200,
                  width: 200,
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
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16), //menu name
              child: Text(
                widget.order.table,
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16), //menu name
              child: Text(
                widget.menu.name,
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16), //menu name
              child: Text(
                widget.order.amount.toString(),
                style: TextStyle(color: Colors.white , fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 30,
                  color: Colors.white,
                  child: FlatButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("order")
                          .doc(widget.order.ID)
                          .update({"status" : true});
                      Navigator.of(context).pop();
                    },
                    child: Text('Clear'),
                    textColor: Colors.deepOrange,
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
