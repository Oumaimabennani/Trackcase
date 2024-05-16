import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithEmailAndPassword(String email,
      String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print("Erreur d'authentification avec email et mot de passe: ${e
          .toString()}");
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn
          .signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
            .authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential result = await _auth.signInWithCredential(
            credential);
        return result.user;
      }
      return null;
    } catch (e) {
      print("Erreur d'authentification avec Google: ${e.toString()}");
      return null;
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final AuthCredential credential = FacebookAuthProvider.credential(
            accessToken.token);
        final UserCredential result = await _auth.signInWithCredential(
            credential);
        return result.user;
      }
      return null;
    } catch (e) {
      print("Erreur d'authentification avec Facebook: ${e.toString()}");
      return null;
    }
  }
}
