import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

/// Here are some useful methods for image blur hash and data uri processing
class FUIUtil {
  /// To obtain a blur hash with ImageProvider
  static Future<BlurHash> obtainBlurHashWithImageProvider(
    ImageProvider imgProvider, {
    int compX = 4,
    int compY = 3,
  }) async {
    Uint8List imgData = await convertImgProviderToUint8List(imgProvider);

    return BlurHash.encode(img.decodeImage(imgData)!, numCompX: compX, numCompY: compY);
  }

  /// To obtain a blur hash with dataUri (e.g. data:image/png;base64,BASE64_STRING...)
  static Future<BlurHash> obtainBlurHashWithDataUri(
    String dataUri, {
    int compX = 4,
    int compY = 3,
  }) async {
    Uint8List imgData = convertDataUriToUint8List(dataUri);

    return BlurHash.encode(img.decodeImage(imgData)!, numCompX: compX, numCompY: compY);
  }

  /// Convert the data uri to Dart's Uint8List
  static Uint8List convertDataUriToUint8List(String dataUri) {
    // Check if the Data URI is valid
    if (!dataUri.startsWith('data:')) {
      throw Exception('Invalid Data URI');
    }

    // Find the comma separating the metadata and base64 data
    int commaIndex = dataUri.indexOf(',');
    if (commaIndex == -1) {
      throw Exception('Invalid Data URI format');
    }

    // Extract the base64-encoded part
    String base64String = dataUri.substring(commaIndex + 1);

    // Decode the base64 string to Uint8List
    try {
      return base64Decode(base64String);
    } catch (e) {
      throw Exception('Error decoding base64: $e');
    }
  }

  static Future<Uint8List> convertImgProviderToUint8List(ImageProvider imgProvider) async {
    // Resolve the ImageProvider to an ImageStream
    final ImageStream stream = imgProvider.resolve(ImageConfiguration());
    final completer = Completer<ui.Image>();

    // Listen to the ImageStream to get the ui.Image
    late ImageStreamListener listener;

    listener = ImageStreamListener(
      (ImageInfo info, bool synchronousCall) {
        completer.complete(info.image);
        stream.removeListener(listener);
      },
      onError: (exception, stackTrace) {
        completer.completeError(exception, stackTrace);
        stream.removeListener(listener);
      },
    );

    stream.addListener(listener);

    // Wait for the ui.Image to be available
    final ui.Image image = await completer.future;

    // Convert the ui.Image to bytes
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }
}
