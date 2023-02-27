/* 
 @authors:
 Abdul Wahhab Alfaghiri Al Anzi   01524445
 Nouzad Mohammad                  00820679
*/
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timestamp/home_screen.dart';
import 'package:timestamp/loginscreen.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      /*  options: const FirebaseOptions(
          apiKey: "AIzaSyDpUGwyhLNxkCMYdppYgxdyPYaf8801FJM",
          appId: "1:701373106747:web:8612386ef5e96b83d3aa1e",
          messagingSenderId: "701373106747",
          projectId: "trecord-483e0") */
      );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          SfGlobalLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('de'),
          // ... other locales the app supports
        ],
        locale: const Locale('de'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.black.withOpacity(0.8),
          canvasColor: Colors.transparent,
        ),
        home: Container(child: const HomeScreen()),
      );
}
