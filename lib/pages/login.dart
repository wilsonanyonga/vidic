import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vidic/bloc/vidic_admin_bloc.dart';
import 'package:vidic/utils/auth.dart';
import 'package:vidic/utils/dio_client.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({super.key});

  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    if (kDebugMode) {
      print('we are trying lod');
    }
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      if (kDebugMode) {
        print('we are trying');
      }
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
    return BlocProvider(
      create: (context) => VidicAdminBloc(
        RepositoryProvider.of<DioClient>(context),
      )..add(VidicInitialEvent()),
      child: Scaffold(
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
                        child: BlocConsumer<VidicAdminBloc, VidicAdminState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              context.goNamed("home");
                            }
                            if (state is LoginError) {
                              AwesomeDialog(
                                width: 600,
                                context: context,
                                animType: AnimType.leftSlide,
                                headerAnimationLoop: false,
                                dialogType: DialogType.error,
                                showCloseIcon: true,
                                title: 'Error Loging In',
                                desc: state.message,
                                // btnOkOnPress: () {
                                //   debugPrint('OnClcik');
                                // },
                                // btnOkIcon: Icons.check_circle,
                                onDismissCallback: (type) {
                                  debugPrint(
                                      'Dialog Dissmiss from callback $type');
                                },
                              ).show();
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return const ElevatedButton(
                                onPressed: null,
                                child: Row(
                                  children: [
                                    Text('Login'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            if (state is LoginState) {
                              return ElevatedButton(
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  if (_formKey.currentState!.validate()) {
                                    // Process data. millicent.odhiambo@vidic.co.ke
                                    // signInWithEmailAndPassword();
                                    if (kDebugMode) {
                                      print('sending');
                                    }
                                    BlocProvider.of<VidicAdminBloc>(context)
                                        .add(
                                      VidicLoginEvent(
                                        email: _controllerEmail.text,
                                        password: _controllerPassword.text,
                                      ),
                                    );
                                  }
                                },
                                child: const Row(
                                  children: [
                                    Text('Login'),
                                  ],
                                ),
                              );
                            }
                            return const Text('Error has Occured');
                          },
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
