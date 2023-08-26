import 'package:flutter/material.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/ui/add_note.dart';
import 'package:notes_app/ui/update_note.dart';
import 'package:notes_app/utils/service.dart';
import 'package:http/http.dart' as http;

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    Service service = Service();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNotes(),
              )).then((value) {
            setState(() {});
          });
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: service.getNotes(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  print(snapshot);
                  print(snapshot.data);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      NotesModel note =
                          NotesModel.fromJson(snapshot.data![index]);
                      return ListTile(
                        leading: Icon(Icons.note),
                        title: Text(note.title.toString()),
                        subtitle: Text(note.body.toString()),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateNote(note: note),)).then((value) {
                            setState(() {

                            });
                          });
                        },
                        onLongPress: () async {
                          final response = await http.delete(
                            Uri.parse(note.url.toString()),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                          );
                          if(response.statusCode==204){
                            print('Deleted');
                            setState(() {

                            });
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
