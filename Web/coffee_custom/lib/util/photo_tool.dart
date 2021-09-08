// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';

import 'package:coffee_custom/pojo/result.dart';
import 'package:dio/dio.dart';
import 'package:image_picker_web_redux/image_picker_web_redux.dart';

import 'dio_app.dart';
import 'flutter_web_tool.dart';

class ImageInformation {
  final File file;
  final Uint8List fileBytes;

  ImageInformation(this.file, this.fileBytes);
}

Future<File> pickImageFile() async {
  File fileImage = await ImagePickerWeb.getImage(outputType: ImageType.file);
  return fileImage;
}

Future<Result<String>> uploadImage(file) async {
  FormData formData = FormData.fromMap({
    "file": MultipartFile.fromBytes(await fileToUint8List(file),
        filename: file.name)
  });
  Response response = await appDio.post("/upload", data: formData);
  Result<String> result = Result<String>.fromJson(response.data, (r) => r);
  return result;
}
