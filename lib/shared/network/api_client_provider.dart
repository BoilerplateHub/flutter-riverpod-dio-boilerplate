import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/foundation.dart';
import 'interceptors/retry_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'interceptors/dio_connectivity_request_retrier.dart';

import '../../flavors/env_config.dart';
import '../../flavors/build_config.dart';
import '../../translations/locale_keys.g.dart';
import '../../app/model/error/error_response.dart';
import '../../app/model/common/common_response.dart';
import '../../shared/network/api_response/api_response.dart';
import '../../shared/network/interceptors/dio_interceptor_wrapper.dart';

final apiClientProvider = Provider<ApiClientProvider>((ref) {
  return ApiClientProvider(ref.read);
});

class ApiClientProvider {
  late Dio _dio;
  late String _baseUrl;
  final Reader _reader;

  ApiClientProvider(this._reader) {
    final EnvConfig _envConfig = BuildConfig.instance.config;
    _baseUrl = _envConfig.baseUrl;

    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    _dio.options.sendTimeout = 30000;
    _dio.options.connectTimeout = 30000;
    _dio.options.receiveTimeout = 30000;

    _dio.interceptors.clear();
    _dio.interceptors.add(DioInterceptorWrapper(
      _dio,
      _reader,
      _baseUrl,
    ));

    _dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          _dio,
          _reader,
        ),
      ),
    );

    _dio.httpClientAdapter = DefaultHttpClientAdapter();

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(requestBody: true));
    }
  }

  Future<ApiResponse> postRequest(
    String path,
    Map<String, dynamic>? request, {
    String? newBaseUrl,
    Map<String, String?>? query,
    bool checkStatusCodeOnly = false,
  }) async {
    try {
      final apiResponse = await _dio.post(_getFullUrl(path, newBaseUrl),
          data: request, queryParameters: query);
      final responseData = apiResponse.data;

      if (responseData is Map<String, dynamic> || responseData is List) {
        if (checkStatusCodeOnly) {
          return ApiResponse.success(responseData);
        } else {
          if (responseData['success'] == true) {
            return ApiResponse.success(responseData);
          } else {
            return ApiResponse.error(responseData['message']);
          }
        }
      } else {
        return ApiResponse.error(_getErrorMessage(apiResponse));
      }
    } on DioError catch (e) {
      return ApiResponse.error(_getDioErrorResponse(e));
    } on FormatException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> putRequest(
    String path,
    Map<String, dynamic>? request, {
    String? newBaseUrl,
    Map<String, String?>? query,
    bool checkStatusCodeOnly = false,
  }) async {
    try {
      final apiResponse = await _dio.put(
        _getFullUrl(path, newBaseUrl),
        data: request,
        queryParameters: query,
      );
      final responseData = apiResponse.data;

      if (responseData is Map<String, dynamic> || responseData is List) {
        if (checkStatusCodeOnly) {
          return ApiResponse.success(responseData);
        } else {
          if (responseData['success'] == true) {
            return ApiResponse.success(responseData);
          } else {
            return ApiResponse.error(responseData['message']);
          }
        }
      } else {
        return ApiResponse.error(_getErrorMessage(apiResponse));
      }
    } on DioError catch (e) {
      return ApiResponse.error(_getDioErrorResponse(e));
    } on FormatException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> deleteRequest(
    String path, {
    String? newBaseUrl,
    Map<String, String?>? query,
    bool checkStatusCodeOnly = false,
  }) async {
    try {
      final apiResponse = await _dio.delete(
        _getFullUrl(path, newBaseUrl),
        queryParameters: query,
      );
      final responseData = apiResponse.data;

      if (responseData is Map<String, dynamic> || responseData is List) {
        if (checkStatusCodeOnly) {
          return ApiResponse.success(responseData);
        } else {
          if (responseData['success'] == true) {
            return ApiResponse.success(responseData);
          } else {
            return ApiResponse.error(responseData['message']);
          }
        }
      } else {
        return ApiResponse.error(_getErrorMessage(apiResponse));
      }
    } on DioError catch (e) {
      return ApiResponse.error(_getDioErrorResponse(e));
    } on FormatException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> getRequest(
    String path, {
    String? newBaseUrl,
    Map<String, String?>? query,
    bool checkStatusCodeOnly = false,
  }) async {
    try {
      final apiResponse = await _dio.get(
        _getFullUrl(path, newBaseUrl),
        queryParameters: query,
      );
      var responseData = apiResponse.data;

      if (responseData is Map<String, dynamic> || responseData is List) {
        if (checkStatusCodeOnly) {
          return ApiResponse.success(responseData);
        } else {
          if (responseData['success'] == true) {
            return ApiResponse.success(responseData);
          } else {
            return ApiResponse.error(responseData['message']);
          }
        }
      } else {
        return ApiResponse.error(_getErrorMessage(apiResponse));
      }
    } on DioError catch (e) {
      return ApiResponse.error(_getDioErrorResponse(e));
    } on FormatException catch (e) {
      return ApiResponse.error(e.toString());
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  String _getFullUrl(String path, String? newBaseUrl) {
    String url = _baseUrl + path;

    if (newBaseUrl != null) {
      url = newBaseUrl + path;
    }

    return url;
  }

  String _getErrorMessage(Response<dynamic> apiResponse) {
    var responseData = apiResponse.data;

    if (responseData != null && responseData != "") {
      String errorText = LocaleKeys.something_went_wrong.tr();
      var errors = "${apiResponse.data}".split("\n");

      for (int i = 0; i < errors.length; i++) {
        if (i < 12) errorText += errors[i];
      }

      return errorText;
    } else {
      return apiResponse.statusMessage ?? LocaleKeys.something_went_wrong.tr();
    }
  }

  String _getDioErrorResponse(DioError e) {
    final response = e.response;
    final statusCode = response?.statusCode;

    if (response?.data != null) {
      try {
        if (statusCode != null && statusCode == 401 ||
            statusCode == 403 ||
            statusCode! >= 500) {
          if (statusCode! >= 500) {
            return "Internal Server Error: $statusCode";
          } else {
            ErrorResponse errorResponse =
                ErrorResponse.fromJson(response?.data);
            final message = errorResponse.message;
            var errorMessage = message != null && message.isNotEmpty
                ? message
                : errorResponse.error;

            return errorMessage ?? LocaleKeys.something_went_wrong.tr();
          }
        } else {
          CommonResponse commonResponse =
              CommonResponse.fromJson(response?.data);
          return commonResponse.message ?? LocaleKeys.something_went_wrong.tr();
        }
      } catch (e) {
        return e.toString();
      }
    } else {
      return e.message;
    }
  }
}
