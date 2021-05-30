import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales_app/ui/pages/add_stock.dart';
import 'package:sales_app/ui/pages/home.dart';
import 'package:sales_app/ui/pages/order.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;

  final bottomItems = [
    {'icon': Icon(FontAwesome.home), 'text': 'Home'},
    {"icon": Icon(FontAwesome.clipboard), 'text': 'Order'},
    {"icon": Icon(FontAwesome.align_center), 'text': 'Inventory'},
    {"icon": Icon(FontAwesome.cog), 'text': 'Account'},
  ];

  final pages = [
    HomePage(),
    Order(),
    AddStock(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(0),
        height: height / 9,
        decoration: BoxDecoration(
          color: Color(0xFF4530B3),
        ),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: bottomItems
                .asMap()
                .map((i, icon) {
                  bool active = i == currentIndex;
                  final color = active ? Color(0xffFFFFFF) : Color(0XFFcfcfcf);
                  Widget button;

                  button = Column(
                    children: <Widget>[
                      IconButton(
                        icon: icon["icon"],
                        color: color,
                        onPressed: () => setState(() => currentIndex = i),
                      ),
                      Text(icon["text"].toString(),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: color,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ],
                  );
                  return MapEntry(i, button);
                })
                .values
                .toList(),
          ),
        ),
      ),
    );
  }
}
