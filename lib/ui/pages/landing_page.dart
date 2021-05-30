import 'package:flutter/material.dart';
import 'package:sales_app/core/services/AuthService.dart';
import 'package:sales_app/ui/pages/auth/login.dart';
import 'package:sales_app/ui/pages/home.dart';
import 'package:sales_app/ui/pages/navigation.dart';

class LandingPage extends StatelessWidget {
  final Auth auth = Auth();
  // const LandingPage({this.auth});

  @override
  Widget build(BuildContext context) {
    //check to see if user is logged in or not (if not redirect to signup page else home page)
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            print(user);
            if (user == null) {
              // return a page when the user is not loged in
              return LoginPage();
            }
            return Navigation();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}