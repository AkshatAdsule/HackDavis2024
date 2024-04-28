import 'package:flutter/material.dart';

class WaitScreen<T> extends StatefulWidget {
  final Future<T> future;
  final void Function(T) onSuccess;

  const WaitScreen({
    super.key,
    required this.future,
    required this.onSuccess,
  });

  @override
  State<WaitScreen<T>> createState() => _WaitScreenState<T>();
}

class _WaitScreenState<T> extends State<WaitScreen<T>> {
  @override
  void initState() {
    super.initState();
    widget.future.then(
      (T value) {
        widget.onSuccess(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
