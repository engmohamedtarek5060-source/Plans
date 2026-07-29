# ---------------------------------------------------------------------------
# R8 / ProGuard keep rules for the release build.
#
# R8 shrinks and obfuscates the app. These rules stop it from stripping or
# renaming classes that are looked up reflectively at runtime by Flutter and
# its plugins, which would otherwise cause crashes only in release builds.
# ---------------------------------------------------------------------------

# --- Flutter engine ---------------------------------------------------------
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**

# --- flutter_secure_storage (Android Keystore, reflective) ------------------
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# --- image_picker -----------------------------------------------------------
-keep class io.flutter.plugins.imagepicker.** { *; }

# --- Keep annotations and generic signatures (used by (de)serialization) ----
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# --- Silence warnings from optional deps not present at runtime -------------
-dontwarn javax.annotation.**
