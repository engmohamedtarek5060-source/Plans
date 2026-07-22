import 'dart:io';

import 'package:dio/dio.dart';
import 'package:saudiaaaa/core/utils/json_parse.dart';

/// What went wrong, in terms the UI can branch on.
enum ApiErrorKind {
  noInternet,
  timeout,
  unauthorized,
  forbidden,
  notFound,

  /// The request clashed with existing state — on `/auth/register`, an email
  /// that is already taken. Distinct from [validation]: the payload was
  /// well-formed, the server just cannot accept it.
  conflict,
  validation,
  server,
  badResponse,
  cancelled,
  unknown,
}

/// A single, typed failure for every network call.
///
/// Built from the backend's uniform error envelope:
/// `{statusCode, code, message, path, timestamp, errors?: string[]}`
class ApiException implements Exception {
  const ApiException({
    required this.kind,
    required this.message,
    this.messageAr,
    this.statusCode,
    this.code,
    this.fieldErrors = const [],
  });

  final ApiErrorKind kind;

  /// English, user-facing.
  final String message;

  /// Arabic, user-facing. Falls back to [message] when absent.
  final String? messageAr;

  final int? statusCode;

  /// Backend error code, e.g. `VALIDATION_ERROR`, `UNAUTHORIZED`.
  final String? code;

  /// Per-field validation messages, when the backend supplies them.
  final List<String> fieldErrors;

  bool get isUnauthorized => kind == ApiErrorKind.unauthorized;

  /// The message to show the user, in their language.
  String localizedMessage(bool isArabic) =>
      isArabic ? (messageAr ?? message) : message;

  @override
  String toString() => 'ApiException($kind, $statusCode, $code): $message';

  /// Translates any Dio failure into a typed, user-presentable error.
  factory ApiException.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const ApiException(
          kind: ApiErrorKind.timeout,
          message: 'The server took too long to respond. Please try again.',
          messageAr: 'استغرق الخادم وقتًا طويلاً للرد. يرجى المحاولة مرة أخرى.',
        );

      case DioExceptionType.connectionError:
        return const ApiException(
          kind: ApiErrorKind.noInternet,
          message: 'No internet connection. Check your network and try again.',
          messageAr: 'لا يوجد اتصال بالإنترنت. تحقق من شبكتك وحاول مرة أخرى.',
        );

      case DioExceptionType.cancel:
        return const ApiException(
          kind: ApiErrorKind.cancelled,
          message: 'Request cancelled.',
          messageAr: 'تم إلغاء الطلب.',
        );

      case DioExceptionType.badCertificate:
        return const ApiException(
          kind: ApiErrorKind.badResponse,
          message: 'Could not establish a secure connection to the server.',
          messageAr: 'تعذر إنشاء اتصال آمن بالخادم.',
        );

      case DioExceptionType.badResponse:
        return ApiException._fromResponse(e.response);

      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return const ApiException(
            kind: ApiErrorKind.noInternet,
            message:
                'No internet connection. Check your network and try again.',
            messageAr: 'لا يوجد اتصال بالإنترنت. تحقق من شبكتك وحاول مرة أخرى.',
          );
        }
        return const ApiException(
          kind: ApiErrorKind.unknown,
          message: 'Something went wrong. Please try again.',
          messageAr: 'حدث خطأ ما. يرجى المحاولة مرة أخرى.',
        );
    }
  }

  /// Maps an HTTP error response onto a typed failure.
  factory ApiException._fromResponse(Response<dynamic>? response) {
    final status = response?.statusCode ?? 0;
    final body = asMap(response?.data);
    final code = asStringOrNull(body['code']);
    final serverMessage = asStringOrNull(body['message']);
    final fieldErrors = (body['errors'] is List)
        ? (body['errors'] as List).map((e) => e.toString()).toList()
        : const <String>[];

    if (status == 401) {
      return ApiException(
        kind: ApiErrorKind.unauthorized,
        message: serverMessage ?? 'Your session has expired. Please log in again.',
        messageAr: 'انتهت جلستك. يرجى تسجيل الدخول مرة أخرى.',
        statusCode: status,
        code: code,
      );
    }

    if (status == 403) {
      return ApiException(
        kind: ApiErrorKind.forbidden,
        message: serverMessage ?? 'You do not have permission to do that.',
        messageAr: 'ليس لديك صلاحية للقيام بذلك.',
        statusCode: status,
        code: code,
      );
    }

    if (status == 404) {
      return ApiException(
        kind: ApiErrorKind.notFound,
        message: serverMessage ?? 'The requested data was not found.',
        messageAr: 'لم يتم العثور على البيانات المطلوبة.',
        statusCode: status,
        code: code,
      );
    }

    if (status == 409) {
      // The backend's message is the actionable one ("Email already
      // registered") and it ships English-only, so the Arabic side is ours.
      return ApiException(
        kind: ApiErrorKind.conflict,
        message: serverMessage ?? 'That already exists.',
        messageAr: 'هذا مسجل بالفعل.',
        statusCode: status,
        code: code,
      );
    }

    if (status == 400 || status == 422) {
      // Prefer the first field error: it is the actionable one.
      final detail =
          fieldErrors.isNotEmpty ? fieldErrors.first : serverMessage;
      return ApiException(
        kind: ApiErrorKind.validation,
        message: detail ?? 'Some of the submitted data is invalid.',
        messageAr: detail ?? 'بعض البيانات المُدخلة غير صحيحة.',
        statusCode: status,
        code: code,
        fieldErrors: fieldErrors,
      );
    }

    if (status == 429) {
      return ApiException(
        kind: ApiErrorKind.server,
        message: serverMessage ?? 'Too many attempts. Please wait and retry.',
        messageAr: 'محاولات كثيرة جدًا. يرجى الانتظار ثم إعادة المحاولة.',
        statusCode: status,
        code: code,
      );
    }

    if (status >= 500) {
      return ApiException(
        kind: ApiErrorKind.server,
        message: 'The server is having trouble. Please try again shortly.',
        messageAr: 'يواجه الخادم مشكلة. يرجى المحاولة بعد قليل.',
        statusCode: status,
        code: code,
      );
    }

    return ApiException(
      kind: ApiErrorKind.unknown,
      message: serverMessage ?? 'Something went wrong. Please try again.',
      messageAr: 'حدث خطأ ما. يرجى المحاولة مرة أخرى.',
      statusCode: status,
      code: code,
    );
  }

  /// The response parsed, but not in the shape we expected.
  factory ApiException.malformed(String detail) => ApiException(
        kind: ApiErrorKind.badResponse,
        message: 'Received an unexpected response from the server.',
        messageAr: 'تم استلام رد غير متوقع من الخادم.',
        code: 'MALFORMED_RESPONSE',
        fieldErrors: [detail],
      );
}
