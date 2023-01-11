import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patient_app/Provider/languageProvider.dart';
import 'package:provider/provider.dart';

import '../Module/appointmrntsDetailsModule.dart';
import '../Module/cardviewlist.dart';
import '../Module/doctor_profileModule.dart';

class DoctorDetailsProvider with ChangeNotifier {
  List<DoctorProfileModule> doctorList = [];
  List<appointmentsDetails> appointmentsList = [];
  final _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  /*Future<void> addDataDoctor() async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc("{appointmentsList[1].doctorId}")
        .set({
            'doctorName': appointmentsList[1].doctorName,
            'date': appointmentsList[1].date,
            
        });
  }*/

  Future<int> addAppointmentPaitent(String docName, String pickedDate,
      String pickedTime, int rating, int doctroId) async {
    if (!await limitAppointmentCreation(
        DateTime.parse(pickedDate), pickedTime)) {
      return 0;
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection("appoitment")
          .doc()
          .set({
        'doctorname': docName,
        'date': pickedDate,
        'time': pickedTime,
        'rating': rating,
        'DoctorId': doctroId,
        'isRated': false,
      });
      notifyListeners();
      return 1;
    }
  }

  Future<bool> limitAppointmentCreation(DateTime date, String time) async {
    final userAppointments = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("appoitment")
        .get();

    for (var appointment in userAppointments.docs) {
      var dateTime = DateTime.parse(appointment.data()["date"]);
      DateTime date1 = DateTime.now();
      DateTime date2 = DateTime(dateTime.year, dateTime.month, dateTime.day,
          dateTime.hour, dateTime.minute, dateTime.second);

      Duration difference = date1.difference(date2);

      if (difference.inDays == 0) {
        if (difference.inMinutes < 30) {
          return false;
        }
      }
    }
    return true;
  }

  Future<void> fetchData() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("appoitment")
        .get();
    appointmentsList = [];
    for (var item in data.docs) {
      appointmentsList.add(appointmentsDetails(
        doctorName: item.data()['doctorname'],
        date: item.data()['date'],
        time: item.data()['time'],
        rating: item.data()['rating'],
        doctorId: item.data()['doctorId'],
        isRated: item.data()['isRated'],
        id: item.id,
      ));
    }
    notifyListeners();
  }

  /*Future<void> addData() async {
    int x = 0;
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc("${doctorsListCard[x].doctorId}")
        .set({
      'doctorname': doctorsListCard[x].doctorName,
      'rating': doctorsListCard[x].rating,
      'phoneNumber': doctorsListCard[x].doctorPhoneNumber,
      'specialty': doctorsListCard[x].doctorSpeciality,
      'imageUrl': doctorsListCard[x].imageUrl,
    });
  }*/

  Future<void> getDataBaseDoctorsData() async {
    final data = await FirebaseFirestore.instance.collection('doctors').get();
    doctorList = [];
    for (var item in data.docs) {
      doctorList.add(DoctorProfileModule(
          doctorId: item.data()['DoctorId'],
          rating: item.data()['rating'],
          experience: item.data()['experience'],
          doctorName: item.data()["doctorname"],
          phoneNumber: item.data()["phoneNumber"],
          speciality: item.data()["specialty"],
          imageUrl: item.data()["imageUrl"]));
    }
    notifyListeners();
  }

  Future<void> RefreshScreen() async {
    fetchData();
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("appoitment")
        .doc(id)
        .delete();
    notifyListeners();
  }

  Icon iconOfSpeciality(String sp) {
    if (sp == 'Pediatrics') {
      return const Icon(Icons.child_care);
    } else if (sp == 'Anesthesiology') {
      return const Icon(Icons.monitor_heart_rounded);
    } else if (sp == 'Diagnostic radiology') {
      return const Icon(Icons.h_mobiledata_sharp);
    } else if (sp == 'Cardiolgoy') {
      return const Icon(Icons.heart_broken);
    } else if (sp == 'Psychiatry') {
      return const Icon(Icons.heart_broken);
    }
    return const Icon(Icons.h_mobiledata_sharp);
  }

  String period(TimeOfDay time) {
    int hour = time.hour, minute = time.minute;
    String period = 'AM';
    if (time.hour >= 12) {
      hour = time.hour - 12;
      period = 'PM';
    }
    return period;
  }

  @override
  void dispose() {}
}
