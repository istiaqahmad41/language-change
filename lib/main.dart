import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/en.dart';
import 'l10n/bn.dart';

void main() {
  runApp(language_change_main());
}

class language_change_main extends StatefulWidget {
  // Static method to set locale dynamically
  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<language_change_main> createState() => _MyAppState();
}

class _MyAppState extends State<language_change_main> {
  Locale _locale = const Locale('en'); // Default locale is English

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localization Example',
      locale: _locale, // Current app locale
      supportedLocales: const [
        Locale('en'), // English
        Locale('bn'), // Bangla
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  // Translation function
  String translate(BuildContext context, String key) {
    Locale currentLocale = Localizations.localeOf(context);
    if (currentLocale.languageCode == 'bn') {
      return Bn.translations[key] ?? key;
    }
    return En.translations[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(context, 'hello_world')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              translate(context, 'welcome'),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Toggle between English and Bangla
                if (Localizations.localeOf(context).languageCode == 'en') {
                  language_change_main.setLocale(context, const Locale('bn'));
                } else {
                  language_change_main.setLocale(context, const Locale('en'));
                }
              },
              child: Text(translate(context, 'change_language')),
            ),
          ],
        ),
      ),
    );
  }
}
