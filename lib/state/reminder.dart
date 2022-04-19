import 'dart:typed_data';

import 'package:mobx/mobx.dart';

part 'reminder.g.dart';

class Reminder = _Reminder with _$Reminder;

abstract class _Reminder with Store {
  final String id;
  final DateTime creationDate;

  @observable
  bool hasImage;

  @observable
  Uint8List? imageData;

  @observable
  bool isLoading;

  @observable
  String text;

  @observable
  bool isDone;

  _Reminder({
    required this.id,
    required this.text,
    required this.isDone,
    required this.creationDate,
    required this.hasImage,
  }) : isLoading = false;

  @override
  bool operator ==(covariant _Reminder other) =>
      id == other.id &&
      text == other.text &&
      isDone == other.isDone &&
      creationDate == other.creationDate;

  @override
  int get hashCode => Object.hash(
        id,
        text,
        isDone,
        creationDate,
      );
}
