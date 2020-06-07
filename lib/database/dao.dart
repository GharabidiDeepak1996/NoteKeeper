
import 'package:floor/floor.dart';

import 'entity.dart';

@dao
abstract class NoteDao {

  @insert
  Future<void> insertPerson(Note note);

  @Query('SELECT * FROM Note')
  Future<List<Note>> findAllNotes();

  @Query('DELETE FROM Note WHERE Id = :userId"')
  Future<void> deleteParticularItem(int userId); // query without returning an entity

}