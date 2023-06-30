import 'package:flutter/material.dart';
import 'package:resto_mag/routes/route.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constantes/errors_firebase.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState> _kFormMdp = GlobalKey<FormState>();

  bool _isHide = true;
  String _password = "";

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;

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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, kAuthScreen);
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
                  'password'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Form(
                  key: _kFormMdp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Entrez votre mot de passe :',
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
                        onChanged: (value) => setState(() => _password = value),
                        obscureText: _isHide,
                        validator: (value) => value!.length < 6
                            ? "Le mote de passe est de minimum 6 characters "
                            : null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                            icon: _isHide
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isHide = !_isHide;
                              });
                            },
                          ),
                          hintText: 'Mot de passe',
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
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, kResetPassword);
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: 'Mot de passe oublié ?  Cliquez ici !',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: _password.length < 6
                            ? null
                            : () async {
                                if (_kFormMdp.currentState!.validate()) {
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: email,
                                      password: _password,
                                    )
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Bonjour ${FirebaseAuth.instance.currentUser!.email}'),
                                        ),
                                      );
                                      Navigator.pushNamed(context, kHomeScreen);
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
                          'Login'.toUpperCase(),
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
