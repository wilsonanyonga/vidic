import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vidic/pages/complaints.dart';
import 'package:vidic/pages/home.dart';
import 'package:vidic/pages/invoice.dart';
import 'package:vidic/pages/letters.dart';
import 'package:vidic/pages/occupancy.dart';
import 'package:vidic/pages/statement.dart';
import 'package:vidic/utils/dio_client.dart';

void main() {
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
        child: MaterialApp.router(
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,

          title: 'Flutter Demo',
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
        ),
      );

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            MyHomePage(title: 'Flutter Demo Home Page'),
        routes: [
          GoRoute(
            path: 'nyumba',
            redirect: (state) => '/',
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
}
