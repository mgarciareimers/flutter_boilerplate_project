import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

// Bloc.
import 'package:flutter_boilerplate_project/src/bloc/bloc_provider.dart';

// Preferences.
import 'package:flutter_boilerplate_project/src/preferences/preferences.dart';

// Constants.
import 'package:flutter_boilerplate_project/src/commons/constants/strings.dart';

// Utils.
import 'package:flutter_boilerplate_project/src/commons/utils/app_localizations.dart';
import 'package:flutter_boilerplate_project/src/commons/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = Preferences();
  await preferences.initPreferences();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: Strings.appName,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        initialRoute: Routes.home,
        routes: Routes.getRoutes(),

        // Supported local languages.
        supportedLocales: [
          // AppLocalizations.getLocaleByLanguageCode(AppLocalizations.englishCode),
          AppLocalizations.getLocaleByLanguageCode(AppLocalizations.spanishCode),
        ],

        // Make sure that the localization data for the proper language is loaded.
        localizationsDelegates: [
          AppLocalizations.delegate, // A class which loads the translations from JSON files.
          GlobalMaterialLocalizations.delegate, // Built-in localization of basic text for Material widgets.
          GlobalCupertinoLocalizations.delegate, // Built-in localization of basic text for Cupertino widgets.
          GlobalWidgetsLocalizations.delegate, // Built-in localization for text direction LTR/RTL.
        ],

        // Returns a locale which will be used by the app.
        localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode && supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }

          return supportedLocales.first;
        },
      ),
    );
  }
}