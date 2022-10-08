import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vidic/utils/auth.dart';

class Login extends StatelessWidget {
  Login({super.key});

  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      // email: _controllerEmail.text,
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      // email: _controllerEmail.text,
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var mediaQsize, mediaQheight, mediaQwidth;
  @override
  Widget build(BuildContext context) {
    mediaQsize = MediaQuery.of(context).size;
    mediaQheight = mediaQsize.height;
    mediaQwidth = mediaQsize.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
                foregroundImage: AssetImage('assets/icons/vidic.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "VIDIC Admin Portal",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.contains('@') == false) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _controllerPassword,
                      obscureText: true,
                      obscuringCharacter: '•',
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
