import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:sample/main.dart";
import "package:sample/widgets/sample_button.dart";

class LeadingScreen extends StatelessWidget {
  const LeadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: Image.asset(
                        "assets/images/background.jpg",
                      ).image,
                    )),
                  ),
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: const BoxDecoration(color: CupertinoColors.white),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: SampleButton(
                      text: "Register",
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.register);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: SampleButton(
                      text: "Login",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
