import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies_app/routes/app_routes.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String getIntialRoute() => AppRoutes.signIn;

  // Route getRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case AppRoutes.signIn:
  //       return buildRoute(LoginWidget(), settings: settings);
  //     default:
  //       return null;
  //   }
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomaPage(),
      // home: SignUp(),
      theme: ThemeData.dark(),
      // initialRoute: getIntialRoute(),
      // onGenerateRoute: (route) => getRoute(route),
      routes:{
        '/signIn': (context)=> LoginWidget(),
        '/signUp': (context)=> SignUp(),
        // '/home':(context) => 
      }
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWidget(),
    );
  }
}
