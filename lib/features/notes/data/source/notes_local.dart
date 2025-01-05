import 'package:quiz_me/main/imports.dart';

const cachedNotes = 'NOTES_DETAILS';
const lastNotesCache = 'NOTES_CACHE_EXPIRE';

abstract class NotesLocalSource {
  Future<bool> checkDatabase({required String contentID});

  Future<void> addNotes({required NotesModel data});

  Future<NotesModel> getNotes({required String contentID});

  Future<void> updateNotes({required String contentID});

  Future<void> deleteNotes({required String contentID});
}

class NotesLocal implements NotesLocalSource {
  final box = Hive.box<NotesModel>(cachedNotes);
  @override
  Future<void> addNotes({required NotesModel data}) {
    try {
      return box.add(data);
    } on CacheFailure {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteNotes({required String contentID}) async {
    try {
      final key =
          box.values.firstWhere((value) => contentID == value.contentID).key;
      box.delete(key);
    } on CacheFailure {
      throw CacheException();
    }
  }

  @override
  Future<NotesModel> getNotes({required String contentID}) async {
    try {
      return box.values.firstWhere((value) => contentID == value.contentID);
    } on CacheFailure {
      throw CacheException();
    }
  }

  @override
  Future<void> updateNotes({required String contentID}) async {
    try {
      final data =
          box.values.firstWhere((value) => contentID == value.contentID);
      final key = data.key;
      box.put(key, NotesModel.fromJson(data.toJson()));
    } on CacheFailure {
      throw CacheException();
    }
  }

  @override
  Future<bool> checkDatabase({required String contentID}) async {
    try {
      final exists = box.values.any((value) => value.contentID == contentID);
      return exists;
    } on CacheFailure {
      throw CacheException();
    }
  }
}
