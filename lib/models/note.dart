

class Note {
  String imageURL;
  String title;
  String subTitle;

  Note({this.imageURL, this.title, this.subTitle});

  Note.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subTitle;
    return data;
  }
}