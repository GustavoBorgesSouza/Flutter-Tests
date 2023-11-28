import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_tdd_cubit/src/cubits/board_cubit.dart';
import 'package:todo_tdd_cubit/src/models/task.dart';
import 'package:todo_tdd_cubit/src/repositories/board_repository.dart';
import 'package:todo_tdd_cubit/src/states/board_state.dart';

class BoardRepositoryMock extends Mock implements IBoardRepository {}

void main() {
  final repository = BoardRepositoryMock();
  final cubit = BoardCubit(repository);

  tearDown(() => reset(repository));
  group(
    'fetchTasks | ',
    () {
      test(
        'Must get all tasks',
        () async {
          when(() => repository.fetch()).thenAnswer(
            (_) async => [
              const Task(id: 'id', description: 'Task real', checked: false),
            ],
          );

          expect(
            cubit.stream,
            emitsInOrder([
              isA<LoadingBoardState>(),
              isA<GettedTasksBoardState>(),
            ]),
          );

          await cubit.fetchTasks();
        },
      );

      test(
        'Must Return a Failure State when failing',
        () async {
          when(() => repository.fetch()).thenThrow(
            Exception('Error'),
          );

          expect(
            cubit.stream,
            emitsInOrder([
              isA<LoadingBoardState>(),
              isA<FailureBoardState>(),
            ]),
          );

          await cubit.fetchTasks();
        },
      );
    },
  );
}
