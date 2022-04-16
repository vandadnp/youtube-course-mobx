import 'package:flutter/material.dart' show BuildContext;
import 'package:mobxreminders_course/dialogs/generic_dialog.dart';

Future<bool> showDeleteReminderDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete reminder',
    content:
        'Are you sure you want to delete this reminder? You cannot undo this action!',
    optionsBuilder: () => {
      'Cancel': false,
      'Delete': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
