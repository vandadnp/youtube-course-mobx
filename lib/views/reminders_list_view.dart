import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobxreminders_course/dialogs/delete_reminder_dialog.dart';
import 'package:mobxreminders_course/state/app_state.dart';
import 'package:provider/provider.dart';

late final _imagePicker = ImagePicker();

class RemindersListView extends StatelessWidget {
  const RemindersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Observer(
      builder: (context) {
        return ListView.builder(
          itemCount: appState.sortedReminders.length,
          itemBuilder: (context, index) {
            return ReminderTile(
              reminderIndex: index,
              imagePicker: _imagePicker,
            );
          },
        );
      },
    );
  }
}

class ReminderTile extends StatelessWidget {
  final int reminderIndex;
  final ImagePicker imagePicker;

  const ReminderTile(
      {Key? key, required this.reminderIndex, required this.imagePicker})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    final reminder = appState.sortedReminders[reminderIndex];
    return Observer(
      builder: (context) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: reminder.isDone,
          onChanged: (isDone) {
            context.read<AppState>().modifyReminder(
                  reminderId: reminder.id,
                  isDone: isDone ?? false,
                );
            reminder.isDone = isDone ?? false;
          },
          subtitle: ReminderImageView(
            reminderIndex: reminderIndex,
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  reminder.text,
                ),
              ),
              reminder.isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox(),
              reminder.hasImage
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () async {
                        final image = await imagePicker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (image != null) {
                          appState.upload(
                            filePath: image.path,
                            forReminderId: reminder.id,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.upload,
                      ),
                    ),
              IconButton(
                onPressed: () async {
                  final shouldDeleteReminder =
                      await showDeleteReminderDialog(context);
                  if (shouldDeleteReminder) {
                    context.read<AppState>().delete(reminder);
                  }
                },
                icon: const Icon(
                  Icons.delete,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ReminderImageView extends StatelessWidget {
  final int reminderIndex;
  const ReminderImageView({
    Key? key,
    required this.reminderIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    final reminder = appState.sortedReminders[reminderIndex];
    if (reminder.hasImage) {
      return FutureBuilder<Uint8List?>(
        future: appState.getReminderImage(reminderId: reminder.id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasData) {
                return Image.memory(snapshot.data!);
              } else {
                return const Center(
                  child: Icon(
                    Icons.error,
                  ),
                );
              }
          }
        },
      );
    } else {
      return const SizedBox();
    }
  }
}
