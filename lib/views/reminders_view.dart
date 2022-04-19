import 'package:flutter/material.dart';
import 'package:mobxreminders_course/dialogs/show_textfield_dialog.dart';
import 'package:mobxreminders_course/state/app_state.dart';
import 'package:mobxreminders_course/views/main_popup_menu_button.dart';
import 'package:mobxreminders_course/views/reminders_list_view.dart';
import 'package:provider/provider.dart';

class RemindersView extends StatelessWidget {
  const RemindersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reminders',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final reminderText = await showTextFieldDialog(
                context: context,
                title: 'What do you want me to remind you about?',
                hintText: 'Enter your reminer text here...',
                optionsBuilder: () => {
                  TextFieldDialogButtonType.cancel: 'Cancel',
                  TextFieldDialogButtonType.confirm: 'Save',
                },
              );
              if (reminderText == null) {
                return;
              }
              context.read<AppState>().createReminder(
                    reminderText,
                  );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
          const MainPopupMenuButton(),
        ],
      ),
      body: const RemindersListView(),
    );
  }
}
