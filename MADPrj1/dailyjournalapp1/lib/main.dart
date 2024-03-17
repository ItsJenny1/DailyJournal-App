import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(ThemeData.light()), // Initial theme
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          theme: themeProvider.getTheme(),
          home: Scaffold(
            appBar: AppBar(
              title: Text('Theme'),
            ),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Toggle between light and dark themes
                  final currentTheme = themeProvider.getTheme();
                  final newTheme = currentTheme.brightness == Brightness.light
                      ? ThemeData.dark()
                      : ThemeData.light();
                  themeProvider.setTheme(newTheme);
                },
                child: Text('Switch Theme'),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
