import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import 'dart:convert';

class AppProvider extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  AppProvider() {
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getStringList('notes') ?? [];
    _notes = notesJson.map((noteStr) {
      final map = json.decode(noteStr);
      return Note(id: map['id'], name: map['title'], content: map['content']);
    }).toList();
    notifyListeners();
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = _notes
        .map(
          (note) => json.encode({
            'id': note.id,
            'title': note.name,
            'content': note.content,
          }),
        )
        .toList();
    await prefs.setStringList('notes', notesJson);
  }

  void addNote(String name, String content) {
    final newNote = Note(id: const Uuid().v4(), name: name, content: content);
    _notes.add(newNote);
    _saveNotes();
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    _saveNotes();
    notifyListeners();
  }

  String username = "broklis";

  void updateUsername(String name) {
    username = name;
    notifyListeners();
  }
}
