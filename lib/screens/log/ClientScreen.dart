import 'package:flutter/material.dart';
import 'package:resto_mag/db/ClientInformation.dart';
import 'package:resto_mag/db/ReservationList.dart';
import 'package:resto_mag/routes/route.dart';
import 'package:resto_mag/styles/styles.dart';

class ClientScreen extends StatelessWidget {
   ClientScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _kFormMdp = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final tel = ModalRoute.of(context)!.settings.arguments as String;

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
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClientInformation(tel), // fiche client
            const SizedBox(height:50),
            Form(
              key: _kFormMdp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        kAddReservationScreen,
                        arguments: tel,
                      );
                    },
                    child: Text(
                      'Ajouter une reservation'.toUpperCase(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height:50),
            ReservationList(tel)
          ],
        ),
      ),
    ));
  }
}
