

class Note {
  String imageURL;
  String title;
  String subTitle;
  String id;
  DateTime dueDate;

  Note({this.imageURL, this.title, this.subTitle});

  Note.fromJson(Map<String, dynamic> json, documentID) {
    title = json['title'];
    subTitle = json['subtitle'];
    id = documentID;
    dueDate = json['dueDate']!=null ? json['dueDate'].toDate(): DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subTitle;
    data['dueDate'] = this.dueDate;
    return data;
  }
}