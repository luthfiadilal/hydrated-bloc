import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum ColorEvent { to_amber, to_light_blue }

class ColorBloc extends HydratedBloc<ColorEvent, Color> {
  // Constructor yang mengatur state awal
  ColorBloc() : super(Colors.amber) {
    // Memetakan event ke state
    on<ColorEvent>((event, emit) {
      if (event == ColorEvent.to_amber) {
        emit(Colors.amber); // Mengubah warna ke amber
      } else if (event == ColorEvent.to_light_blue) {
        emit(Colors.lightBlue); // Mengubah warna ke light blue
      }
    });
  }

  @override
  Color? fromJson(Map<String, dynamic> json) {
    try {
      return Color(json['color'] as int);
    } catch (e) {
      return Colors.amber;
    }
  }

  @override
  Map<String, dynamic>? toJson(Color state) {
    try {
      return {'color': state.value};
    } catch (e) {
      return null;
    }
  }
}
