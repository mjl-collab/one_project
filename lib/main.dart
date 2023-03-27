import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one_project/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'providers/attendance_provider.dart';
import 'providers/login_provider.dart';
import 'screens/attendance_screen.dart';
import 'services/attendance.service.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  AttendanceService.configDio();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AttendanceProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

//Can change Globally here:
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //<FOR THE BREAKPOINTS IN EVERY DEVICES>//
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper(child: child!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(560, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Inter, Poppins',
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.white),
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(color: Colors.blueGrey),
      ),
      home: const LoginPage(),
    );
  }
}
