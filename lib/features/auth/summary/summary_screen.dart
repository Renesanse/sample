import "dart:io";
import "package:bolter_flutter/bolter_flutter.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:sample/features/auth/summary/summary_presenter.dart";

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  static const TextStyle _titleStyle = TextStyle(fontSize: 12);
  static const TextStyle _subTitleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final presenter = context.presenter<SummaryPresenter>();
    final imagePath = ModalRoute.of(context)!.settings.arguments! as String;

    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: CupertinoColors.white),
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  const CupertinoSliverNavigationBar(
                    automaticallyImplyLeading: false,
                    border: null,
                    heroTag: "Summary",
                    largeTitle: Text("Summary"),
                  ),
                  SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            foregroundImage: Image.file(
                              File(imagePath),
                              fit: BoxFit.contain,
                            ).image,
                            radius: 80,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                const Text("Email", style: _titleStyle,),
                                Text(presenter.authState.email, style: _subTitleStyle,),
                                const SizedBox(height: 16),
                                const Text("Birth Date", style: _titleStyle,),
                                Text(presenter.authState.birthDate, style: _subTitleStyle,),
                                const SizedBox(height: 16),
                                const Text("Residence", style: _titleStyle,),
                                Text(presenter.authState.residence, style: _subTitleStyle,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  onPressed: () {
                    presenter.register();
                  },
                  child: const Text(
                    "Register",
                    textScaleFactor: 1.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
