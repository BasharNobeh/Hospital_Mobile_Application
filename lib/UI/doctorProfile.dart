import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:patient_app/Module/AppBar.dart';
import 'package:patient_app/Provider/doctorProfileProvider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../Provider/languageProvider.dart';

class DoctorProfile extends StatefulWidget {
  final int id;
  const DoctorProfile({required this.id});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool isLoading = true;
  final doctorNameController = TextEditingController();
  final doctorSpecailityController = TextEditingController();
  final doctorPhoneController = TextEditingController();
  int? doctorRating;
  int? doctorExperince;
  String? imageUrl;
  int? doctorId;
  bool isSelected = true;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  Future<void> fetchData() async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.id.toString())
        .get()
        .then((ds) => {
              doctorNameController.text = ds.data()!['doctorname'],
              doctorId = ds.data()!['DoctorId'],
              doctorRating = ds.data()!['rating'],
              doctorExperince = ds.data()!['experience'],
              doctorSpecailityController.text = ds.data()!['specialty'],
              doctorPhoneController.text = ds.data()!['phoneNumber'].toString(),
              setState(() {
                imageUrl = ds.data()!['imageUrl'];
              }),
              isLoading = false,
            });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<Language>(context, listen: true);

    Icon iconDoc = Provider.of<DoctorDetailsProvider>(context, listen: false)
        .iconOfSpeciality(doctorSpecailityController.text);
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: MainAppBar(
          title: lang.tDoctorProfile(),
        ),
        body: SingleChildScrollView(
          child: Material(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 100),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl!),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.7),
                          Colors.blue.withOpacity(0),
                          Colors.blue.withOpacity(0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          Container(
                            height: 80,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      lang.tExperience(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '$doctorExperince ${lang.tYears()}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      lang.tRating(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '$doctorRating / 5',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height / 1.75,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.medical_services),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                doctorSpecailityController.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text("Contact: " "Dr.${doctorNameController.text}",
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500)),
                          Text(
                            "Phone Number :${doctorPhoneController.text}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.6)),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Date :",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 33,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(160, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    textStyle: const TextStyle(fontSize: 20)),
                                onPressed: () async {
                                  _datepicker();
                                },
                                child: Text(
                                    DateFormat.yMMMd().format(_selectedDate)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Time :",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(160, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    textStyle: const TextStyle(fontSize: 20)),
                                onPressed: () async {
                                  _timePicker();
                                },
                                child: Text(_period(_selectedTime)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(250, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                onPressed: () async {
                                  int toastMessage =
                                      await Provider.of<DoctorDetailsProvider>(
                                              context,
                                              listen: false)
                                          .addAppointmentPaitent(
                                    doctorNameController.text,
                                    _selectedDate.toString(),
                                    _period(_selectedTime).toString(),
                                    doctorRating as int,
                                    doctorId as int,
                                  );
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: toastMessage == 0
                                          ? Provider.of<Language>(context,
                                                  listen: false)
                                              .tYoucanOnlybookonetimeevery30minutesPleaseWait()
                                          : Provider.of<Language>(context,
                                                  listen: false)
                                              .Appointmentbookedsuccessfully(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                },
                                child: Text(lang.tBook()),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  void _datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2024))
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  void _timePicker() async {
    TimeOfDay? newTime =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (newTime == null) return;
    setState(() {
      _selectedTime = newTime;
    });
  }

  String _period(TimeOfDay time) {
    int hour = time.hour, minute = time.minute;
    String period = 'AM';
    if (time.hour >= 12) {
      hour = time.hour - 12;
      period = 'PM';
    }
    if (hour == 0) {
      hour = 12;
    }
    if (minute <= 9) {
      return ('$hour:0$minute $period');
    }
    return ('$hour:$minute $period');
  }
}
