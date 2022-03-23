import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shabusystem/helpers/dialog_helper.dart';
import 'package:shabusystem/model/menu.dart';
import 'package:shabusystem/screen/orderpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class stockingpage extends StatefulWidget {
  const stockingpage({Key? key}) : super(key: key);

  @override
  _stockingpageState createState() => _stockingpageState();
}

class _stockingpageState extends State<stockingpage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final menuCollect = FirebaseFirestore.instance.collection("menu");
  final List<Menu> menu = [];
  getdata() async {
    final _menu = await menuCollect.get();
    _menu.docs.forEach((element) {
      // print(element["ID"]);
      // print(element["name"]);
      // print(element["amount"]);
      // print(element["image"]);
      setState(() {
        menu.add(Menu.fromJson(element));
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 100, right: 50),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      'Stocking Shabu System',
                      style: GoogleFonts.beVietnamPro(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 50,
                    height: 50,
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const orderpage()),
                          );
                        },
                        icon: Image.asset(
                          'assets/Icon/stockingOrder.png',
                        )),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 0, left: 20),
                child: Text(
                  'wednesday 23 Mar, 2022',
                  style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.normal,
                      fontSize: 8,
                      color: Colors.grey),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, left: 20, right: 100, bottom: 20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
              ),

              //close navbarmenu

              StreamBuilder<QuerySnapshot>(
                  stream: menuCollect.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    }
                    final List<Menu> menues = [];
                    snapshot.data!.docs.forEach((element) {
                        final menu = Menu.fromJson(element.data());
                        menues.add(menu);
                      });
                    return GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: 2.2,
                      crossAxisCount: 2,
                      children: [
                        for (var m in menues)

                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                  .collection("menu")
                                  .doc(m.ID)
                                  .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox();
                                }
                              return Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 227,
                                width: 491,
                                child: Card(
                                  child: Row(
                                    children: [
                                      Image.asset('${m.image}',
                                          width: 250, fit: BoxFit.fill),
                                      Column(
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: 10, bottom: 5),
                                            child: Text(
                                              '${m.name}',
                                              style: GoogleFonts.beVietnamPro(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 24,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '${m.amount} Bowls available',
                                              style: GoogleFonts.beVietnamPro(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 55, left: 5),
                                                width: 100,
                                                height: 100,
                                                child: IconButton(
                                                    onPressed: () async {
                                                      return await DialogHelper.Minus_Stock_Popup(
                                                          context,
                                                          name: "${m.name}",
                                                          image: "${m.image}",
                                                          ID: "${m.ID}");
                                                    },
                                                    icon: Image.asset(
                                                      'assets/Icon/minusButton.png',
                                                    )),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 55, left: 20),
                                                width: 100,
                                                height: 100,
                                                child: IconButton(
                                                    onPressed: () async {
                                                      return await DialogHelper.exit(
                                                          context,
                                                          name: "${m.name}",
                                                          image: "${m.image}",
                                                          ID: "${m.ID}");
                                                    },
                                                    icon: Image.asset(
                                                      'assets/Icon/Plusbutton.png',
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          )
                      ],
                    );
                  })
            ]),
          ),
        ));
  }
}
