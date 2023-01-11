import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_app/Provider/languageProvider.dart';
import 'package:patient_app/UI/editProfile.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:patient_app/Provider/Theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../Module/AppBar.dart';
import 'changePassword.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List<String> languages = ['AR', 'EN'];
   String _selectedLanguage='';
  String value = '';

  @override
  void initState() {
    setState(() {
      _selectedLanguage = //context.read<Language>().getLanguage();
      Provider.of<Language>(context, listen: false).getLanguage();
      _selectedLanguage=_selectedLanguage.isNotEmpty
          ?_selectedLanguage:'EN';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<Language>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.tSettings()),
        centerTitle: true,
      ),
      body: (SettingsList(
        sections: [
          SettingsSection(
            title: Text(lang.tCommon()),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: Text(lang.tLanguage()),
                trailing: DropdownButton(
                  hint: Text(lang.tLanguage()),
                  value: _selectedLanguage.isNotEmpty ?_selectedLanguage:'EN' ,
                  onChanged: (newValue) async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString('language', newValue.toString());
                    setState(() {
                      _selectedLanguage = newValue.toString();
                      Provider.of<Language>(context, listen: false)
                          .setLanguage(newValue.toString());
                    });
                  },
                  items: languages.map((lang) {
                    return DropdownMenuItem(
                      child: Text(lang),
                      value: lang ,
                    );
                  }).toList(),
                ),
              ),
              SettingsTile.navigation(
                  onPressed: (_) {
                    setState(() {
                      if (context.read<ThemeNotifier>().getTheme ==
                          context.read<ThemeNotifier>().darkTheme) {
                        context.read<ThemeNotifier>().setTheme('light');
                      } else {
                        context.read<ThemeNotifier>().setTheme('dark');
                      }
                    });
                  },
                  leading: context.read<ThemeNotifier>().getThemeIcon,
                  title: context.read<ThemeNotifier>().getTheme ==
                          context.read<ThemeNotifier>().lightTheme
                      ? Text(lang.tLight())
                      : Text(lang.tDark())),
              SettingsTile.switchTile(
                title: Text(lang.tNotifications()),
                leading: Icon(context.read<ThemeNotifier>().valueOfNotification
                    ? Icons.notifications_on
                    : Icons.notifications_off),
                onToggle: (value) {
                  setState(() {
                    context.read<ThemeNotifier>().valueOfNotification = value;
                  });
                },
                initialValue: context.read<ThemeNotifier>().valueOfNotification,
              ),
              SettingsTile.navigation(
                title: Text(lang.tEditProfile()),
                leading: const Icon(Icons.edit_outlined),
                onPressed: ((context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()));
                }),
              ),
              SettingsTile.navigation(
                title: Text(lang.tChangePassword()),
                leading: const Icon(Icons.change_circle),
                onPressed: ((context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePassword()));
                }),
              ),
              SettingsTile.navigation(
                title: Text(lang.tLogout()),
                leading: const Icon(Icons.logout),
                onPressed: ((context) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(lang.tAreYouSureYouWantLogOut()),
                      actions: [
                        TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(ctx);
                            Navigator.pop(context);
                          },
                          child: Text(lang.tYes()),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: Text(lang.tNo()),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
