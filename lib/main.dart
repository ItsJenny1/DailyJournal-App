import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'auth_provider.dart';
import 'theme_provider.dart'; // Import ThemeProvider from the separate file
import 'sign_up_screen.dart'; // Import SignUpScreen from the separate file
import 'home_screen.dart';

late Database database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  database = await openDatabase(
    join(await getDatabasesPath(), 'databaseName.db'),
    onCreate: (db, version) {
      // Create AffirmationTable
      createTable('AffirmationTable');

      // Create MoodTable
      return db.execute(
        'CREATE TABLE TableName(name TEXT, age INTEGER, address TEXT)',
      );
    },
    version: 1,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(ThemeData.light())),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

void createTable(String tableName) async {
  final db = await database;
  await db.execute(
    'CREATE TABLE IF NOT EXISTS $tableName(date TEXT, affirmation TEXT, imagePath TEXT)',
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          theme: themeProvider.getTheme(),
          home: Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              if (authProvider.isLoggedIn) {
                // If authenticated, navigate to HomeScreen
                return HomeScreen();
              } else {
                // If not authenticated, navigate to SignUpScreen
                return SignUpScreen();
              }
            },
          ),
        );
      },
    );
  }
}
