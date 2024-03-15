import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodScreen extends StatefulWidget {
  final DateTime selectedDate;

  const MoodScreen({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _MoodScreenState createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  List<String> moods = ['Happy', 'Sad', 'Excited', 'Angry', 'Calm'];
  late List<bool> selectedMoods;
  late List<bool> savedMoods;

  @override
  void initState() {
    super.initState();
    _loadSavedMoods();
    selectedMoods = List.filled(moods.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Mood for ${_getFormattedDate()}'),
      ),
      body: ListView.builder(
        itemCount: moods.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(moods[index]),
            value: selectedMoods[index],
            onChanged: (value) {
              setState(() {
                selectedMoods[index] = value!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveMoodSelection,
        child: Icon(Icons.save),
      ),
    );
  }

  String _getFormattedDate() {
    return '${widget.selectedDate.year}-${_addLeadingZero(widget.selectedDate.month)}-${_addLeadingZero(widget.selectedDate.day)}';
  }

  String _addLeadingZero(int value) {
    return value.toString().padLeft(2, '0');
  }

  void _saveMoodSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String moodSelectionString =
        selectedMoods.map((selected) => selected ? '1' : '0').join();
    await prefs.setString(
        'moodSelection_${_getFormattedDate()}', moodSelectionString);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Mood selection saved')));
  }

  void _loadSavedMoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? moodSelectionString =
        prefs.getString('moodSelection_${_getFormattedDate()}');
    if (moodSelectionString != null &&
        moodSelectionString.length == moods.length) {
      setState(() {
        selectedMoods =
            moodSelectionString.split('').map((digit) => digit == '1').toList();
      });
    }
  }
}
