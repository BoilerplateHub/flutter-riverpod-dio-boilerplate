import 'dart:async';

import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/provider/core_providers.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Reader _reader;

  DioConnectivityRequestRetrier(
    this.dio,
    this._reader
  );

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    final connectivity = _reader(connectivityProvider);
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();

          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                  method: requestOptions.method,
                  sendTimeout: requestOptions.sendTimeout,
                  receiveTimeout: requestOptions.receiveTimeout,
                  extra: requestOptions.extra,
                  headers: requestOptions.headers,
                  responseType: requestOptions.responseType,
                  contentType: requestOptions.contentType,
                  validateStatus: requestOptions.validateStatus,
                  receiveDataWhenStatusError:
                      requestOptions.receiveDataWhenStatusError,
                  followRedirects: requestOptions.followRedirects,
                  maxRedirects: requestOptions.maxRedirects,
                  requestEncoder: requestOptions.requestEncoder,
                  responseDecoder: requestOptions.responseDecoder,
                  listFormat: requestOptions.listFormat),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
