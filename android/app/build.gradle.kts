plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.doradotrack.nuno"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.doradotrack.nuno"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        val resolvedAppsFlyerDevKey =
            (project.findProperty("APPSFLYER_DEV_KEY") as? String
                ?: System.getenv("APPSFLYER_DEV_KEY")
                ?: "2Tbaxm8HrTqQvvYi3k2SjZ")

        val rawAppsFlyerAppId =
            (project.findProperty("APPSFLYER_APP_ID") as? String
                ?: System.getenv("APPSFLYER_APP_ID")
                ?: "6754162117")

        val appsFlyerAndroidAppId =
            if (rawAppsFlyerAppId.startsWith("id")) rawAppsFlyerAppId else "id$rawAppsFlyerAppId"

        manifestPlaceholders.putAll(
            mapOf(
                "appsFlyerDevKey" to resolvedAppsFlyerDevKey,
                "appsFlyerAppId" to appsFlyerAndroidAppId
            )
        )
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
