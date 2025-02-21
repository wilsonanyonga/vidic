import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vidic/bloc/vidic_admin_bloc.dart';
import 'package:vidic/utils/auth.dart';
import 'package:vidic/utils/dio_client.dart';

class MenuBarWidget extends StatefulWidget {
  const MenuBarWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<MenuBarWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MenuBarWidget> {
  final myBox = Hive.box('myBox');
  Future<void> signOut() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // //Return String
    // String? stringValue = prefs.getString('email');
    if (kDebugMode) {
      // print(stringValue);
    }

    await Auth().signOut();
  }

  String name = '';
  @override
  // ignore: must_call_super
  initState() {
    //
    // await Future.delayed(const Duration(seconds: 4));
    if (kDebugMode) {
      print("waiting");
    }
    userName();
    if (kDebugMode) {
      print("initState Called");
    }
  }

  // millicent.odhiambo@vidic.co.ke
  void userName() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    if (kDebugMode) {
      print("waiting2");
    }
    // String? stringValue = prefs.getString('user_name');

    String? stringValue = myBox.get('user_name');

    if (stringValue == null) {
      await Future.delayed(const Duration(seconds: 1));
      if (kDebugMode) {
        print("waiting again");
      }
      setState(() {
        name = stringValue!;
      });
    }
    setState(() {
      if (kDebugMode) {
        print("waiting3");
      }
      name = stringValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VidicAdminBloc(
        RepositoryProvider.of<DioClient>(context),
      )..add(UserGetEvent()),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: () {
                  myBox.put('logedIn', false);
                  context.goNamed("login");
                  signOut();
                },
                child: Stack(
                  children: [
                    // const Positioned(
                    //   right: 135,
                    //   top: 5,
                    //   child: CircleAvatar(
                    //     radius: 15,
                    //     foregroundImage: AssetImage('assets/icons/vidic.png'),
                    //   ),
                    // ),
                    Positioned(
                      right: 10,
                      top: 1,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Admin',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            tooltip: 'Log Out',
                            onPressed: () {
                              myBox.put('logedIn', false);
                              context.goNamed("login");
                              signOut();
                            },
                            icon: const Icon(Icons.logout),
                          )
                        ],
                      ),
                    ),
                    // const Positioned(
                    //   right: 101,
                    //   top: 25,
                    //   child: Text(
                    //     'Admin',
                    //     style: TextStyle(fontSize: 10),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
