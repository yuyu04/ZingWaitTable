import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import './login_validators.dart';
import 'package:zing_wait_table/src/models/login_state.dart';
import 'package:zing_wait_table/src/resource/web_sockets_notifications.dart';

import '../models/login_state.dart';

class LoginBloc with Validators {
  final _id = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  BehaviorSubject<LoginState> subject;

  factory LoginBloc() {
    final subject = BehaviorSubject<LoginState>.seeded(LoginInitial());
    return LoginBloc._(subject);
  }

  LoginBloc._(this.subject) {
    sockets.initCommunication();
    sockets.addListener(_onMessageReceive);
  }

  Stream<String> get id => _id.stream.transform(validateId);
  Stream<String> get password => _password.stream.transform(validatePassword);

  Function(String) get changeId => _id.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Stream<bool> get submitValid => Observable.combineLatest2(id, password, (email, password) {
    return true;
  });

  submit() {
    final validId = _id.value;
    final validPassword = _password.value;

    this.subject.sink.add(LoginLoading());
    sockets.send(json.encode({
      "id": validId,
      "pw": validPassword
    }));

    this.subject.sink.add(LoginSuccess());
  }

  _onMessageReceive() {

  }

  dispose() {
    _id.close();
    _password.close();
    this.subject.close();
  }
}