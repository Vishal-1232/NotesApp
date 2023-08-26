import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:http/http.dart' as http;

class UpdateNote extends StatefulWidget {
  final NotesModel note;

  const UpdateNote({Key? key, required this.note}) : super(key: key);

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.note.title.toString();
    bodyController.text = widget.note.body.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Note")),
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
            TextButton(onPressed: update, child: Text("Save"))
          ],
        ),
      ),
    );
  }

  update() async {
    NotesModel updatedNote = widget.note;
    updatedNote.title = titleController.text;
    updatedNote.body = bodyController.text;

    final response = await http.put(
        Uri.parse(updatedNote.url.toString()), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(updatedNote.toJson()));

    if(response.statusCode == 200){
      print('updated');
      Navigator.pop(context);
    }
  }
}
