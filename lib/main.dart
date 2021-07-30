import 'package:flutter/material.dart';
import 'package:flutter_counter/counter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Counter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterBloc = CounterBloc();

  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MyHomePage build method will not be called on counter change
    print('--- MyHomePage builds ---');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),

            // Only this widget will rebuild after counter state change
            StreamBuilder<int>(
              stream: counterBloc.counterStream,
              initialData: 0,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                return Text('Error');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventSink.add(CounterEvent.decrement);
            },
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventSink.add(CounterEvent.reset);
            },
            tooltip: 'Reset',
            child: Icon(Icons.loop),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventSink.add(CounterEvent.increment);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
