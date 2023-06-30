import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:resto_mag/routes/route.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:resto_mag/screens/guest/ErrorScreen.dart';
import 'firebase_options.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: MaterialApp(
                theme: ThemeData(
                    canvasColor: Colors.transparent,
                    primaryColor: Colors.orange),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate
                ],
                supportedLocales: const [Locale('en'), Locale('fr')],
                initialRoute: FirebaseAuth.instance.currentUser == null
                    ? kAuthScreen // kAuthScreen
                    : kHomeScreen,
                // kHomeScreen
                routes: router,
              ),
            );
          } else {
            return const ErrorScreen();
          }
        });
  }
}
