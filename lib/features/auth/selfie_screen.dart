import "dart:io";
import "package:flutter/cupertino.dart";
import "package:sample/main.dart";
import "../utils.dart";

class SelfieScreen extends StatefulWidget {
  const SelfieScreen({Key? key}) : super(key: key);

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _askForSelfieDelayed(context);
  }

  void _askForSelfieDelayed(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Utils.askForPhoto(context).then((value) {
          if (value != null && mounted) {
            setState(() {
              _imageFile = value;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    heroTag: "Selfie",
                    largeTitle: Text("Make a Selfie"),
                  ),
                  SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          Utils.askForPhoto(context).then((value) {
                            if (value != null && mounted) {
                              setState(() {
                                _imageFile = value;
                              });
                            }
                          });
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: _imageFile == null
                                    ? Image.asset(
                                        "assets/images/background.jpg",
                                      ).image
                                    : Image.file(
                                        _imageFile!,
                                        fit: BoxFit.contain,
                                      ).image,
                              )),
                        ),
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
                    if (_imageFile == null) {
                      showCupertinoDialog(
                          context: context,
                          builder: (ctx) => CupertinoAlertDialog(
                                title: const Text("Error"),
                                content: const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Please, make a selfie",
                                    style: TextStyle(color: CupertinoColors.destructiveRed),
                                  ),
                                ),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      _askForSelfieDelayed(context);
                                    },
                                    child: const Text(
                                      "Ok",
                                      style: TextStyle(color: CupertinoColors.black),
                                    ),
                                  )
                                ],
                              ));
                      return;
                    }
                    Navigator.of(context).pushNamed(Routes.summary, arguments: _imageFile!.path);
                  },
                  child: const Text(
                    "Next",
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
