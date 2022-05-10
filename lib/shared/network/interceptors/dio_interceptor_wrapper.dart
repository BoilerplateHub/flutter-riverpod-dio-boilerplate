import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../app/values/constants.dart';
import '../../../shared/utils/extensions.dart';
import '../../../app/values/api_endpoints.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../app/provider/core_providers.dart';
import '../../../features/auth/model/login/login_response.dart';

class DioInterceptorWrapper extends InterceptorsWrapper {
  DioInterceptorWrapper(
    this._dio,
    this._reader,
    this.baseUrl,
  );

  final Dio _dio;
  final Reader _reader;
  final String baseUrl;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final connectivityResult =  await _reader(connectivityProvider).checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return handler.reject(
          DioError(
              requestOptions: options,
              error: LocaleKeys.internet_connectivity_problem.tr()),
          true,
        );
      }

      final preferenceManager = _reader(preferenceManagerProvider);

      if (isJwtTokenNeeded(options.path)) {
        var token = await preferenceManager.getString(keyJwtToken);
        options.headers.addAll({
          "Authorization": "Bearer $token",
        });
      }
    } catch (e) {
      return handler.reject(
          DioError(requestOptions: options, error: "Error: ${e.toString()}"),
          true);
    }

    options.headers.addAll({"Content-type": "application/json"});
    return handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    var errorResponse = err.response;
    RequestOptions? requestOptions = errorResponse?.requestOptions;

    if (errorResponse?.statusCode == 403) {
      _dio.interceptors.requestLock.lock();
      _dio.interceptors.responseLock.lock();

      try {
        var newDio = Dio();

        if (kDebugMode) {
          _dio.interceptors.add(PrettyDioLogger(requestBody: true));
        }

        final preferenceManager = _reader(preferenceManagerProvider);

        var refreshToken = await preferenceManager.getString(
          keyRefreshToken,
        );
        var refreshRequest = {"refreshTokenId": refreshToken};
        var refreshResponse =
            await newDio.post(baseUrl + refreshEndpoint, data: refreshRequest);

        if (refreshResponse.statusCode == 200 && requestOptions?.path != null) {
          LoginResponse response = LoginResponse.fromJson(refreshResponse.data);

          if (response.success == true && response.payload != null) {
            await preferenceManager.setString(
                keyJwtToken, "${response.payload?.accessToken}");
            await preferenceManager.setString(
                keyRefreshToken, "${response.payload?.refreshToken}");

            _dio.interceptors.requestLock.unlock();
            _dio.interceptors.responseLock.unlock();

            var request = await _dio.request(
              requestOptions!.path,
              options: requestOptions.asOptions(),
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
            );

            return handler.resolve(request);
          } else {
            var jwt = await preferenceManager.getString(keyJwtToken);
            if (jwt != null) {
              await logout();
            }

            return handler.next(err);
          }
        }
      } catch (e) {
        await logout();
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  bool isJwtTokenNeeded(String path) {
    if (path.contains(loginEndpoint) ||
        path.contains(signUpEndpoint) ||
        path.contains(refreshEndpoint) ||
        path.contains(privacyPolicyEndpoint) ||
        path.contains(termsConditionsEndpoint) ||
        path.contains(forgetPasswordEndpoint) ||
        path.contains(forgetPasswordChangeEndpoint) ||
        path.contains(forgetPasswordVerifyEndpoint)) {
      return false;
    }

    return true;
  }
}
