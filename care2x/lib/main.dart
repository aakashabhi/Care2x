import 'package:care2x/login/login_screen.dart';
import 'package:care2x/restart_controller.dart';
import 'package:care2x/screens/welcome_page.dart';
import 'package:care2x/vendor/ui/presentation/vendor_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'login/signup.dart';
import 'session_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new HotRestartController(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SessionRepository(),
      child: MaterialApp(
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
              primaryColor: Colors.black),
          home: VendorHomePage(
            vendorId: 'jXuhdZJgGUq2tMxKFXnl',
          ),
          builder: EasyLoading.init()),
    );
  }
}
