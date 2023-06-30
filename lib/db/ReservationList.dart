import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReservationList extends StatelessWidget {
  final String tel;
  ReservationList(this.tel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("reservation")
                .where("idclient", isEqualTo: tel)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final clientSnapshot = snapshot.data?.docs;
              if (clientSnapshot!.isEmpty) {
                return const SizedBox(height: 150,child: Center(child: Text("Pas de réservations...",style: TextStyle(
                  color: Colors.white,fontSize: 20,
                ))),);
              }
              return SizedBox(
                height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: clientSnapshot.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.black, width: 1),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 5,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Date: ${clientSnapshot[index]["date"]}"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Nombre de couvert: ${clientSnapshot[index]["nombre_couverts"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Total addition: ${clientSnapshot[index]["total_addition"]}"),
                            ),
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
