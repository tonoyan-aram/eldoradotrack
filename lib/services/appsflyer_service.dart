import 'dart:async';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';

import '../constants/appsflyer_config.dart';

class AppsflyerService {
  AppsflyerService._();

  static final AppsflyerService instance = AppsflyerService._();

  AppsflyerSdk? _sdk;
  bool _isInitializing = false;

  Future<void> initialize() async {
    if (!AppsflyerConfig.isConfigured || _sdk != null || _isInitializing) {
      return;
    }

    _isInitializing = true;

    final options = AppsFlyerOptions(
      afDevKey: AppsflyerConfig.devKey,
      appId: AppsflyerConfig.appId,
      showDebug: AppsflyerConfig.showDebug,
      timeToWaitForATTUserAuthorization:
          AppsflyerConfig.attTimeoutSeconds > 0
              ? AppsflyerConfig.attTimeoutSeconds.toDouble()
              : null,
    );

    final appsflyerSdk = AppsflyerSdk(options);

    try {
      await appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      );
      _sdk = appsflyerSdk;
      appsflyerSdk.startSDK();
    } catch (error, stackTrace) {
      Zone.current.handleUncaughtError(error, stackTrace);
    } finally {
      _isInitializing = false;
    }
  }

  AppsflyerSdk? get sdk => _sdk;

  Future<void> logEvent(String name, Map<String, dynamic> values) async {
    final currentSdk = _sdk;
    if (currentSdk == null) {
      return;
    }
    await currentSdk.logEvent(name, values);
  }
}

