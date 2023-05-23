// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String timestampToDateTime(Timestamp timestamp) {
  final format = DateFormat('HH:mm');
  final dateTime =
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  return format.format(dateTime);
}
