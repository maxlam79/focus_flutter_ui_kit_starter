import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FUIAccordionEvent {
  final Key itemKey;
  final bool expand;

  FUIAccordionEvent({
    required this.itemKey,
    required this.expand,
  });
}

class FUIAccordionController extends Cubit<FUIAccordionEvent?> {
  FUIAccordionEvent? event;

  FUIAccordionController({
    this.event,
  }) : super(event);

  trigger(FUIAccordionEvent? event) {
    this.event = event;
    emit(this.event);
  }
}
