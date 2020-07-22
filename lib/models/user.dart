import 'note.dart';



class User{
  final _uid;
  final _uname;
  final _nickName;
  String profilePicture;
  List<Note> _notes;
  User(this._uid, this._uname, this._nickName);



  List<Note> get notes{
    return _notes;
  }
  set notes(List<Note> notes){
    _notes = _notes = notes;
  }
  addNote(Note note){
    if(_notes == null)
      _notes = new List<Note>();
    _notes.add(note);
  }
  removeNote(Note note){
    _notes.remove(note);
  }



}

