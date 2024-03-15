import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'home_screen.dart';

late Database database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool doesExist = prefs.containsKey('VariableName');
  String? myVariable = prefs.getString('variableName');
  prefs.setString('variableName', 'newValue');

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

  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(), // Display HomeScreen as the initial screen
    );
  }
}
void createTable(String tableName) async {
  final db = await database;
  await db.execute(
    'CREATE TABLE IF NOT EXISTS $tableName(date TEXT, affirmation TEXT, imagePath TEXT)',
  );
}

