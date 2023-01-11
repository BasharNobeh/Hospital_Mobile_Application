import 'package:flutter/cupertino.dart';
import 'dart:convert';

class appointmentsDetails {
  final String id;
  final String doctorName;
  final String date;
  final String time;
  final int? rating;
  final int? doctorId;
  final bool? isRated;

  appointmentsDetails(
      {required this.id,
      required this.doctorName,
      required this.date,
      required this.time,
      required this.rating,
      required this.doctorId,
      required this.isRated});
}
