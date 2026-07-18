/// Tolerant JSON coercion helpers.
///
/// The backend serialises Prisma `Decimal` columns as JSON *strings*
/// ("127.5", "0"), while computed report values arrive as real JSON numbers.
/// The same logical field can therefore be a String on one endpoint and a num
/// on another, so every read goes through these helpers rather than a cast.
library;

/// Any of `num`, `"12.5"`, `null` -> double. Never throws.
double asDouble(Object? value, {double fallback = 0}) {
  if (value == null) return fallback;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value.trim()) ?? fallback;
  return fallback;
}

/// Any of `num`, `"12"`, `"12.7"`, `null` -> int (truncating). Never throws.
int asInt(Object? value, {int fallback = 0}) {
  if (value == null) return fallback;
  if (value is num) return value.toInt();
  if (value is String) {
    final trimmed = value.trim();
    return int.tryParse(trimmed) ?? double.tryParse(trimmed)?.toInt() ?? fallback;
  }
  return fallback;
}

/// Anything -> String. `null` yields [fallback] rather than "null".
String asString(Object? value, {String fallback = ''}) {
  if (value == null) return fallback;
  if (value is String) return value;
  return value.toString();
}

/// Anything -> String?, collapsing empty strings to null.
String? asStringOrNull(Object? value) {
  if (value == null) return null;
  final s = value is String ? value : value.toString();
  return s.trim().isEmpty ? null : s;
}

/// `bool`, `"true"`, `1` -> bool. Never throws.
bool asBool(Object? value, {bool fallback = false}) {
  if (value == null) return fallback;
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final v = value.trim().toLowerCase();
    if (v == 'true' || v == '1') return true;
    if (v == 'false' || v == '0') return false;
  }
  return fallback;
}

/// ISO-8601 string -> DateTime. Falls back to [fallback] (or epoch) on garbage.
DateTime asDate(Object? value, {DateTime? fallback}) {
  if (value is DateTime) return value;
  if (value is String) {
    final parsed = DateTime.tryParse(value);
    if (parsed != null) return parsed.toLocal();
  }
  if (value is num) {
    return DateTime.fromMillisecondsSinceEpoch(value.toInt()).toLocal();
  }
  return fallback ?? DateTime.fromMillisecondsSinceEpoch(0);
}

/// ISO-8601 string -> DateTime?, without inventing a date.
DateTime? asDateOrNull(Object? value) {
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value)?.toLocal();
  return null;
}

/// Safely reads a nested JSON object; returns an empty map when absent or of
/// an unexpected type, so callers can keep chaining without null checks.
Map<String, dynamic> asMap(Object? value) {
  if (value is Map) return Map<String, dynamic>.from(value);
  return const <String, dynamic>{};
}

/// Safely reads a JSON array of objects, skipping any non-object entries.
List<Map<String, dynamic>> asMapList(Object? value) {
  if (value is! List) return const [];
  return value
      .whereType<Map>()
      .map((e) => Map<String, dynamic>.from(e))
      .toList(growable: false);
}

/// Decodes a top-level list response. The API returns bare JSON arrays, but a
/// few deployments wrap them as `{data: [...]}` / `{items: [...]}` — accept both
/// so a wrapper change doesn't crash the app.
List<Map<String, dynamic>> asListResponse(Object? value) {
  if (value is List) return asMapList(value);
  if (value is Map) {
    for (final key in const ['data', 'items', 'results', 'rows']) {
      if (value[key] is List) return asMapList(value[key]);
    }
  }
  return const [];
}
