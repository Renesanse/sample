import "dart:io";

import "package:flutter/cupertino.dart";
import "package:image_picker/image_picker.dart";

abstract class Utils{
  static final _imagePicker = ImagePicker();
  static Future<File?> askForPhoto(BuildContext context) async {
    final source = await showCupertinoModalPopup<ImageSource>(
      context: context,
      useRootNavigator: true,
      builder: (ctx) => CupertinoActionSheet(
        title: const Text("Select source"),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop(ImageSource.gallery);
            },
            child: const Text("Gallery"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
            child: const Text("Camera"),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          child: const Text("Отмена"),
        ),
      ),
    );
    if (source != null) {
      final image = await _imagePicker.getImage(source: source, preferredCameraDevice: CameraDevice.front);
      if (image != null) {
        return File(image.path);
      }
    }
  }

}
