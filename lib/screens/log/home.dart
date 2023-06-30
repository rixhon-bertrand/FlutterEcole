import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resto_mag/routes/route.dart';

import '../../db/ClientList.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title : GestureDetector(
            onTap: () async {
              FirebaseAuth.instance.signOut();
              await Navigator.pushNamed(context, kAuthScreen);
            },
            child :const Text("Menu de connexion"),
          ),
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, kAuthScreen);
            },
          ),
        ),
        body: const Center(
          child: SingleChildScrollView(
            // centre les elements et pousse le contenu quand on ecrit avec le clavier
            padding: EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: ClientsList()
          ),
        ),
      ),
    );
  }
}
