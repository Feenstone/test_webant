import 'package:intl/intl.dart';
class DateValidator {
  bool isAdult2(String birthDateString) {
    try {
      String datePattern = "dd/MM/yyyy";

      DateTime today = DateTime.now();

      DateTime birthDate = DateFormat(datePattern).parse(birthDateString);

      DateTime adultDate = DateTime(
        birthDate.year + 18,
        birthDate.month,
        birthDate.day,
      );

      return adultDate.isBefore(today);
    }catch(e){
      return true;
  }
}
}