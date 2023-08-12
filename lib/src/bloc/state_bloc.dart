import 'package:rxdart/rxdart.dart';

// Preferences.
import 'package:flutter_boilerplate_project/src/preferences/preferences.dart';

// Model.
import 'package:flutter_boilerplate_project/src/models/session_model.dart';

// Constants.
import 'package:flutter_boilerplate_project/src/commons/constants/strings.dart';

class StateBloc {
  final _sessionController = BehaviorSubject<SessionModel>();
  final _loadingTextController = BehaviorSubject<String>();

  // Get values from Stream.
  Stream<SessionModel> get sessionStream => _sessionController.stream;
  Stream<String> get loadingTextStream => _loadingTextController.stream;

  // Set values to Stream.
  Function(SessionModel) get changeSession => _sessionController.sink.add;
  Function(String) get changeLoadingText => _loadingTextController.sink.add;

  // Get last values of the streams.
  SessionModel get session => _sessionController.value;
  String get loadingText => _loadingTextController.value;

  // Close Stream Controllers.
  dispose() {
    _sessionController.close();
    _loadingTextController.close();
  }

  // Reset fields.
  void reset() {
    SessionModel session = SessionModel.fromJson(Preferences().session.toJson());
    changeSession(session);
    changeLoadingText(Strings.emptyString);
  }

  // Update session.
  void updateSession(SessionModel session) {
    changeSession(session);
    Preferences().session = session;
  }

  // Logout.
  void logout() {
    session.logout();
    changeSession(session);
    Preferences().session = session;
  }
}