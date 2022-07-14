import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:patient_register/Functions/changing_state.dart';
import 'package:patient_register/Functions/firebase_auth.dart';
import 'package:patient_register/Screens/home_page.dart';
import 'package:patient_register/Screens/login.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(create: ((context) => context.read<AuthenticationService>().authStateChanges), initialData: null),
        ChangeNotifierProvider(create: ((context) => ChangingState())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context){
//     final firebaseUser = context.watch<User?>();
//     if (firebaseUser != null) {
//       return const HomePage();
//     } else {
//       return const LoginScreen();
//     }
//   }
// }
