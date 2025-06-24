# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.embedding.**  { *; }
-keep class io.flutter.embedding.engine.**  { *; }
-keep class io.flutter.embedding.engine.plugins.**  { *; }
-keep class io.flutter.embedding.engine.plugins.shim.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class io.flutter.plugin.common.** { *; }

# Keep program classes that are used in native code
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.Application
-keep public class * extends android.view.View
-keep public class * extends android.app.Fragment
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference

# Dio
-keepclassmembers class retrofit2.Retrofit {
    *;
}
-dontwarn retrofit2.Response
-keepclasseswithmembers class com.google.gson.reflect.TypeToken
-keepattributes Signature
-keep class sun.misc.Unsafe { *; }
-dontwarn com.google.errorprone.annotations.**
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
-keep public class com.google.android.gms.ads.** {
   public *;
}

# For internet connectivity checker
-keep class com.github.pwittchen.reactivenetwork.library.rx2.Connectivity { <fields>; }
-keep class com.github.pwittchen.reactivenetwork.library.rx2.Connectivity$Type { <fields>; }

# Google Play Core
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task 