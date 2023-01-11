import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/Provider/Report.dart';
import 'package:patient_app/Provider/doctorProfileProvider.dart';
import 'package:patient_app/UI/Profile.dart';
import 'package:patient_app/UI/spalsh_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:patient_app/Provider/Theme.dart';
import 'package:patient_app/UI/appointments.dart';

import 'Module/AppBar.dart';
import 'Provider/languageProvider.dart';
import 'UI/physicaians.dart';
import 'UI/report_page.dart';
import 'firebase_options.dart';

String language = 'EN';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  language = prefs.getString('language').toString();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(prefs.getBool('isDarkTheme') == null
              ? false
              : prefs.getBool('isDarkTheme')!)),
      ChangeNotifierProvider<Language>(create: (_) => Language()),
      ChangeNotifierProvider<ReportProvider>(create: (_) => ReportProvider()),
      ChangeNotifierProvider<DoctorDetailsProvider>(
          create: (_) => DoctorDetailsProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Patient App',
        theme: themeNotifier.getTheme,
        darkTheme: themeNotifier.darkTheme,
        home: const ApplashScreen());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  var title;

  final List<Widget> _widgetOptions = [
    FirstPageInReport(),
    Physicainas(),
    const Appointments(),
    const Profile()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String checkTitle(BuildContext context) {
    var str;
    setState(() {
      if (_selectedIndex == 0) {
        str = Provider.of<Language>(context, listen: false).tMyReports();
      } else if (_selectedIndex == 1) {
        str = Provider.of<Language>(context, listen: false).tPhysicainas();
      } else if (_selectedIndex == 2) {
        str = Provider.of<Language>(context, listen: false).tMyAppointments();
      } else if (_selectedIndex == 3) {
        str = Provider.of<Language>(context, listen: false).tMyProfile();
      }
    });
    return str;
  }

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<Language>(context, listen: true);
    return Scaffold(
      appBar: MainAppBar(
        title: checkTitle(context),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: lang.tReports(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_search_rounded),
            label: lang.tPhysicainas(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month_sharp),
            label: lang.tAppointments(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: lang.tProfile(),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        iconSize: 20,
        selectedFontSize: 15,
        unselectedFontSize: 13,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
