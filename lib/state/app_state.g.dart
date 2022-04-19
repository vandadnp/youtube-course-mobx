// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppState on _AppState, Store {
  Computed<ObservableList<Reminder>>? _$sortedRemindersComputed;

  @override
  ObservableList<Reminder> get sortedReminders => (_$sortedRemindersComputed ??=
          Computed<ObservableList<Reminder>>(() => super.sortedReminders,
              name: '_AppState.sortedReminders'))
      .value;

  final _$currentScreenAtom = Atom(name: '_AppState.currentScreen');

  @override
  AppScreen get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(AppScreen value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AppState.isLoading');

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

  final _$authErrorAtom = Atom(name: '_AppState.authError');

  @override
  AuthError? get authError {
    _$authErrorAtom.reportRead();
    return super.authError;
  }

  @override
  set authError(AuthError? value) {
    _$authErrorAtom.reportWrite(value, super.authError, () {
      super.authError = value;
    });
  }

  final _$remindersAtom = Atom(name: '_AppState.reminders');

  @override
  ObservableList<Reminder> get reminders {
    _$remindersAtom.reportRead();
    return super.reminders;
  }

  @override
  set reminders(ObservableList<Reminder> value) {
    _$remindersAtom.reportWrite(value, super.reminders, () {
      super.reminders = value;
    });
  }

  final _$deleteAsyncAction = AsyncAction('_AppState.delete');

  @override
  Future<bool> delete(Reminder reminder) {
    return _$deleteAsyncAction.run(() => super.delete(reminder));
  }

  final _$deleteAccountAsyncAction = AsyncAction('_AppState.deleteAccount');

  @override
  Future<bool> deleteAccount() {
    return _$deleteAccountAsyncAction.run(() => super.deleteAccount());
  }

  final _$logOutAsyncAction = AsyncAction('_AppState.logOut');

  @override
  Future<void> logOut() {
    return _$logOutAsyncAction.run(() => super.logOut());
  }

  final _$createReminderAsyncAction = AsyncAction('_AppState.createReminder');

  @override
  Future<bool> createReminder(String text) {
    return _$createReminderAsyncAction.run(() => super.createReminder(text));
  }

  final _$modifyReminderAsyncAction = AsyncAction('_AppState.modifyReminder');

  @override
  Future<bool> modifyReminder(
      {required String reminderId, required bool isDone}) {
    return _$modifyReminderAsyncAction.run(
        () => super.modifyReminder(reminderId: reminderId, isDone: isDone));
  }

  final _$initializeAsyncAction = AsyncAction('_AppState.initialize');

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  final _$_loadRemindersAsyncAction = AsyncAction('_AppState._loadReminders');

  @override
  Future<bool> _loadReminders() {
    return _$_loadRemindersAsyncAction.run(() => super._loadReminders());
  }

  final _$_registerOrLoginAsyncAction =
      AsyncAction('_AppState._registerOrLogin');

  @override
  Future<bool> _registerOrLogin(
      {required LoginOrRegisterFunction fn,
      required String email,
      required String password}) {
    return _$_registerOrLoginAsyncAction.run(
        () => super._registerOrLogin(fn: fn, email: email, password: password));
  }

  final _$uploadAsyncAction = AsyncAction('_AppState.upload');

  @override
  Future<bool> upload(
      {required String filePath, required String forReminderId}) {
    return _$uploadAsyncAction.run(
        () => super.upload(filePath: filePath, forReminderId: forReminderId));
  }

  final _$_AppStateActionController = ActionController(name: '_AppState');

  @override
  void goTo(AppScreen screen) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.goTo');
    try {
      return super.goTo(screen);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> register({required String email, required String password}) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.register');
    try {
      return super.register(email: email, password: password);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> login({required String email, required String password}) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.login');
    try {
      return super.login(email: email, password: password);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
isLoading: ${isLoading},
authError: ${authError},
reminders: ${reminders},
sortedReminders: ${sortedReminders}
    ''';
  }
}
