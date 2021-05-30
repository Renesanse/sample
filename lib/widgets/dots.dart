import "dart:async";
import "package:flutter/cupertino.dart";

class LoaderDots extends StatefulWidget {
  const LoaderDots({Key? key}) : super(key: key);

  @override
  _LoaderDotsState createState() => _LoaderDotsState();
}

class _LoaderDotsState extends State<LoaderDots> {
  int _state = 0;
  final _timer = Stream.periodic(_time, (t) => t);
  StreamSubscription<void>? _timerSub;
  static const _splitter = SizedBox(width: 6.5);
  static const _time = Duration(milliseconds: 200);
  static const _color = CupertinoColors.black;

  @override
  void initState() {
    _timerSub = _timer.listen((_) {
      _state++;
      if (_state == 3) {
        _state = 0;
      }
      setState(() {});
    });
    super.initState();
  }

  Color _mapColorToNum(int num) {
    switch (num) {
      case 0:
        return _color;
      case 1:
        return _color.withOpacity(0.3);
      case 2:
        return _color.withOpacity(0.6);
    }
    return _color;
  }

  List<int> _mapNumToState(int num) {
    switch (num) {
      case 0:
        return [0, 1, 2];
      case 1:
        return [2, 0, 1];
      case 2:
        return [1, 2, 0];
    }
    return [];
  }

  double _mapSizeToState(int num) {
    switch (num) {
      case 0:
        return 13;
      case 1:
        return 6.5;
      case 2:
        return 9.75;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final states = _mapNumToState(_state);
    return SizedBox(
      width: 52,
      height: 13,
      child: Row(
        children: [
          _Dot(
            key: const ValueKey("first"),
            time: _time,
            color: _mapColorToNum(states[0]),
            size: _mapSizeToState(states[0]),
          ),
          _splitter,
          _Dot(
            key: const ValueKey("second"),
            time: _time,
            color: _mapColorToNum(states[1]),
            size: _mapSizeToState(states[1]),
          ),
          _splitter,
          _Dot(
            key: const ValueKey("third"),
            time: _time,
            color: _mapColorToNum(states[2]),
            size: _mapSizeToState(states[2]),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timerSub?.cancel();
    super.dispose();
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final double size;
  final Duration time;

  const _Dot({Key? key, required this.color, required this.time, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 13,
      width: 13,
      child: AnimatedContainer(
        height: size,
        width: size,
        key: const ValueKey("third"),
        duration: time,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
