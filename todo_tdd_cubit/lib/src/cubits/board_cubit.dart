import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_tdd_cubit/src/repositories/board_repository.dart';
import 'package:todo_tdd_cubit/src/states/board_state.dart';

import '../models/task.dart';

class BoardCubit extends Cubit<BoardState> {
  final IBoardRepository boardRepository;

  BoardCubit(this.boardRepository) : super(EmptyBoardState());

  Future<void> fetchTasks() async {
    emit(LoadingBoardState());

    try {
      final tasks = await boardRepository.fetch();
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState('Error'));
    }
  }

  Future<void> addTask(Task task) async {
    final tasks = _getTasks();

    if (tasks == null) return;

    tasks.add(task);

    await emitTasks(tasks);
  }

  Future<void> removeTask(Task task) async {
    final tasks = _getTasks();

    if (tasks == null) return;

    tasks.remove(task);

    await emitTasks(tasks);
  }

  Future<void> checkTask(Task task) async {
    final tasks = _getTasks();

    if (tasks == null) return;

    final index = tasks.indexOf(task);
    tasks[index] = task.copyWith(checked: !tasks[index].checked);

    await emitTasks(tasks);
  }

  // metodo helper pra test
  @visibleForTesting
  void addTasks(List<Task> tasks) {
    emit(GettedTasksBoardState(tasks: tasks));
  }

  List<Task>? _getTasks() {
    final state = this.state;

    if (state is! GettedTasksBoardState) {
      return null;
    }

    // Trabalha na cópia da lista, conceito de imutabilidade
    // deep copy
    return state.tasks.toList();
  }

  Future<void> emitTasks(List<Task> tasks) async {
    try {
      await boardRepository.update(tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState('Error'));
    }
  }
}
