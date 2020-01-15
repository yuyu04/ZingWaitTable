import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:zing_wait_table/src/models/waiting_state.dart';
import 'package:zing_wait_table/src/models/waiting.dart';

class WaitingBloc {
  BehaviorSubject<List<Waiting>> _subjectWaiting;

  WaitingBloc() {
    _subjectCounter = BehaviorSubject<int>.seeded(this.initialCount);
  }

  Observable<int> get counterObservable => _subjectCounter.stream;

  void dispose() {
    onWaitingChanged.close();
  }

  static Stream<WaitingState> _search(String term, WaitingApi api) async* {
    if (term.isEmpty) {
      yield WaitingNoTerm();
    } else {
      yield WaitingLoading();

      try {
//        final result = await api.search(term);
//
//        if (result.isEmpty) {
//          yield SearchEmpty();
//        } else {
//          yield SearchPopulated(result);
//        }

      } catch (e) {
        yield WaitingError();
      }
    }
  }
}
