import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FUITabPaneEvent {
  final Key selectedTabItemKey;

  FUITabPaneEvent({
    required this.selectedTabItemKey,
  });
}

class FUITabPaneController extends Cubit<FUITabPaneEvent?> {
  FUITabPaneEvent? event;

  FUITabPaneController({
    this.event,
  }) : super(event);

  trigger(FUITabPaneEvent? event) {
    this.event = event;
    emit(event);
  }
}
