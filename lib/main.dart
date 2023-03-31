import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:myflutterproject/provider/user/greatEvents.dart';
import 'package:myflutterproject/screens/eventDetailScreen.dart';
import 'package:myflutterproject/screens/news_list_screen.dart';
import 'package:myflutterproject/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import 'screens/police_Screen.dart';
import './screens/authScreen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '/screens/profile_screens/profile_page.dart';
import 'screens/addEvent.dart';

void main() async {

WidgetsBinding widgetsBinding =WidgetsFlutterBinding.ensureInitialized();
FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
FirebaseApp app= await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
print("Initialized App $app");
runApp(const MyApp());
FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider.value(
      value: GreatEvents(),
      child: 
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login Screen',
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
          return NewsListScreen();
          else
          return AuthScreen();
        }, 
      // home:AuthScreen(),
      ),
      // initialRoute: '/',
      routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          AddEventScreen.routeName: (ctx) => const AddEventScreen(),
          EventDetailScreen.routeName: (ctx) => EventDetailScreen(),
          PoliceScreen.routeName: (ctx) => PoliceScreen(),
          NewsListScreen.routeName: (ctx) => NewsListScreen(),
          ProfilePage.routeName: (ctx) => ProfilePage(),
        },
    )
    );
  }
}
