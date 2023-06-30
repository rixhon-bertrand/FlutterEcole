import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resto_mag/routes/route.dart';

class ClientsList extends StatefulWidget {
  const ClientsList({Key? key}) : super(key: key);

  @override
  _ClientsListState createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: searchTerm,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(
              Icons.person,
            ),
            hintText: 'Rechercher un client',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              searchTerm = value;
            });
          },
        ),
        const SizedBox(height:40),

        StreamBuilder<QuerySnapshot>(
            stream: searchTerm.isEmpty
                ? FirebaseFirestore.instance.collection("Clients").snapshots()
                : FirebaseFirestore.instance
                .collection("Clients")
                .where("nom", isGreaterThanOrEqualTo: searchTerm) // je selectionne tout les elements egal ou + grand
                .where("nom", isLessThan: '$searchTerm\uf8ff') // searchTerm + '\uf8ff' (dernier caractere unicode) retire les elements plus grand
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final clientSnapshot = snapshot.data?.docs;
              if (clientSnapshot!.isEmpty) {
                return const SizedBox(height: 300,child: Center(child: Text("Pas de clients...")),);
              }
              return SizedBox(
                height: 300,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: clientSnapshot.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 5,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                            leading: const Icon(Icons.recent_actors),
                            title: Text("Nom: ${clientSnapshot[index]["nom"]} ${clientSnapshot[index]["prenom"]}"),
                            subtitle: Text("Tel: ${clientSnapshot[index]["telephone"]}"),
                            onTap: () {
                              Navigator.pushNamed(context, kClientScreen,
                                  arguments: clientSnapshot[index]["telephone"]);
                            }),
                      );
                    }),
              );
            }),
        const SizedBox(height:40),
        Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, kAddClientScreen);
                },
                child: Text(
                  'Ajouter un client'.toUpperCase(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
