import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckStock extends StatefulWidget {
  @override
  _CheckStockState createState() => _CheckStockState();
}

class _CheckStockState extends State<CheckStock> {
  final _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.keyboard_arrow_left),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Check Stock',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('stock').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlue),
                  );
                }
                return ListView.separated(
                    itemCount: snapshot.data.documents.length,
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            snapshot.data.documents[index].data['product_name'],
                          ),
                          subtitle: Text(
                              'GHC${snapshot.data.documents[index].data['price']}'),
                          trailing: Text(
                              snapshot.data.documents[index].data['expiry']),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
