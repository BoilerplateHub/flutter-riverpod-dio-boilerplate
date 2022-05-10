import 'dart:core';

import 'package:dio/dio.dart';

extension CapitalizeString on String {
  get allWordsCapitalize {
    return toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }
}

extension BlankCheck on List<dynamic>? {
  get isBlank {
    if (this != null) {
      for (var arg in this!) {
        if (arg == null) {
          return true;
        } else if (arg is String && arg.trim().isEmpty) {
          return true;
        }
      }
    }

    return false;
  }
}

extension AsOptions on RequestOptions {
  Options asOptions() {
    return Options(
      method: method,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      extra: extra,
      headers: headers,
      responseType: responseType,
      contentType: contentType,
      validateStatus: validateStatus,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
      followRedirects: followRedirects,
      maxRedirects: maxRedirects,
      requestEncoder: requestEncoder,
      responseDecoder: responseDecoder,
      listFormat: listFormat,
    );
  }
}
