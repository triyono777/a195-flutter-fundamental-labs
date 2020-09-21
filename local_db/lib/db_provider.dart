import 'package:flutter/foundation.dart';
import 'package:local_db/database_service.dart';
import 'package:local_db/note.dart';

class DbProvider extends ChangeNotifier {
  List<Note> _notes = [];
  DatabaseHelper _dbHelper;

  List<Note> get notes => _notes;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllNotes();
  }

  Future<void> addNote(Note note) async {
    await _dbHelper.insertNote(note);
    _getAllNotes();
    notifyListeners();
  }

  void _getAllNotes() async {
    _notes = await _dbHelper.getNotes();
    notifyListeners();
  }

  Future<Note> openNote(int id) async {
    return await _dbHelper.getNoteById(id);
  }

  void updateNote(Note note) async {
    await _dbHelper.updateNote(note);
    _getAllNotes();
    notifyListeners();
  }

  void deleteNote(int id) async {
    await _dbHelper.deleteNote(id);
    _getAllNotes();
    notifyListeners();
  }
}
