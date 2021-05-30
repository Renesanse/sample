import "package:flutter/cupertino.dart";
import "package:flutter/services.dart";

class SampleButton extends StatelessWidget {
  final String text;
  final double? horizontalPadding;
  final void Function()? onPressed;

  const SampleButton({Key? key, required this.text, this.onPressed, this.horizontalPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: horizontalPadding ?? 0),
      onPressed: (){
        onPressed?.call();
        HapticFeedback.heavyImpact();
      },
      child: Text(text, textScaleFactor: 1.0),
    );
  }
}
