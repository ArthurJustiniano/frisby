import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/grade_settings_model.dart';
import 'models/theme_settings_model.dart';
import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeSettingsModel()),
        ChangeNotifierProvider(create: (_) => GradeSettingsModel()),
      ],
      child: const FrisbyApp(),
    ),
  );
}

class FrisbyApp extends StatelessWidget {
  const FrisbyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeSettingsModel>(context);

    return MaterialApp(
      title: 'Frisby Médias',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModel.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const WelcomeScreen(),
    );
  }
}
