import 'dart:async';

class Validators {
  final validateId = StreamTransformer<String, String>.fromHandlers(
      handleData: (Id, sink) {
//        if (Id.contains('@')) {
//          sink.add(Id);
//        } else {
//          sink.addError('Please enter a valid email');
//        }
      }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length > 4) {
          sink.add(password);
        } else {
          sink.addError('Please enter a valid password');
        }
      }
  );
}