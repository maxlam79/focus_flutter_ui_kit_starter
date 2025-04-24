import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:select2dot1/select2dot1.dart';

import '../../exports.dart';

class FUIInputFieldEvent {
  String? value;
  FUIInputStatusType? fuiInputStatusType;
  String? fuiInputStatusText;
  bool? readOnly;
  bool? enabled;

  FUIInputFieldEvent({
    this.value,
    this.fuiInputStatusType,
    this.fuiInputStatusText,
    this.readOnly,
    this.enabled,
  });
}

class FUIInputFieldController extends Cubit<FUIInputFieldEvent?> {
  FUIInputFieldEvent? event;

  FUIInputFieldController({
    this.event,
  }) : super(event);

  trigger(FUIInputFieldEvent? event) {
    this.event = event;
    emit(event);
  }
}

class FUIInputLabelShrinkController extends Cubit<bool> {
  bool shrink;

  FUIInputLabelShrinkController(this.shrink) : super(shrink);

  trigger(bool shrink) {
    this.shrink = shrink;
    emit(shrink);
  }
}

class FUIInputFieldSelectEvent {
  List<SingleCategoryModel>? dataList;
  List<SingleItemCategoryModel>? selectedDataList;
  String? value;
  FUIInputStatusType? fuiInputStatusType;
  String? fuiInputStatusText;
  bool? readOnly;
  bool? enabled;

  FUIInputFieldSelectEvent({
    this.dataList,
    this.selectedDataList,
    this.value,
    this.fuiInputStatusType,
    this.fuiInputStatusText,
    this.readOnly,
    this.enabled,
  });
}

class FUIInputFieldSelectController extends Cubit<FUIInputFieldSelectEvent?> {
  FUIInputFieldSelectEvent? event;

  FUIInputFieldSelectController({
    this.event,
  }) : super(event);

  trigger(FUIInputFieldSelectEvent? event) {
    this.event = event;
    emit(event);
  }
}

class FUIInputFieldToggleEvent {
  bool? value;
  bool? readOnly;
  bool? enabled;

  FUIInputFieldToggleEvent({
    this.value,
    this.readOnly,
    this.enabled,
  });
}

class FUIInputFieldToggleController extends Cubit<FUIInputFieldToggleEvent?> {
  FUIInputFieldToggleEvent? event;

  FUIInputFieldToggleController({
    this.event,
  }) : super(event);

  trigger(FUIInputFieldToggleEvent? event) {
    this.event = event;
    emit(event);
  }
}

class FUIInputFieldSliderEvent {
  double? value;
  bool? readOnly;
  bool? enabled;

  FUIInputFieldSliderEvent({
    this.value,
    this.readOnly,
    this.enabled,
  });
}

class FUIInputFieldSliderController extends Cubit<FUIInputFieldSliderEvent?> {
  FUIInputFieldSliderEvent? event;

  FUIInputFieldSliderController({
    this.event,
  }) : super(event);

  trigger(FUIInputFieldSliderEvent? event) {
    this.event = event;
    emit(event);
  }
}

class FUIInputFieldRadioEvent {
  bool? readOnly;
  bool? enabled;

  FUIInputFieldRadioEvent({
    this.readOnly,
    this.enabled,
  });
}

class FUIInputFieldRadioController extends Cubit<FUIInputFieldRadioEvent?> {
  FUIInputFieldRadioEvent? event;

  FUIInputFieldRadioController({
    this.event,
  }) : super(event);

  trigger(FUIInputFieldRadioEvent? event) {
    this.event = event;
    emit(event);
  }
}

class FUIInputFieldRadioGroupController<T> extends Cubit<T?> {
  T? groupValue;

  FUIInputFieldRadioGroupController(this.groupValue) : super(groupValue);

  changeTo(T? newGroupValue) {
    groupValue = newGroupValue;
    emit(groupValue);
  }
}

class FUIInputLabelChangeEvent {
  String? labelId;
  bool shrink;

  FUIInputLabelChangeEvent({
    this.labelId,
    required this.shrink,
  });
}
