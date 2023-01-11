import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:patient_app/Module/AppBar.dart';

import '../Module/appointmrntsDetailsModule.dart';
import '../Provider/doctorProfileProvider.dart';
import '../Provider/languageProvider.dart';

class PreivousAppointments extends StatefulWidget {
  @override
  State<PreivousAppointments> createState() => _PreivousAppointmentsState();
}

class _PreivousAppointmentsState extends State<PreivousAppointments> {
  final user = FirebaseAuth.instance.currentUser!;
  bool _isLoading = true;
  bool _isRated = false;
  late double _rating;
  int realNumber = 5;
  int newRating = 0;

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

    List<appointmentsDetails> appointmentsList =
        Provider.of<DoctorDetailsProvider>(context, listen: true)
            .appointmentsList;

    return RefreshIndicator(
      onRefresh: () =>
          Provider.of<DoctorDetailsProvider>(context, listen: false)
              .RefreshScreen(),
      child: Scaffold(
        appBar: MainAppBar(title: lang.tPreivousAppointments()),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : appointmentsList.isEmpty
                ? Center(
                    child: Text(lang.tNopreivousappointmentsfornow()),
                  )
                : Center(
                    child: ListView.builder(
                      itemCount: appointmentsList.length,
                      itemBuilder: (context, index) {
                        var item = appointmentsList[index];
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (c) {
                                  context
                                      .read<DoctorDetailsProvider>()
                                      .delete(item.id)
                                      .then((value) =>
                                          appointmentsList.removeAt(index));
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                label: lang.tDelete(),
                                spacing: 8,
                              )
                            ],
                          ),
                          child: Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: Card(
                                  child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            lang.getLanguage() == 'AR'
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lang.tDrName(),
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(lang.tDate(),
                                              style: const TextStyle(
                                                  fontSize: 20)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(lang.tHour(),
                                              style: const TextStyle(
                                                  fontSize: 20)),
                                          item.isRated == false
                                              ? Text(
                                                  lang.tRate(),
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                )
                                              : Center(),
                                        ]),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.doctorName,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              DateFormat.yMd().format(
                                                  DateTime.parse(item.date)),
                                              style: const TextStyle(
                                                  fontSize: 20)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(item.time,
                                              style: const TextStyle(
                                                  fontSize: 20)),
                                          item.isRated == false
                                              ? Column(
                                                  children: [
                                                    RatingBar.builder(
                                                        onRatingUpdate: (rate) {
                                                          setState(() {
                                                            newRating =
                                                                rate.toInt();
                                                          });
                                                          try {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .doc(user.uid)
                                                                .collection(
                                                                    'appoitment')
                                                                .doc(item.id)
                                                                .update({
                                                              'rating':
                                                                  newRating,
                                                              'isRated': true,
                                                            });
                                                          } catch (e) {
                                                            print(e);
                                                          }
                                                        },
                                                        ignoreGestures: false,
                                                        glow: true,
                                                        itemCount: realNumber,
                                                        minRating: 1,
                                                        initialRating: 0,
                                                        allowHalfRating: false,
                                                        direction:
                                                            Axis.horizontal,
                                                        itemPadding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        itemSize: 20,
                                                        itemBuilder:
                                                            ((context, index) {
                                                          return const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          );
                                                        })),
                                                  ],
                                                )
                                              : Center(),
                                        ]),
                                  ),
                                ],
                              )),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
