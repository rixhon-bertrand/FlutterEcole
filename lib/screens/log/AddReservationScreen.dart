import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:resto_mag/routes/route.dart';
import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class AddReservationScreen extends StatefulWidget {
  const AddReservationScreen({Key? key}) : super(key: key);

  @override
  State<AddReservationScreen> createState() => _AddReservationScreenState();
}

class _AddReservationScreenState extends State<AddReservationScreen> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  String _totalAddiction = "";
  String _nbCouverts = "";
  String _date = "";

  void _resetForm() {
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    final String _phone = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title : GestureDetector(
            onTap: () async {
              Navigator.pop(context);
            },
            child :const Text("Page Client"),
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: dateController,
                  //editing controller of this TextField
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.calendar_month,
                    ),
                    labelText: 'Date de la réservation',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                  readOnly: true,
                  // when true user cannot edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        locale: const Locale("fr", "FR"),
                        context: context,
                        initialDate: DateTime.now(),
                        //get today's date
                        firstDate: DateTime(2000),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);

                      setState(() {
                        dateController.text =
                            formattedDate; //set foratted date to TextField value.
                        _date = formattedDate;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Aucune date selectionnée')),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) =>
                      setState(() => _totalAddiction = value),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.euro,
                    ),
                    labelText: 'Total de l\'addition',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) => setState(() => _nbCouverts = value),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.people,
                    ),
                    labelText: 'Nombre de couverts',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final reservation = <String, String>{
                        "idclient": _phone,
                        "date": _date,
                        "total_addition": _totalAddiction,
                        "nombre_couverts": _nbCouverts
                      };
                      var collection = FirebaseFirestore.instance
                          .collection('reservation');
                      collection
                          .add(
                              reservation) // ADD génère l'id automatiquement.
                          .then((_) => print('Ajouté'))
                          .catchError(
                              (error) => print('Erreur d’ajout: $error'));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('reservation ajoutée.$_date')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.edit_calendar_rounded),
                        SizedBox(width: 5),
                        Text("Ajouter réservation",
                            style: Styles.buttonStyle),
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
