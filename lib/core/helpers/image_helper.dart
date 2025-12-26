import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelper {
  ImageHelper._();

  static Future<File?> getImage(bool isCamera) async {
    try {
      final picker = ImagePicker();

      final image = await picker.pickImage(
        source: isCamera ? .camera : .gallery,
        imageQuality: 50,
      );

      if (image != null) {
        final item = File(image.path);
        final fileStat = await item.stat();

        final size = fileStat.size;

        if (size / (1024 * 1024) > 1) {
          final dir = await getTemporaryDirectory();
          XFile result = image;

          while (File(result.path).lengthSync() / (1024 * 1024) > 1) {
            result = await FlutterImageCompress.compressAndGetFile(
                  result.path,
                  '${dir.absolute.path}/compress${DateTime.now().millisecond}.jpg',
                  quality: 50,
                  format: CompressFormat.jpeg,
                ) ??
                result;
          }

          return File(result.path);
        } else {
          return item;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
