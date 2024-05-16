import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _firstName = "";
  String _lastName = "";
  String _phoneNumber = "";
  String _selectedCountryCode = "+216";
  File? _image;

  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void removeImage() {
    setState(() {
      _image = null;
    });
  }

  Future<void> saveProfile() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Mettre à jour les informations du profil utilisateur
        await user.updateProfile(displayName: '$_firstName $_lastName');
        // Vous pouvez ajouter plus d'informations au profil utilisateur si nécessaire

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil enregistré avec succès!')),
        );
      }
    } catch (error) {
      print('Erreur lors de l\'enregistrement du profil: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de l\'enregistrement du profil. Veuillez réessayer.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/colis.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Supprimer la photo'),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text('Ajouter depuis la galerie'),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 1) {
                      removeImage();
                    } else if (value == 2) {
                      getImageFromGallery();
                    }
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : const AssetImage('assets/images/ima.png') as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _firstName = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _lastName = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Prénom',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _phoneNumber = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Numéro de téléphone',
                          border: OutlineInputBorder(),
                          prefixIcon: DropdownButton<String>(
                            value: _selectedCountryCode,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCountryCode = newValue!;
                              });
                            },
                            items: <String>["+216", "+1", "+44", "+33"] // Ajoutez d'autres codes ici
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                          prefixText: " ", // Ajoutez un espace pour le texte préfixe
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Enregistrer les informations du profil utilisateur
                    saveProfile();
                  },
                  child: const Text('Enregistrer les informations'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Modifier les informations du profil utilisateur
                    // Vous pouvez ajouter votre logique de modification ici
                  },
                  child: const Text('Modifier les informations'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
