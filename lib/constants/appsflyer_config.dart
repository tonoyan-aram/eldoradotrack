class AppsflyerConfig {
  static const String _fallbackDevKey = '2Tbaxm8HrTqQvvYi3k2SjZ';
  static const String _fallbackIosAppId = '6754162117';

  static const String devKey = String.fromEnvironment(
    'APPSFLYER_DEV_KEY',
    defaultValue: _fallbackDevKey,
  );
  static const String appId = String.fromEnvironment(
    'APPSFLYER_APP_ID',
    defaultValue: _fallbackIosAppId,
  );

  static const bool showDebug =
      bool.fromEnvironment('APPSFLYER_DEBUG', defaultValue: false);
  static const int attTimeoutSeconds =
      int.fromEnvironment('APPSFLYER_ATT_TIMEOUT', defaultValue: 0);

  static bool get isConfigured => devKey.isNotEmpty && appId.isNotEmpty;
}

