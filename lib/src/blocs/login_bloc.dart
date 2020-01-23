import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:zing_wait_table/src/models/login_state.dart';
import 'package:zing_wait_table/src/resource/web_sockets_notifications.dart';

class LoginBloc {
  final _idController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();
  final _id = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final Stream<LoginState> state;

  factory LoginBloc() {
    final state = Stream.;

    return LoginBloc._(state);
  }

  LoginBloc._(this.state) {
    sockets.initCommunication();

    sockets.addListener(_onMessageReceive);
  }

  Stream<String> get email => _id.stream.transform(validateId);
  Stream<String> get password => _password.stream.transform(validatePassword);

  Function(String) get changeEmail => _id.sink.add;

  Function(String) get changePassword => _password.sink.add;

  submit() {
    final validId = _id.value;
    final validPassword = _password.value;

    sockets.send(json.encode({
      "id": validId,
      "pw": validPassword
    }));
  }

  _onMessageReceive() {

  }

  dispose() {
    _id.close();
    _password.close();
  }
}