import "package:flutter/cupertino.dart";

import "dots.dart";

class AsyncFadeIn<T> extends StatefulWidget {
  final Widget Function(Object error) errorBuilder;
  final Widget Function(T? data) dataBuilder;
  final Future<T> future;

  const AsyncFadeIn({Key? key, required this.errorBuilder, required this.dataBuilder, required this.future}) : super
      (key: key);

  @override
  _AsyncFadeInState<T> createState() => _AsyncFadeInState<T>();
}

class _AsyncFadeInState<T> extends State<AsyncFadeIn<T>> {
  var _isShowSecond = true;
  Widget _lastWidget = const SizedBox.shrink();
  // GlobalKey? _currentLoaderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: widget.future,
        builder: (_, snapshot) {
          Widget first = const SizedBox.shrink();
          Widget second = const SizedBox.shrink();
          first = _lastWidget;
          if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
            second = widget.dataBuilder(snapshot.data);
            // _currentLoaderKey = null;
          }
          if (snapshot.hasError) {
            second = widget.errorBuilder(snapshot.error!);
            // _currentLoaderKey = null;
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // _currentLoaderKey ??= GlobalKey();
            second = const LoaderDots();
          }
          if (!_isShowSecond) {
            first = second;
            second = _lastWidget;
            _lastWidget = first;
          } else {
            _lastWidget = second;
          }
          _isShowSecond = !_isShowSecond;
          return AnimatedCrossFade(
            firstChild: first,
            secondChild: second,
            layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
              return Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Center(
                    key: bottomChildKey,
                    child: bottomChild,
                  ),
                  Center(
                    key: topChildKey,
                    child: topChild,
                  ),
                ],
              );
            },
            firstCurve: Curves.decelerate,
            secondCurve: Curves.decelerate,
            crossFadeState: _isShowSecond ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
          );
        });
  }
}
