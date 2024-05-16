import 'package:flutter/material.dart';
import 'package:trackcase/screens/profile.dart';
import 'package:trackcase/screens/liste_des_colis_screen.dart';
import 'package:trackcase/screens/deconnexion.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/im6.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 30,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mon profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Liste de colis à livrer'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ListeDesColisScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: () {
              DeconnexionPage().signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
