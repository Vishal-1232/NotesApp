class NotesModel {
  String? url;
  String? title;
  String? body;

  NotesModel({this.url, this.title, this.body});

  NotesModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
