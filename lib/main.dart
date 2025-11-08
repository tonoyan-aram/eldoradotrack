import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'constants/app_constants.dart';
import 'models/app_theme.dart';
import 'services/treasure_provider.dart';
import 'services/theme_service.dart';
import 'services/locale_service.dart';
import 'services/appsflyer_service.dart';
import 'l10n/app_localizations.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService().initialize();
  await LocaleService().initialize();
  await AppsflyerService.instance.initialize();
  runApp(const ElDoradoTrackApp());
}

class ElDoradoTrackApp extends StatelessWidget {
  const ElDoradoTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TreasureProvider()..initialize(),
        ),
        ChangeNotifierProvider.value(value: LocaleService()),
        ChangeNotifierProvider.value(value: ThemeService()),
        StreamProvider.value(
          value: ThemeService().themeStream,
          initialData: ThemeService().currentTheme,
        ),
      ],
      child: Consumer3<AppThemeData, LocaleService, ThemeService>(
        builder: (context, theme, localeService, themeService, child) {
          return MaterialApp(
            title: AppConstants.appName,
            theme: themeService.toFlutterTheme(),
            locale: localeService.currentLocale,
            supportedLocales: LocaleService.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
