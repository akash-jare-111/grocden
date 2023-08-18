import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocden/firebase_options.dart';
import 'package:grocden/pages/auth/locality_page.dart';
import 'package:grocden/pages/auth/login_page.dart';
import 'package:grocden/pages/auth/signup_page.dart';
import 'package:grocden/pages/cart_page.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: LocalitySearchPage(),
      routes: {
        '/':(context) => Root(),
        '/home':(context) => MyHomePage(),
        '/login':(context) => LoginPage(),
        '/signup':(context) => SignupPage(),
        '/locality':(context) => LocalitySearchPage(),
        '/cart':(context) => CartPage(),
        // 'orders':(context) => ,
        // Notifications
      },
    );
  }
}

class Root extends StatelessWidget{
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if(user!=null) return MyHomePage();
    else return LoginPage();
  }
}