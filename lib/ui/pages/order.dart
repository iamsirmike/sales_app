import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sales_app/ui/pages/home.dart';
import 'package:sales_app/ui/pages/navigation.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  bool isLoading = false;
  String productName;
  String quantity;
  String price;
  String address;

  final _firestore = Firestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF4530B3),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Place an Order',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    productName = value;
                  },
                  decoration: InputDecoration(hintText: 'Product name'),
                ),
                SizedBox(height: 15),
                TextFormField(
                  onChanged: (value) {
                    quantity = value;
                  },
                  decoration: InputDecoration(hintText: 'Quantity'),
                ),
                SizedBox(height: 15),
                TextFormField(
                  onChanged: (value) {
                    price = value;
                  },
                  decoration: InputDecoration(hintText: 'Price'),
                ),
                SizedBox(height: 15),
                TextFormField(
                  onChanged: (value) {
                    address = value;
                  },
                  decoration: InputDecoration(hintText: 'Address'),
                ),
                SizedBox(height: 30),
                FlatButton(
                  color: Colors.blue,
                  height: 50,
                  minWidth: 400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
                    // if (!_formKey.currentState.validate()) return;
                    // _formKey.currentState.save();
                    // _login();
                    if (!_formKey.currentState.validate()) return;
                    _formKey.currentState.save();
                    _addStock();
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : Text(
                          'Order',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addStock() async {
    setState(() {
      isLoading = true;
    });
    final result = await _firestore.collection('order').add({
      "product_name": productName,
      "quantity": quantity,
      "price": price,
      "address": address
    });
    if (result != null) {
      _formKey.currentState.reset();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Navigation()));
    }
    setState(() {
      isLoading = false;
    });
  }
}
