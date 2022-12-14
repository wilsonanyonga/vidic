import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vidic/firebase_options.dart';
import 'package:vidic/pages/complaints.dart';
import 'package:vidic/pages/home.dart';
import 'package:vidic/pages/invoice.dart';
import 'package:vidic/pages/letters.dart';
import 'package:vidic/pages/login.dart';
import 'package:vidic/pages/occupancy.dart';
import 'package:vidic/pages/statement.dart';
import 'package:vidic/utils/auth.dart';
import 'package:vidic/utils/dio_client.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => DioClient(),
          ),
        ],
        child: StreamBuilder<User?>(
            stream: Auth().authStateChanges,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MaterialApp.router(
                  routeInformationProvider: _router.routeInformationProvider,
                  routeInformationParser: _router.routeInformationParser,
                  routerDelegate: _router.routerDelegate,

                  title: 'VIDIC Admin',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      // This is the theme of your application.
                      //
                      // Try running your application with "flutter run". You'll see the
                      // application has a blue toolbar. Then, without quitting the app, try
                      // changing the primarySwatch below to Colors.green and then invoke
                      // "hot reload" (press "r" in the console where you ran "flutter run",
                      // or simply save your changes to "hot reload" in a Flutter IDE).
                      // Notice that the counter didn't reset back to zero; the application
                      // is not restarted.
                      primarySwatch: Colors.blue,
                      scaffoldBackgroundColor: Colors.grey[350]),
                  // home: MyHomePage(title: 'Flutter Demo Home Page'),
                );
              } else {
                return MaterialApp.router(
                  routeInformationProvider:
                      _routerLogin.routeInformationProvider,
                  routeInformationParser: _routerLogin.routeInformationParser,
                  routerDelegate: _routerLogin.routerDelegate,

                  title: 'VIDIC Admin',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      // This is the theme of your application.
                      //
                      // Try running your application with "flutter run". You'll see the
                      // application has a blue toolbar. Then, without quitting the app, try
                      // changing the primarySwatch below to Colors.green and then invoke
                      // "hot reload" (press "r" in the console where you ran "flutter run",
                      // or simply save your changes to "hot reload" in a Flutter IDE).
                      // Notice that the counter didn't reset back to zero; the application
                      // is not restarted.
                      primarySwatch: Colors.blue,
                      scaffoldBackgroundColor: Colors.grey[350]),
                  // home: MyHomePage(title: 'Flutter Demo Home Page'),
                );
              }
            }),
      );

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        // redirect: (state) {
        //   if (await Auth().authStateChanges.isEmpty) {

        //   } else {

        //   }
        //   // return StreamBuilder(
        //       // stream: Auth().authStateChanges,
        //       // builder: (context, snapshot) {
        //       //   if (snapshot.hasData) {
        //       //     return MyHomePage(title: 'Flutter Demo Home Page');
        //       //   } else {
        //       //     return Login();
        //       //   }
        //       // },
        //       // );
        //   // return '/login';
        // },

        builder: (BuildContext context, GoRouterState state) =>
            MyHomePage(title: 'VIDIC Admin Home Page'),
        // // builder: (BuildContext context, GoRouterState state) => Login(),

        // redirect: (state) => '/dala',

        routes: [
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) => Login(),
          ),
          GoRoute(
            path: 'nyumba',
            redirect: (BuildContext context, GoRouterState state) => '/',
          ),
          GoRoute(
            path: 'dala',
            builder: (BuildContext context, GoRouterState state) =>
                MyHomePage(title: 'VIDIC Admin Home Page'),
          ),
          GoRoute(
            path: 'statement',
            builder: (BuildContext context, GoRouterState state) =>
                StatementScreen(),
          ),
          GoRoute(
            path: 'invoice',
            builder: (BuildContext context, GoRouterState state) =>
                InvoiceScreen(),
          ),
          GoRoute(
            path: 'letters',
            builder: (BuildContext context, GoRouterState state) =>
                LettersScreen(),
          ),
          GoRoute(
            path: 'occupancy',
            builder: (BuildContext context, GoRouterState state) =>
                OccupancyScreen(),
          ),
          GoRoute(
            path: 'complaints',
            builder: (BuildContext context, GoRouterState state) =>
                ComplaintsScreen(),
          ),
        ],
      ),
    ],
  );

  final GoRouter _routerLogin = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',

        builder: (BuildContext context, GoRouterState state) => Login(),

        // redirect: (state) => '/dala',
      ),
    ],
  );
}
