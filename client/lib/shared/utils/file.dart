import 'dart:convert';
import 'dart:io';

import 'package:client/shared/utils/network.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final ImagePicker? imagePicker = ImagePicker();

    final XFile? image = await imagePicker?.pickImage(source: ImageSource.gallery);

    return image != null ? await File(image.path) : null;
  } catch (e) {
    handleError(e: e);
    throw e;
  }
}

String convertImageToBase64(File file) {
  try {
    final bytes = file.readAsBytesSync();

    final encodedImage = base64Encode(bytes);

    return "data:image/png;base64,${encodedImage}";
  } catch (e) {
    handleError(e: e);
    throw e;
  }
}
