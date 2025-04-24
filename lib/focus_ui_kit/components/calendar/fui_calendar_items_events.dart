import 'package:flutter_bloc/flutter_bloc.dart';

class FUICalendarItemOptionBtnVisibleController extends Cubit<bool> {
  bool showBtn;

  FUICalendarItemOptionBtnVisibleController({
    required this.showBtn,
  }) : super(showBtn);

  toggleShowBtn(bool showBtn) {
    this.showBtn = showBtn;
    emit(this.showBtn);
  }
}
