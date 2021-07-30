import 'dart:async';

// Possible events that can trigger from UI
enum CounterEvent { increment, decrement, reset }

/*
 In StreamController there are two things:
 Sink - Input
 Stream - Output
*/

class CounterBloc {
  // Counter state value
  int _counter = 0;

  // Create stream that controlls event that we receive from UI
  final _eventStreamController = StreamController<CounterEvent>();

  // Create sink which will receive CounterEvent enum
  StreamSink<CounterEvent> get eventSink => _eventStreamController.sink;
  // Create stream which we'll listen in CounterBloc initialization
  Stream<CounterEvent> get _eventStream => _eventStreamController.stream;

  // Create stream that controlls counter state. We pass int because data type of _counter is int.
  final _stateStreamController = StreamController<int>();

  // Create sink which will receive new counter state
  StreamSink<int> get _counterSink => _stateStreamController.sink;

  // Create stream which we'll use in StreamBuilder widget to listen to changes
  Stream<int> get counterStream => _stateStreamController.stream;

  CounterBloc() {
    // During initialization setup listener, that listens to events triggered from UI
    _eventStream.listen((event) {
      if (event == CounterEvent.increment)
        _counter++;
      else if (event == CounterEvent.decrement)
        _counter--;
      else if (event == CounterEvent.reset) _counter = 0;

      _counterSink.add(_counter);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
