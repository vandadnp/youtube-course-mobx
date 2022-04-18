import 'package:mobxreminders_course/provider/reminders_provider.dart';
import 'package:mobxreminders_course/state/reminder.dart';

import '../utils.dart';

final mockReminder1DateTime = DateTime(2000, 1, 2, 3, 4, 5, 6, 7);
const mockReminder1Id = '1';
const mockReminder1Text = 'text1';
const mockReminder1IsDone = true;
final mockReminder1 = Reminder(
  creationDate: mockReminder1DateTime,
  id: mockReminder1Id,
  isDone: mockReminder1IsDone,
  text: mockReminder1Text,
);

final mockReminder2DateTime = DateTime(2001, 1, 2, 3, 4, 5, 6, 7);
const mockReminder2Id = '2';
const mockReminder2Text = 'text2';
const mockReminder2IsDone = false;
final mockReminder2 = Reminder(
  creationDate: mockReminder2DateTime,
  id: mockReminder2Id,
  isDone: mockReminder2IsDone,
  text: mockReminder2Text,
);

final Iterable<Reminder> mockReminders = [
  mockReminder1,
  mockReminder2,
];

const mockReminderId = 'mockreminderid';

class MockRemindersProvider implements RemindersProvider {
  @override
  Future<ReminderId> createReminder({
    required String userId,
    required String text,
    required DateTime creationDate,
  }) =>
      mockReminderId.toFuture(oneSecond);

  @override
  Future<void> deleteAllDocuments({
    required String userId,
  }) =>
      Future.delayed(oneSecond);

  @override
  Future<void> deleteReminderWithId(
    ReminderId id, {
    required String userId,
  }) =>
      Future.delayed(oneSecond);

  @override
  Future<Iterable<Reminder>> loadReminders({
    required String userId,
  }) =>
      mockReminders.toFuture(oneSecond);

  @override
  Future<void> modify({
    required ReminderId reminderId,
    required bool isDone,
    required String userId,
  }) =>
      Future.delayed(oneSecond);
}
