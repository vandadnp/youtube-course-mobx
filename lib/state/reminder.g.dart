// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Reminder on _Reminder, Store {
  final _$hasImageAtom = Atom(name: '_Reminder.hasImage');

  @override
  bool get hasImage {
    _$hasImageAtom.reportRead();
    return super.hasImage;
  }

  @override
  set hasImage(bool value) {
    _$hasImageAtom.reportWrite(value, super.hasImage, () {
      super.hasImage = value;
    });
  }

  final _$imageDataAtom = Atom(name: '_Reminder.imageData');

  @override
  Uint8List? get imageData {
    _$imageDataAtom.reportRead();
    return super.imageData;
  }

  @override
  set imageData(Uint8List? value) {
    _$imageDataAtom.reportWrite(value, super.imageData, () {
      super.imageData = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_Reminder.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$textAtom = Atom(name: '_Reminder.text');

  @override
  String get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(String value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  final _$isDoneAtom = Atom(name: '_Reminder.isDone');

  @override
  bool get isDone {
    _$isDoneAtom.reportRead();
    return super.isDone;
  }

  @override
  set isDone(bool value) {
    _$isDoneAtom.reportWrite(value, super.isDone, () {
      super.isDone = value;
    });
  }

  @override
  String toString() {
    return '''
hasImage: ${hasImage},
imageData: ${imageData},
isLoading: ${isLoading},
text: ${text},
isDone: ${isDone}
    ''';
  }
}
