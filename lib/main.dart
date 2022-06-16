import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/colorpick_localization.dart';
import 'providers/counter_provider.dart';
import 'providers/name_provider.dart';
import 'colorpick_layout.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user.dart';

late Box box;
late User user;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(UserAdapter());
  await Hive.initFlutter();
  box = await Hive.openBox('box');
  if(!box.containsKey('user')){
    await box.put('user',User(topScore: 0, username: "Guest", darkMode: true, lang: user.lang));
  }
  user = box.get('user');

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
      ChangeNotifierProvider(create: (_) => Name()),
    ],
    child: const MyApp(),
    )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale.fromSubtags(languageCode: user.lang),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('hu', ''),
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => ColorPickLayout(),
      },
    );
  }
}


