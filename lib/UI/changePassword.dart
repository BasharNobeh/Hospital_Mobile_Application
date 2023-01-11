import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../Module/AppBar.dart';
import '../Provider/languageProvider.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<Language>(context, listen: true);

    var newPassController = TextEditingController();
    var confirmNewPassController = TextEditingController();
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.tChangePassword()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 30, top: 50, right: 30, bottom: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        lang.tChangePassword(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center, // TextStyle
                      ), // Text
                      const SizedBox(height: 50),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.tNewPassword(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 60,
                            child: TextField(
                              controller: newPassController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(top: 14),
                                prefixIcon: const Icon(Icons.password),
                                hintText: lang.tEnterNewPassword(),
                                hintStyle: const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), //New Password
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.tConfirmNewPassword(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 60,
                            child: TextField(
                              controller: confirmNewPassController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(top: 14),
                                prefixIcon: const Icon(Icons.password),
                                hintText: lang.tConfirmNewPassword(),
                                hintStyle: const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), //Confirm New Password
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (newPassController.text.trim() ==
                                    confirmNewPassController.text.trim() &&
                                newPassController.text.isNotEmpty) {
                              try {
                                await user
                                    .updatePassword(
                                        newPassController.text.trim())
                                    .then((value) {
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: lang.tPasswordChanged(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                });
                              } catch (e) {
                                Fluttertoast.showToast(
                                    msg: "$e",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: lang.tWrongpasswordentry(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: Text(
                            lang.tSubmit(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
