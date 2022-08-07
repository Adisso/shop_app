import 'package:firebase_auth/firebase_auth.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:shop_project/src/utils.dart';

import '../screens/login_succes/login_succes_screen.dart';
import '../screens/sign_in/sign_in_screen.dart';

final NavigationService navService = NavigationService();

class Auth {
  static Future signInToFirebase(
      {required String emailAddress, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  static Future goToStore() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        navService.pushNamed(LoginSuccesScreen.routeName);
      }
    });
  }

  static Future signOutFromFirebase() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  static Future goToLoginPage() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        navService.pushNamedAndRemoveUntil(SignInScreen.routeName);
      }
    });
  }

  static Future registerAccount({
    required String emailAddress,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }
}
