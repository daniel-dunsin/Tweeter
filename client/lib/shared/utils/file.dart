import 'dart:convert';
import 'dart:io';

import 'package:client/shared/utils/network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

Future<File?> pickImage() async {
  try {
    final ImagePicker? imagePicker = ImagePicker();

    final XFile? image = await imagePicker?.pickImage(source: ImageSource.gallery);

    return image != null ? File(image.path) : null;
  } catch (e) {
    handleError(e: e);
    rethrow;
  }
}

String convertImageToBase64(File file) {
  try {
    final bytes = file.readAsBytesSync();

    final encodedImage = base64Encode(bytes);

    return "data:image/png;base64,$encodedImage";
  } catch (e) {
    handleError(e: e);
    rethrow;
  }
}

File convertBase64ToImage(String base64String) {
  try {
    final decodedString = base64String.split(',').last;

    final bytes = base64Decode(decodedString);

    final file = File.fromRawPath(bytes);

    return file;
  } catch (e) {
    handleError(e: e);
    rethrow;
  }
}

Future<List<File>?> pickMultiMedia({int limit = 4}) async {
  try {
    final ImagePicker? imagePicker = ImagePicker();

    final List<XFile>? media = await imagePicker?.pickMultipleMedia(limit: limit);

    return media?.map((m) => File(m.path)).toList();
  } catch (e) {
    handleError(e: e);
    rethrow;
  }
}
