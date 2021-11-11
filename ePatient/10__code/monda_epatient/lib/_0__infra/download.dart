import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class AttachmentUtil {
  static var httpClient = new HttpClient();

  static Future<File> downloadFile(String url, String newFilename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);

    String fileExtension = _generateExtension(response.headers.contentType != null ? response.headers.contentType!.mimeType : '');
    String dir = (await getApplicationDocumentsDirectory()).path;
    String fileNameAndPath = '$dir/$newFilename.$fileExtension';

    File file = new File(fileNameAndPath);

    await file.writeAsBytes(bytes);

    return file;
  }

  static String _generateExtension(String? mimeType) {
    if(mimeType == null || mimeType.length == 0) {
      return '';
    }

    if(mimeType == 'text/plain') {
      return 'txt';
    } else if(mimeType == 'image/png') {
      return 'png';
    } else if(mimeType == 'image/jpeg') {
      return 'jpg';
    } else {
      return '';
    }
  }
}
