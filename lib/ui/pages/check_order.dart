import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckOrder extends StatefulWidget {
  @override
  _CheckOrderState createState() => _CheckOrderState();
}

class _CheckOrderState extends State<CheckOrder> {
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
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.keyboard_arrow_left),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Check Order',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('order').snapshots(),
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
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(snapshot
                                  .data.documents[index].data['address']),
                                  SizedBox(height: 5,),
                              GestureDetector(
                                onTap: () {
                                  _firestore
                                      .collection('order')
                                      .document(snapshot
                                          .data.documents[index].documentID)
                                      .delete();
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
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
