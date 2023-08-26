import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/ui/home.dart';
import 'package:notes_app/utils/app_urls.dart';

class AddNotes extends StatelessWidget {
  AddNotes({super.key});

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 5,
              controller: bodyController,
              decoration: InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(onPressed: save, child: Text("Save"))
          ],
        ),
      ),
    );
  }

  save() async {
    NotesModel note =
        NotesModel(title: titleController.text, body: bodyController.text);
    final response = await http.post(Uri.parse(AppUrls.getNotesApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(note.toJson()));

    if (response.statusCode == 201) {
      print("Saved Successs");
    }
  }
}
