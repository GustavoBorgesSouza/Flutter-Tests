import 'package:bloc/bloc.dart';
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
    final state = this.state;

    if (state is! GettedTasksBoardState) {
      return;
    }

    final tasks = state.tasks.toList();

    tasks.add(task);
    try {
      await boardRepository.update(tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoardState('Error'));
    }
  }

  Future<void> removeTask(Task task) async {}

  Future<void> checkTask(Task task) async {}
}
