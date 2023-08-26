import 'dart:convert';
import 'package:http/http.dart' as http;

import 'app_urls.dart';

class Service{
  Future<List<dynamic>> getNotes()async{
    final response = await http.get(Uri.parse(AppUrls.getNotesApi));
    print('asdsa');
    if(response.statusCode == 200){
      print('objectasss');
        var data = jsonDecode(response.body.toString());
        return data;
    }else{
      throw Exception('Error');
    }
  }
}