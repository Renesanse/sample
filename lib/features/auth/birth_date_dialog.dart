import "package:flutter/cupertino.dart";
import "package:sample/widgets/sample_button.dart";

Future<DateTime?> selectBirthDate(BuildContext context) async {
  return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (ctx) {
        DateTime? time;
        return DecoratedBox(
          decoration: const BoxDecoration(color: CupertinoColors.white),
          child: SizedBox(
            height: MediaQuery.of(ctx).size.height / 2,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    minimumYear: 1900,
                    maximumYear: DateTime.now().year - 18,
                    initialDateTime: DateTime.now().subtract(const Duration(days: 6574)),
                    onDateTimeChanged: (date) {
                      time = date;
                    },
                    mode: CupertinoDatePickerMode.date,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 24,
                      left: 16,
                      right: 16,
                    ),
                    child: SampleButton(
                      text: "Confirm",
                      onPressed: () {
                        Navigator.of(ctx).pop(time);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
