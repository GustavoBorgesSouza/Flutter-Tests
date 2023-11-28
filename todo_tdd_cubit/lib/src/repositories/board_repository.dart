import '../models/task.dart';

abstract class IBoardRepository {
  Future<List<Task>> fetch();
  Future<List<Task>> update(List<Task> tasks);
}
