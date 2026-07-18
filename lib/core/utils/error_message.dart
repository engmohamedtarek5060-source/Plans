import 'package:saudiaaaa/core/constants/app_strings.dart';
import 'package:saudiaaaa/core/network/api_exception.dart';

/// Turns whatever an `AsyncValue.error` carries into a message worth showing.
///
/// Riverpod hands the error back as `Object`, so the typed [ApiException] has
/// to be recovered here. Anything else falls back to the generic string rather
/// than leaking a stack trace or a Dart type name into the UI.
String describeError(Object error, bool isArabic) {
  if (error is ApiException) return error.localizedMessage(isArabic);
  return AppStrings.errorTitle(isArabic);
}
