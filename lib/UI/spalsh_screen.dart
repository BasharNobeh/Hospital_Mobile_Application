import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:patient_app/UI/loginScreen.dart';
import 'package:patient_app/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Provider/languageProvider.dart';

class ApplashScreen extends StatelessWidget {
  const ApplashScreen({super.key});


  SetLanguage(BuildContext context) async {
    var language;
    SharedPreferences pref =
        await SharedPreferences.getInstance();
    language=pref.get('language') ?? 'AR';
   
    pref.setString('language', language);
    Provider.of<Language>(context, listen: false)
    .setLanguage(language);
    print(language +" laaan");

  }




  @override
  Widget build(BuildContext context) {
    SetLanguage(context);
    return EasySplashScreen(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      logoWidth: MediaQuery.of(context).size.width/3.5,
      loaderColor: const Color.fromARGB(255, 40, 148, 244),
      logo: Image.asset(
        "images/galaxylogo.png",
      ),
      showLoader: true,
      loadingText: const Text(
        'Welcome...',
        style: TextStyle(color: Color.fromARGB(255, 40, 148, 244)),
      ),
      navigator: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MyHomePage();
          } else {
            return LoginScreen();
          }
        },
      ),
      durationInSeconds: 3,
    );
  }
}
