import 'dart:convert';
import 'dart:io';

Future<List<String>> readFile(String path) async {
  List<String> fileString = [];
  final File file = File(path);

  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.

  try {
    await for (String line in lines) {
      fileString.add(line);
    }
  } catch (e) {
    print('Error: $e');
  }

  return fileString;
}
