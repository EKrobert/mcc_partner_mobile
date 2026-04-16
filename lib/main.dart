import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcc_partners/screens/splash_screen.dart';
import 'package:mcc_partners/theme/mcc_theme.dart';

void main() {
 WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor:               Colors.transparent,
    statusBarIconBrightness:      Brightness.dark,    // icônes sombres sur fond blanc
    systemNavigationBarColor:     Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCC Partners',
      debugShowCheckedModeBanner: false,
      theme: MCCTheme.light,
      home: const SplashScreen(),
    );
  }
}