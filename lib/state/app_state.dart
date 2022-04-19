import 'dart:io';
import 'dart:typed_data';

import 'package:mobx/mobx.dart';
import 'package:mobxreminders_course/auth/auth_error.dart';
import 'package:mobxreminders_course/provider/auth_provider.dart';
import 'package:mobxreminders_course/provider/reminders_provider.dart';
import 'package:mobxreminders_course/state/reminder.dart';
import 'package:mobxreminders_course/utils/upload_image.dart';

part 'app_state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  final AuthProvider authProvider;
  final RemindersProvider remindersProvider;

  _AppState({
    required this.authProvider,
    required this.remindersProvider,
  });

  @observable
  AppScreen currentScreen = AppScreen.login;

  @observable
  bool isLoading = false;

  @observable
  AuthError? authError;

  @observable
  ObservableList<Reminder> reminders = ObservableList<Reminder>();

  @computed
  ObservableList<Reminder> get sortedReminders =>
      ObservableList.of(reminders.sorted());

  @action
  void goTo(AppScreen screen) {
    currentScreen = screen;
  }

  @action
  Future<bool> delete(
    Reminder reminder,
  ) async {
    isLoading = true;
    final userId = authProvider.userId;
    if (userId == null) {
      isLoading = false;
      return false;
    }

    try {
      // delete remotely
      await remindersProvider.deleteReminderWithId(
        reminder.id,
        userId: userId,
      );
      // delete locally
      reminders.removeWhere(
        (element) => element.id == reminder.id,
      );
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> deleteAccount() async {
    isLoading = true;
    final userId = authProvider.userId;
    if (userId == null) {
      isLoading = false;
      return false;
    }
    try {
      // delete all documents from Firebase
      await remindersProvider.deleteAllDocuments(
        userId: userId,
      );
      // remove all reminders locally when we log out
      reminders.clear();
      // delete account + sign out
      await authProvider.deleteAccountAndSignOut();
      currentScreen = AppScreen.login;
      return true;
    } on AuthError catch (e) {
      authError = e;
      return false;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> logOut() async {
    isLoading = true;
    await authProvider.signOut();
    reminders.clear();
    isLoading = false;
    currentScreen = AppScreen.login;
  }

  @action
  Future<bool> createReminder(String text) async {
    isLoading = true;
    final userId = authProvider.userId;
    if (userId == null) {
      isLoading = false;
      return false;
    }

    final creationDate = DateTime.now();

    // create the firebase reminder
    final cloudReminderId = await remindersProvider.createReminder(
      userId: userId,
      text: text,
      creationDate: creationDate,
    );

    // create local reminder
    final reminder = Reminder(
      creationDate: creationDate,
      id: cloudReminderId,
      isDone: false,
      text: text,
      hasImage: false,
    );
    reminders.add(reminder);
    isLoading = false;
    return true;
  }

  @action
  Future<bool> modifyReminder({
    required ReminderId reminderId,
    required bool isDone,
  }) async {
    final userId = authProvider.userId;
    if (userId == null) {
      return false;
    }

    await remindersProvider.modify(
      reminderId: reminderId,
      isDone: isDone,
      userId: userId,
    );

    // update the local reminder
    reminders
        .firstWhere(
          (element) => element.id == reminderId,
        )
        .isDone = isDone;

    return true;
  }

  @action
  Future<void> initialize() async {
    isLoading = true;
    final userId = authProvider.userId;
    if (userId != null) {
      await _loadReminders();
      currentScreen = AppScreen.reminders;
    } else {
      currentScreen = AppScreen.login;
    }
    isLoading = false;
  }

  @action
  Future<bool> _loadReminders() async {
    final userId = authProvider.userId;
    if (userId == null) {
      return false;
    }

    final reminders = await remindersProvider.loadReminders(
      userId: userId,
    );

    this.reminders = ObservableList.of(reminders);
    return true;
  }

  @action
  Future<bool> _registerOrLogin({
    required LoginOrRegisterFunction fn,
    required String email,
    required String password,
  }) async {
    authError = null;
    isLoading = true;
    try {
      final succeeded = await fn(
        email: email,
        password: password,
      );
      if (succeeded) {
        await _loadReminders();
      }
      return succeeded;
    } on AuthError catch (e) {
      authError = e;
      return false;
    } finally {
      isLoading = false;
      if (authProvider.userId != null) {
        currentScreen = AppScreen.reminders;
      }
    }
  }

  @action
  Future<bool> register({
    required String email,
    required String password,
  }) =>
      _registerOrLogin(
        fn: authProvider.register,
        email: email,
        password: password,
      );

  @action
  Future<bool> login({
    required String email,
    required String password,
  }) =>
      _registerOrLogin(
        fn: authProvider.login,
        email: email,
        password: password,
      );

  @action
  Future<bool> upload({
    required String filePath,
    required ReminderId forReminderId,
  }) async {
    final userId = authProvider.userId;
    if (userId == null) {
      return false;
    }

    // set the reminder as loading while uploading the image

    final reminder = reminders.firstWhere(
      (element) => element.id == forReminderId,
    );
    reminder.isLoading = true;

    final file = File(filePath);
    final imageId = await uploadImage(
      file: file,
      userId: userId,
      imageId: forReminderId,
    );

    if (imageId == null) {
      reminder.isLoading = false;
      return false;
    }

    await remindersProvider.setReminderHasImage(
      reminderId: forReminderId,
      userId: userId,
    );

    reminder.isLoading = false;
    reminder.hasImage = true;
    return true;
  }

  Future<Uint8List?> getReminderImage({
    required ReminderId reminderId,
  }) async {
    final userId = authProvider.userId;
    if (userId == null) {
      return null;
    }

    final reminder = reminders.firstWhere(
      (element) => element.id == reminderId,
    );
    final existingImageData = reminder.imageData;
    if (existingImageData != null) {
      return existingImageData;
    }

    final image = await remindersProvider.getReminderImage(
      userId: userId,
      reminderId: reminderId,
    );
    reminder.imageData = image;
    return image;
  }
}

typedef LoginOrRegisterFunction = Future<bool> Function({
  required String email,
  required String password,
});

extension ToInt on bool {
  int toInteger() => this ? 1 : 0;
}

extension Sorted on List<Reminder> {
  List<Reminder> sorted() => [...this]..sort(
      (lhs, rhs) {
        final isDone = lhs.isDone.toInteger().compareTo(
              rhs.isDone.toInteger(),
            );
        if (isDone != 0) {
          return isDone;
        }
        return lhs.creationDate.compareTo(rhs.creationDate);
      },
    );
}

enum AppScreen { login, register, reminders }
