import 'package:intl/intl.dart';

String dateFormatting(String date) {
  final thedate = DateTime.parse(date);
  final formatteddate = DateFormat('d/M/yy').format(thedate);
  return formatteddate.toString();
}

  //  DataCell(Text(dateFormatting(troutcatchdata.date.toString()))),