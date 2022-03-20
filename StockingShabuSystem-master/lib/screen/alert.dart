import 'package:flutter/material.dart';
class Alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  Text('หมูสามชั้น', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 5,),
                  Text('ของหมดแล้ว', style: TextStyle(fontSize: 20),),
                  SizedBox(height: 20,),
                  RaisedButton(onPressed: () {
                    Navigator.of(context).pop();
                  },
                    color: Colors.yellowAccent,
                    child: Text('close', style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: Colors.yellowAccent,
              radius: 60,
              child: Image.asset('assets/icon/alerticon.png'),
            )
          ),
        ],
      )
    );
  }
}

