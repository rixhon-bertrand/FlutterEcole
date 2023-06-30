import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClientInformation extends StatelessWidget {
  final String tel;
  ClientInformation(this.tel, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Clients")
                .where("telephone", isEqualTo: tel)
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
                height: 180,
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
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Nom: ${clientSnapshot[index]["nom"]} ${clientSnapshot[index]["prenom"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Téléphone: ${clientSnapshot[index]["telephone"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Email: ${clientSnapshot[index]["mail"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Manga: ${clientSnapshot[index]["manga"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection("reservation")
                                      .where("idclient", isEqualTo: tel)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    final reservationSnapshot = snapshot.data?.docs;
                                    if (reservationSnapshot!.isEmpty) {
                                      return const  Text("Pas de réservations...");
                                    }

                                    // Calculer la somme des paniers moyens de toutes les réservations
                                    double sum = 0;
                                    double sumCouvert = 0;
                                    for (final reservation in reservationSnapshot) {
                                      sum += double.parse(reservation["total_addition"]);
                                      sumCouvert +=double.parse(reservation["nombre_couverts"]);
                                    }

                                    // Calculer le panier moyen total en divisant la somme par le nombre de réservations
                                    final double average = sum / sumCouvert;
                                    String result = average.toStringAsFixed(2);

                                    return Text("Panier moyen total: $result €");
                                  }
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              );
            }),
      ],
    );
  }
}
