import 'package:flutter/material.dart';
import 'screens/newscreen.dart';
import './screens/authScreen.dart';
// import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
FirebaseApp app= await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
print("Initialized App $app");
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Login Screen Example',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        backgroundColor: Colors.pink,
        primaryColorLight: Colors.white70,
        primaryColorDark: Colors.deepPurple,
        cardColor: Colors.orange,
        errorColor: Colors.red,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20),
          ),
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(secondary: Colors.deepPurple)
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if(userSnapshot.hasData)
          return NewScreen();
          else
          return AuthScreen();
        }, 
      // home:AuthScreen(),
      )
    );
  }
}
