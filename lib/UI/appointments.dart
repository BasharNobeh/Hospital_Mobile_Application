import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:patient_app/Provider/doctorProfileProvider.dart';
import 'package:patient_app/UI/previous_appointments.dart';

import '../Module/appointmrntsDetailsModule.dart';
import '../Provider/languageProvider.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  bool _isLoading = true;
  DateTime dateNow = DateTime.now();
  @override
  void initState() {
    Provider.of<DoctorDetailsProvider>(context, listen: false)
        .fetchData()
        .then((_) => _isLoading = false)
        .catchError((onError) => print(onError));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<Language>(context, listen: true);

    //any appointment passed the current day will be moved to previos appointments
    List<appointmentsDetails> appointmentsList =
        Provider.of<DoctorDetailsProvider>(context, listen: true)
            .appointmentsList
            .where((element) =>
                compareTimes(DateTime.parse(element.date), element.time))
            .toList();

    return RefreshIndicator(
      onRefresh: () =>
          Provider.of<DoctorDetailsProvider>(context, listen: false)
              .RefreshScreen(),
      child: Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              lang.getLanguage() == 'EN'
                                  ? const Icon(
                                      Icons.schedule,
                                      size: 25,
                                    )
                                  :const Center(),
                              Text(
                                lang.tScheduledAppointments(),
                                style: const TextStyle(fontSize: 25),
                              ),
                              lang.getLanguage() == 'AR'
                                  ? const Icon(
                                      Icons.schedule,
                                      size: 25,
                                    )
                                  :const Center()
                            ],
                          ),
                        )),
                      ),
                      appointmentsList.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                      child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Text(
                                      lang.tNoappointmentsbooked(),
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                  )),
                                ),
                              ],
                            )
                          : Expanded(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: ListView(children: [
                                    ...appointmentsList.map((e) {
                                      return ReportAppointment(e.doctorName,
                                          e.date, e.time, context);
                                    }),
                                  ]),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PreivousAppointments(),
                              )),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    size: 120,
                                    color: Colors.blueGrey,
                                  ),
                                  Text(lang.tPreivousAppointments(),
                                      style: const TextStyle(fontSize: 25)),
                                  Text(lang.tViewPreviousAppointments(),
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
      ),
    );
  }

  Widget ReportAppointment(
      String doctorName, String date, String time, BuildContext context) {
    var lang = Provider.of<Language>(context, listen: true);
    return Container(
      width: 150,
      height: 160,
      child: SizedBox(
        width: double.infinity,
        child: Card(
            child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: lang.getLanguage() == 'AR'
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.tDrName(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(lang.tDate(), style: const TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(lang.tHour(), style: const TextStyle(fontSize: 20)),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      doctorName,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(DateFormat.yMd().format(DateTime.parse(date)),
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(time, style: const TextStyle(fontSize: 20)),
                  ]),
            ),
          ],
        )),
      ),
    );
  }

  compareTimes(DateTime date, String time) {
    dateNow = DateTime.now();
    if (date.year >= dateNow.year) {
      if (date.month >= dateNow.month) {
        if (date.day >= dateNow.day) {
          return true;
        }
      }
    }
    return false;
  }
}
