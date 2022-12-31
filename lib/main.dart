import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies_app/routes/app_routes.dart';
import 'package:movies_app/services/auth_service.dart';
import 'package:movies_app/services/user.dart';
import 'package:movies_app/widgets/home.dart';
import 'package:movies_app/widgets/login_page.dart';
import 'package:movies_app/widgets/signup_page.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthService().handleAuthState(),
        theme: ThemeData.dark(),
        routes: {
          '/signIn': (context) => LoginWidget(),
          '/signUp': (context) => SignUp(),
          '/home': (context) => HomePage(),
        });
  }
}
