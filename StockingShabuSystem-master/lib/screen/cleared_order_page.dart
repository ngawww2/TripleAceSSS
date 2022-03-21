import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shabusystem/helpers/dialog_helper.dart';
import 'package:shabusystem/model/menu.dart';
import 'package:shabusystem/model/order.dart';
import 'package:shabusystem/screen/cleared_order_popup.dart';
import 'package:shabusystem/screen/detail_order_popup.dart';
import 'package:shabusystem/screen/orderpage.dart';
import 'package:shabusystem/screen/stockingpage.dart';

class clearedPderpage extends StatefulWidget {
  const clearedPderpage({Key? key}) : super(key: key);

  @override
  _orderpageState createState() => _orderpageState();
}

class _orderpageState extends State<clearedPderpage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final orderCollect = FirebaseFirestore.instance.collection("order");
  // final List<Order> order = [];
  // getdata() async {
  //   final _order = await orderCollect.get();
  //   _order.docs.forEach((element) {
  //     // print(element["ID"]);
  //     // print(element["name"]);
  //     // print(element["amount"]);
  //     // print(element["image"]);
  //     setState(() {
  //       order.add(Order.fromJson(element));
  //     });
  //   });
  // }
  final now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    // getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final date = now.subtract(Duration(days: 1));
    print(date.year);
    print(date.month);
    print(date.day);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
                child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 100),
                    child: Text(
                      'Ordering Shabu System',
                      style: GoogleFonts.beVietnamPro(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, right: 20),
                        height: 40,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            side: BorderSide(color: Colors.deepOrange, width: 3),
                            padding: const EdgeInsets.all(16.0),
                            primary: Colors.deepOrange,
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          child: const Text('Ordering'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const orderpage()),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, right: 100),
                        height: 40,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            padding: const EdgeInsets.all(16.0),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          child: const Text('Delete all order'),
                          onPressed: () async {
                            final orders = await FirebaseFirestore.instance
                                .collection("order")
                                .get();
                            for (var order in orders.docs) {
                              // print(order.id);
                              await FirebaseFirestore.instance
                                  .collection("order")
                                  .doc(order.id)
                                  .delete();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 0, left: 100),
                child: Text(
                  'Tuesday 2 Feb, 2021',
                  style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.normal,
                      fontSize: 8,
                      color: Colors.grey),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, left: 100, right: 100, bottom: 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
              ),

              //close navbarmenu

              StreamBuilder<QuerySnapshot>(
                  stream: orderCollect
                      .where("dateTime",
                          isGreaterThan: DateTime(now.year, now.month, now.day))
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    }
                    final List<Order> orders = [];
                    int i = 0;
                    snapshot.data!.docs.forEach((element) {
                      i++;
                      if ((element.data() as dynamic)["status"]) {
                        final order = Order.fromJson(element.data());
                        order.count = i;
                        orders.add(order);
                      }
                      // print(element["ID"]);
                      // print(element["name"]);
                      // print(element["amount"]);
                      // print(element["image"]);
                      // setState(() {

                      // });
                    });
                    print(snapshot.data!.docs.length);
                    return GridView.count(
                      padding: EdgeInsets.only(left: 80, right: 50),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: 2.2,
                      crossAxisCount: 2,
                      children: [
                        for (var o in orders)
                          FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection("menu")
                                  .doc(o.menuID)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox();
                                }
                                final menu =
                                    Menu.fromJson(snapshot.data!.data());
                                return Container(
                                    child: Row(children: [
                                  Row(children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 227,
                                      width: 491,
                                      child: Card(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 20,
                                              color: Colors.red,
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 245.5,
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child: Text(
                                                        'Order',
                                                        style:
                                                            GoogleFonts.barlow(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child: Text(
                                                        '${o.count}',
                                                        style:
                                                            GoogleFonts.barlow(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 70,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 200,
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                          top: 10, bottom: 60),
                                                      child: Text(
                                                        '${o.table}',
                                                        style:
                                                            GoogleFonts.barlow(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      width: 100,
                                                      margin: EdgeInsets.only(
                                                          top: 30, left: 100),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      Colors
                                                                          .white),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .deepOrangeAccent),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ClearedOrderDetail(
                                                                          menu:
                                                                              menu,
                                                                          order:
                                                                              o,
                                                                        )),
                                                          );
                                                        },
                                                        child: Text('Detail'),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ])
                                ]));
                              })
                      ],
                    );
                  })
            ]))));
  }
}
