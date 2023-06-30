import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constantes/errors_firebase.dart';
import '../../routes/route.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _kFormReset = GlobalKey<FormState>();

  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String _email = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title : GestureDetector(
            onTap: () async {
              await Navigator.pushNamed(context, kAuthScreen);
            },
            child :const Text("Page Email"),
          ),
          titleSpacing: 0.0,
          elevation: 0,
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            // centre les elements et pousse le contenu quand on ecrit avec le clavier
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              children: [
                Text(
                  'mot de passe perdu :'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Form(
                  key: _kFormReset,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Entrez votre adresse mail de récupération :',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      TextFormField(
                        onChanged: (value) => setState(() => _email = value),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                          hintText: 'Exemple@hotmail.com',
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
                            : () async {
                          if (EmailValidator.validate(_email)) {
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: _email)
                                  .then((value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Mail de récupération envoyé !'),
                                  ),
                                );
                                Navigator.pushNamed(context, kAuthScreen);
                              });
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  errors[e.code]!,
                                  style: const TextStyle(
                                      color: Colors.white),
                                ),
                              ));
                            }
                        }
                        },
                        child: Text(
                          'reset le mot de passe'.toUpperCase(),
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
