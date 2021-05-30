import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/core/services/AuthService.dart';
import 'package:sales_app/ui/pages/check_order.dart';
import 'package:sales_app/ui/pages/check_stock.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth auth = Auth();

  final _firestore = Firestore.instance;

  int stock;
  int orders;

  Future checkStocks<QuerySnapshot>() async {
    var result = await _firestore.collection('stock').getDocuments();
    setState(() {
      stock = result.documents.length;
    });
  }

  Future checkOrder<QuerySnapshot>() async {
    var result = await _firestore.collection('order').getDocuments();
    setState(() {
      orders = result.documents.length;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStocks();
    checkOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4530B3),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      auth.signOut();
                    },
                    child: Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF5351D5),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Quick Overview',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckStock()));
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFF5351D5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              stock.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Stocks',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                            )
                          ],
                        )),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOrder()));
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFF5351D5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              orders.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Orders',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                            )
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xFF5351D5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '765',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Credit',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xFF5351D5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '500',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Delivered',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
