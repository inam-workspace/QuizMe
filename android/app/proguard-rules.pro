# Flutter-specific rules
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep annotations
-keep @interface androidx.annotation.Keep

# Keep Firebase or other libraries if used
-keep class com.google.** { *; }
-keep class com.firebase.** { *; }

# Don't strip generic information
-keepattributes Signature, *Annotation*
