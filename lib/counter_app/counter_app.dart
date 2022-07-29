import 'dart:async';

import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _count = 0;
  final _api = CounterApi();
  StreamSubscription<int>? _subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subscription = _api.countStream.listen((count) {
      setState(() {
        _count = count;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카운터 스트림버전'),
      ),
      body: Center(
        child: Text('$_count', style: TextStyle(fontSize: 60)),
    
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _api.increase();
      },
      child: Icon(Icons.add),),
    );
  }
}

class CounterApi {
  int _count = 0;
  final _countStreamController = StreamController<int>();
  Stream<int> get countStream => _countStreamController.stream;

  void increase() {
    _count++;
    _countStreamController.add(_count);
  }
}
