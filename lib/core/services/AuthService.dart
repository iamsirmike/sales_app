import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// import 'package:google_sign_in/google_sign_in.dart';

//create a user class and constructor
class User {
  final String uid;

  User({@required this.uid});
}

//create an abstract class
// abstract class AuthBase {
//   Future<User> getcurrentUser();
//   Future<User> signinAnonym();
//   Future<void> signOut();
//   Stream<User> get onAuthStateChanged;
// }

// hook the Auth class to the abstract class
class Auth {
  final _auth = FirebaseAuth.instance;

  // convert a firebaseUser object to a user object
  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  Stream<User> get onAuthStateChanged {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> getcurrentUser() async {
    final user = await _auth.currentUser();
    return _userFromFirebase(user);
  }

  Future<User> signinAnonym() async {
    final authResult = await _auth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<User> signInWithEmail(email, pass) async {
    final authResult =
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return _userFromFirebase(authResult.user);
  }

  Future<User> signupwithemail(email, pass) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return _userFromFirebase(authResult.user);
    } catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  //sig in with google
  // Future<User> signInWithGoogle() async {
  //   try {
  //     GoogleSignIn googleSignIn = GoogleSignIn();
  //     GoogleSignInAccount googleAccount = await googleSignIn.signIn();
  //     if (googleAccount != null) {
  //       final googleAuth = await googleAccount.authentication;
  //       if (googleAuth.accessToken != null && googleAuth.idToken != null) {
  //         final authResult = await _auth.signInWithCredential(
  //           GoogleAuthProvider.getCredential(
  //             idToken: googleAuth.idToken,
  //             accessToken: googleAuth.accessToken,
  //           ),
  //         );
  //         return _userFromFirebase(authResult.user);
  //       } else {
  //         throw PlatformException(
  //           code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
  //           message: 'Missing Google Auth Token',
  //         );
  //       }
  //     } else {
  //       throw PlatformException(
  //         code: 'ERROR_ABORTED_BY_USER',
  //         message: 'Sign in aborted by user',
  //       );
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  //signout
  Future<void> signOut() async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    // googleSignIn.signOut();
    await _auth.signOut();
  }
}
