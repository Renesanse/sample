import "package:bolter_flutter/bolter_flutter.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:sample/features/auth/register/register_presenter.dart";
import "package:sample/widgets/sample_button.dart";
import "../../../main.dart";
import "../birth_date_dialog.dart";
import "../country/country_screen.dart";

typedef TapAction = void Function(TextEditingController controller);

enum fields {
  Email,
  Password,
  Confirm_Password,
  Birth_Date,
  Residence_Country,
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _controllers = {for (final f in fields.values) f: TextEditingController()};

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
                slivers: [
                  const CupertinoSliverNavigationBar(
                    automaticallyImplyLeading: false,
                    border: null,
                    heroTag: "Register",
                    largeTitle: Text("Register"),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 48, left: 6, right: 6),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) {
                          final field = fields.values[index];
                          final currentController = _controllers.values.elementAt(index);
                          return Padding(
                            key: ValueKey(field),
                            padding: const EdgeInsets.all(8.0),
                            child: CupertinoTextField(
                              clearButtonMode: (field == fields.Birth_Date || field == fields.Residence_Country)
                                  ? OverlayVisibilityMode.never
                                  : OverlayVisibilityMode.editing,
                              controller: currentController,
                              placeholder: field.toString().replaceAll("_", " ").replaceAll("fields.", ""),
                              readOnly: field == fields.Birth_Date || field == fields.Residence_Country,
                              onTap: () {
                                _mapTapAction(field, currentController, ctx);
                              },
                              autofocus: index == 0,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (_) {
                                if (field == fields.Confirm_Password) {
                                  _mapTapAction(fields.Birth_Date, _controllers[fields.Birth_Date]!, ctx);
                                }
                              },
                              obscureText: field == fields.Password || field == fields.Confirm_Password,
                            ),
                          );
                        },
                        childCount: fields.values.length,
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
                child: SampleButton(
                  onPressed: () {
                    if (_validate(_controllers[fields.Password]!.text, _controllers[fields.Confirm_Password]!.text)) {
                      context.presenter<RegisterPresenter>().setupRegisterData(
                            email: _controllers[fields.Email]!.text,
                            birthDate: _controllers[fields.Birth_Date]!.text,
                            residence: _controllers[fields.Residence_Country]!.text,
                          );
                      Navigator.of(context).pushNamed(Routes.selfie);
                    }
                  },
                  text: "Next",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _validate(String pass, String confirmPass) {
    var message = "Please, fill all fields";
    message = pass == confirmPass ? message : "Password is not confirmed";
    for (final controller in _controllers.values) {
      if (controller.text.isEmpty) {
        showCupertinoDialog(
            context: context,
            builder: (ctx) => CupertinoAlertDialog(
                  title: const Text("Error"),
                  content: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      message,
                      style: const TextStyle(color: CupertinoColors.destructiveRed),
                    ),
                  ),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      onPressed: Navigator.of(ctx).pop,
                      child: const Text(
                        "Ok",
                        style: TextStyle(color: CupertinoColors.black),
                      ),
                    )
                  ],
                ));
        return false;
      }
    }
    return true;
  }

  Future<void> _mapTapAction(fields field, TextEditingController controller, BuildContext context) async {
    switch (field) {
      case fields.Email:
        break;
      case fields.Password:
        break;
      case fields.Confirm_Password:
        break;
      case fields.Birth_Date:
        final result = await selectBirthDate(context);
        if (result != null) {
          controller.text = "${result.day}/${result.month}/${result.year}";
        } else {
          controller.text = "";
        }
        break;
      case fields.Residence_Country:
        final result = await selectCountry(context);
        controller.text = result ?? "";
        break;
    }
  }
}
