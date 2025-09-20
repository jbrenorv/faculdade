import 'dart:io';
import 'dart:typed_data';

import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class SaveDataUtil {

  static Future<void> saveData(Uint8List imageBytes, String modeloContent) async {
    try {
      final downloadsDirectory = await getDownloadsDirectory();
      final downloadsPath = downloadsDirectory!.path;
      final folderName = DateTime.now().microsecondsSinceEpoch.toString();
      final directoryPath = path.join(downloadsPath, folderName);
      final directory = await Directory(directoryPath).create(recursive: true);
      final imagePath = path.join(directory.path, 'imagem.png');
      final modelPath = path.join(directory.path, 'modelo.txt');
      await File(imagePath).writeAsBytes(imageBytes);
      await File(modelPath).writeAsString(modeloContent);
      if (await canLaunchUrl(Uri.parse('file://${directory.path}'))) {
        await launchUrl(Uri.parse('file://${directory.path}'));
      }
    } catch (e) {
      // Error
    }
  }
}
