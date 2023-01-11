import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Module/AppBar.dart';
import '../Provider/languageProvider.dart';
import '../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final genderList = ["Male", "Female"];
  String genderValue = "Male";

  File? image;
  String imageUrl = "";

  Future takePhoto(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemp = File(image.path);
    Reference ref = FirebaseStorage.instance.ref().child(imageTemp.path);
    await ref.putFile(File(image.path));
    ref.getDownloadURL().then((value) {
      setState(() {
        imageUrl = value;
      });
    });
    setState(() {
      this.image = imageTemp;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<Language>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.tSignUp()),
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
                        lang.tSignUp(),
                        style:const TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold), // TextStyle
                      ), // Text
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: image != null
                                    ? Image.file(image!).image
                                    : Image.network(
                                            "https://cdn-icons-png.flaticon.com/512/149/149071.png")
                                        .image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt),
                                color: Colors.black,
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => buttomSheet()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            lang.tFirstName(),
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 60,
                            child: TextField(
                              controller: _firstNameController,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                contentPadding:const EdgeInsets.only(top: 14),
                                prefixIcon:const Icon(Icons.person),
                                hintText: lang.tEnterFirstName(),
                                hintStyle:const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), //First Name
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            lang.tLastName(),
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 60,
                            child: TextField(
                              controller: _lastNameController,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                contentPadding:const EdgeInsets.only(top: 14),
                                prefixIcon:const Icon(Icons.person),
                                hintText: lang.tEnterLastName(),
                                hintStyle:const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), //Last Name
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            lang.tGender(),
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.only(left: 50),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 60,
                            child: DropdownButton(
                              value: genderValue,
                              icon: const Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.black,
                              ),
                              items: genderList
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (newV) {
                                setState(() {
                                  genderValue = newV!;
                                });
                              },
                            ),
                          ),
                        ],
                      ), //Gender
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            lang.tPhoneNumber(),
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 60,
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                contentPadding:const EdgeInsets.only(top: 14),
                                prefixIcon:const Icon(Icons.phone),
                                hintText:  lang.tEnterPhoneNumber(),
                                hintStyle:const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), //Phone Number
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            lang.tDateofBirth(),
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 60,
                            child: TextField(
                              controller: _dateController,
                              keyboardType: TextInputType.datetime,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                contentPadding:const EdgeInsets.only(top: 14),
                                prefixIcon:const Icon(Icons.date_range),
                                hintText:  lang.tEnterDateofBirth(),
                                hintStyle:const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), //Date of Birth
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            lang.tEmail(),
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 60,
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                contentPadding:const EdgeInsets.only(top: 14),
                                prefixIcon:const Icon(Icons.alternate_email),
                                hintText: lang.tEnterEmail(),
                                hintStyle:const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), //Email
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            lang.tPassword(),
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 60,
                            child: TextField(
                              controller: _passController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                contentPadding:const EdgeInsets.only(top: 14),
                                prefixIcon:const Icon(Icons.password),
                                hintText: lang.tEnterPassword(),
                                hintStyle:const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), //Password
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                           lang.tConfirmPassword(),
                            style:const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 60,
                            child: TextField(
                              controller: _confirmPassController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                contentPadding:const EdgeInsets.only(top: 14),
                                prefixIcon:const Icon(Icons.password),
                                hintText: lang.tReEnterPassword(),
                                hintStyle:const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ), //Confirm Password
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_firstNameController.text.isEmpty ||
                                _lastNameController.text.isEmpty ||
                                _phoneController.text.isEmpty ||
                                _dateController.text.isEmpty ||
                                _emailController.text.isEmpty ||
                                _passController.text.isEmpty ||
                                _confirmPassController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: lang.tPleaseenterallfields(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              if (_passController.text ==
                                  _confirmPassController.text) {
                                try {
                                  //Create user
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passController.text.trim(),
                                  )
                                      .then((value) {
                                    // Add user Details
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(value.user?.uid)
                                        .set({
                                      'first name':
                                          _firstNameController.text.trim(),
                                      'last name':
                                          _lastNameController.text.trim(),
                                      'gender': genderValue,
                                      'phone number':
                                          _phoneController.text.trim(),
                                      'date of birth':
                                          _dateController.text.trim(),
                                      'image url': imageUrl == ""
                                          ? "https://cdn-icons-png.flaticon.com/512/149/149071.png"
                                          : imageUrl
                                    });
                                    Navigator.pop(context);
                                  });
                                } catch (error) {
                                  Fluttertoast.showToast(
                                      msg: "$error",
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
                            }
                          },
                          child:  Text(
                            lang.tSignUp(),
                            style:const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ), //Sign Up Button
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

  Widget buttomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text("Choose Profile Picture", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera"),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
              ),
              const SizedBox(width: 50),
              TextButton.icon(
                icon: const Icon(Icons.image),
                label: const Text("Gallery"),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
