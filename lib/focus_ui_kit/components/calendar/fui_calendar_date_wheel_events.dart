import 'package:flutter_bloc/flutter_bloc.dart';

class FUICalendarDateWheelYearController extends Cubit<int> {
  int selectedYear;

  FUICalendarDateWheelYearController({
    required this.selectedYear,
  }) : super(selectedYear);

  nextYear() {
    selectedYear = selectedYear + 1;
    emit(selectedYear);
  }

  prevYear() {
    selectedYear = selectedYear - 1;
    emit(selectedYear);
  }

  gotoYear(int selectedYear) {
    this.selectedYear = selectedYear;
    emit(this.selectedYear);
  }
}

class FUICalendarDateWheelDateController extends Cubit<DateTime> {
  DateTime selectedDate;

  FUICalendarDateWheelDateController({
    required this.selectedDate,
  }) : super(selectedDate);

  selectDate(DateTime selectedDate) {
    this.selectedDate = selectedDate;
    emit(this.selectedDate);
  }
}
