import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackcase/screens/welcom_screen.dart'; // Assurez-vous d'importer correctement votre page de connexion

class DeconnexionPage extends StatelessWidget {
  const DeconnexionPage({Key? key}) : super(key: key);

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Rediriger l'utilisateur vers l'écran de connexion (WelcomeScreen)
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WelcomeScreen()));
    } catch (e) {
      print('Erreur lors de la déconnexion : $e');
      // Afficher un message d'erreur à l'utilisateur s'il y a un problème lors de la déconnexion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la déconnexion. Veuillez réessayer.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Déconnexion'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => signOut(context),
          child: Text('Déconnexion'),
        ),
      ),
    );
  }
}
// f liste_des_colis_screen