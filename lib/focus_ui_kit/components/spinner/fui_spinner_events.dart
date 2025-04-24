import 'package:flutter_bloc/flutter_bloc.dart';

class FUISpinnerController extends Cubit<bool?> {
  bool? spinnerShow;

  FUISpinnerController({
    this.spinnerShow,
  }) : super(spinnerShow);

  show(bool spinnerShow) {
    this.spinnerShow = spinnerShow;
    emit(this.spinnerShow);
  }
}
