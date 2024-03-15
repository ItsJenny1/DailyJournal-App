import 'package:flutter/material.dart';
import 'affirmation_screen.dart';
import 'mood_screen.dart';

class EntryScreen extends StatelessWidget {
  final DateTime selectedDate;

  const EntryScreen({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry for ${_getFormattedDate()}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to AffirmationScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AffirmationScreen(date: selectedDate),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.lightbulb, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Affirmations'),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to MoodScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MoodScreen(selectedDate: selectedDate),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.mood, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Mood'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate() {
    return '${selectedDate.year}-${_addLeadingZero(selectedDate.month)}-${_addLeadingZero(selectedDate.day)}';
  }

  String _addLeadingZero(int value) {
    return value.toString().padLeft(2, '0');
  }
}
