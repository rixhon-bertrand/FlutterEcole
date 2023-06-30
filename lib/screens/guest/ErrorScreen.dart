import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(body: Center(
          child: Row(
            children: const [
              Icon(Icons.error, color: Colors.red),
              Text("Erreur réseau"),
            ],
          ),
        )
        ));
  }
}
