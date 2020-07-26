

class Note {
  String imageURL;
  String title;
  String subTitle;
  String id;

  Note({this.imageURL, this.title, this.subTitle});

  Note.fromJson(Map<String, dynamic> json, documentID) {
    title = json['title'];
    subTitle = json['subtitle'];
    id = documentID;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subTitle;
    return data;
  }
}