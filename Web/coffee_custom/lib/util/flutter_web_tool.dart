import 'dart:convert';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'dart:typed_data';

//Flutter web File转 Uint8List
Future<Uint8List> fileToUint8List(File blob) async {
  Uint8List file;
  final reader = FileReader();
  reader.readAsDataUrl(blob.slice(0, blob.size, blob.type));
  reader.onLoadEnd.listen((event) {
    Uint8List data =
        Base64Decoder().convert(reader.result.toString().split(",").last);
    file = data;
  }).onData((data) {
    file = Base64Decoder().convert(reader.result.toString().split(",").last);
    return file;
  });
  while (file == null) {
    await new Future.delayed(const Duration(milliseconds: 1));
    if (file != null) {
      break;
    }
  }
  return file;
}

void notification(String text) {
  js.context.callMethod("showNotification", [text]);
}

void alert(String text) {
  js.context.callMethod("alert", [text]);
}
