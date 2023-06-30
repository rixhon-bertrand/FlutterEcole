import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../routes/route.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({Key? key}) : super(key: key);


  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}


class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();

  String _nom = "";
  String _prenom = "";
  String _mail = "";
  String _phone = "";
  String _manga = "";

  void _resetForm() {
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title : GestureDetector(
            onTap: () async {
              await Navigator.pushNamed(context, kHomeScreen);
            },
            child :const Text("Page d'acceuil"),
          ),
          backgroundColor: Colors.transparent,
          titleSpacing: 0.0,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) => setState(() => _nom = value),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.person_add,
                          ),
                          labelText: 'Nom',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0)
                            ),
                          ),
                        ),
                      ),
                    ),
                     Expanded(
                      child: TextFormField(
                        onChanged: (value) => setState(() => _prenom = value),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Prénom',
                          border:
                          OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) => setState(() => _phone = value),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    labelText: 'Telephone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) => setState(() => _mail = value),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.mail,
                    ),
                    labelText: 'Mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) => setState(() => _manga = value),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.auto_awesome,
                    ),
                    labelText: 'Manga préféré',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 90),
                ElevatedButton(

                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final user = <String, String>{
                        "mail": _mail,
                        "manga": _manga,
                        "nom": _nom,
                        "prenom": _prenom,
                        "telephone": _phone
                      };

                      var collection = FirebaseFirestore.instance.collection('Clients');
                      collection
                          .doc(_phone)
                          .set(user) // DOC pour ajouter un id manuellement et SET pour ajouter lesdonnées.
                          .then((_) => print('Ajouté'))
                          .catchError((error) => print('Erreur d\'ajout: $error'));
                      ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(content: Text('Client ajouté.')),
                      );
                      _resetForm();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  const [
                      Icon(Icons.person_add),
                      SizedBox(width:5),
                      Text("Ajouter client"),
                    ],
                  ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}