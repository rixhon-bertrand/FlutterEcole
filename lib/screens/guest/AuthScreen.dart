import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:resto_mag/routes/route.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _kFormMail = GlobalKey<FormState>();

  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String _email = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            // centre les elements et pousse le contenu quand on ecrit avec le clavier
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Bienvenue chez\n'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                    children: [
                      TextSpan(
                          text: 'RestoMag\n',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          )),
                      const TextSpan(
                          text: 'Bon appétit !',
                          style: TextStyle(
                            fontSize: 15.0,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Form(
                  key: _kFormMail,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Entrez votre mail :',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      TextFormField(
                        autofocus: true,
                        onChanged: (value) => setState(() => _email = value),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                          hintText: ' Exemple@hotmail.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: !emailRegex.hasMatch(
                                _email) //tant que le regex est pas bon alors null sinon si clique
                            ? null
                            : () {
                                if (EmailValidator.validate(_email)) {
                                  Navigator.pushNamed(context, kPasswordScreen, arguments: _email,
                                  );
                                }
                              },
                        child: Text(
                          'Continue'.toUpperCase(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
