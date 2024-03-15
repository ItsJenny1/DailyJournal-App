import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AffirmationScreen extends StatefulWidget {
  final DateTime date;

  const AffirmationScreen({Key? key, required this.date}) : super(key: key);

  @override
  _AffirmationScreenState createState() => _AffirmationScreenState();
}

class _AffirmationScreenState extends State<AffirmationScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  File? _image;
  String? _savedText;

  @override
  void initState() {
    super.initState();
    _loadSavedAffirmation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Affirmation for ${_getFormattedDate()}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Write about your day on ${_getFormattedDate()}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _textEditingController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Write your affirmation here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Add Images'),
            ),
            SizedBox(height: 20),
            _image != null ? Image.file(_image!) : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAffirmation,
              child: Text('Save'),
            ),
            SizedBox(height: 20),
            _savedText != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Previously Saved Text:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(_savedText!),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate() {
    return '${widget.date.year}-${_addLeadingZero(widget.date.month)}-${_addLeadingZero(widget.date.day)}';
  }

  String _addLeadingZero(int value) {
    return value.toString().padLeft(2, '0');
  }

  void _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _saveAffirmation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'affirmation_text_${_getFormattedDate()}', _textEditingController.text);
    if (_image != null) {
      prefs.setString('affirmation_image_${_getFormattedDate()}', _image!.path);
    }
    setState(() {
      _savedText = _textEditingController.text;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Affirmation saved')));
  }

  void _loadSavedAffirmation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedText =
        prefs.getString('affirmation_text_${_getFormattedDate()}');
    setState(() {
      _savedText = savedText;
      if (savedText != null) {
        _textEditingController.text =
            savedText; // Prepopulate TextField with saved text
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}

