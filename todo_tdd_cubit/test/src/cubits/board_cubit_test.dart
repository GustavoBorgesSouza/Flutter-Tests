import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_tdd_cubit/src/cubits/board_cubit.dart';
import 'package:todo_tdd_cubit/src/models/task.dart';
import 'package:todo_tdd_cubit/src/repositories/board_repository.dart';
import 'package:todo_tdd_cubit/src/states/board_state.dart';

class BoardRepositoryMock extends Mock implements IBoardRepository {}

void main() {
  late BoardRepositoryMock repository = BoardRepositoryMock();
  late BoardCubit cubit;

  setUp(() {
    repository = BoardRepositoryMock();
    cubit = BoardCubit(repository);
  });
  group(
    'fetchTasks | ',
    () {
      test(
        'Must get all tasks',
        () async {
          when(() => repository.fetch()).thenAnswer(
            (_) async => [
              const Task(id: 'id', description: 'Task real'),
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

  group(
    'addTask | ',
    () {
      test(
        'Must add a task',
        () async {
          when(() => repository.update(any())).thenAnswer((_) async => []);

          expect(
            cubit.stream,
            emitsInOrder([
              isA<GettedTasksBoardState>(),
            ]),
          );

          const task = Task(id: 'Id', description: 'Description');
          await cubit.addTask(task);

          final state = cubit.state as GettedTasksBoardState;

          expect(state.tasks.length, 1);
          expect(state.tasks, [task]);
        },
      );

      test(
        'Must Return a Failure State when failing',
        () async {
          when(() => repository.update(any())).thenThrow(
            Exception('Error'),
          );

          expect(
            cubit.stream,
            emitsInOrder([
              isA<FailureBoardState>(),
            ]),
          );

          const task = Task(id: 'Id', description: 'Description');

          await cubit.addTask(task);
        },
      );
    },
  );
  group(
    'removeTask | ',
    () {
      test(
        'Must remove a task',
        () async {
          when(() => repository.update(any())).thenAnswer((_) async => []);
          const task = Task(id: 'Id', description: 'Description');
          cubit.addTasks([task]);
          expect((cubit.state as GettedTasksBoardState).tasks.length, 1);

          expect(
            cubit.stream,
            emitsInOrder([
              isA<GettedTasksBoardState>(),
            ]),
          );

          await cubit.removeTask(task);
          final state = cubit.state as GettedTasksBoardState;
          expect(state.tasks.length, 0);
        },
      );

      test(
        'Must Return a Failure State when failing',
        () async {
          when(() => repository.update(any())).thenThrow(
            Exception('Error'),
          );

          const task = Task(id: 'Id', description: 'Description');
          cubit.addTasks([task]);
          expect((cubit.state as GettedTasksBoardState).tasks.length, 1);

          expect(
            cubit.stream,
            emitsInOrder([
              isA<FailureBoardState>(),
            ]),
          );

          await cubit.removeTask(task);
        },
      );
    },
  );
  group(
    'checkTask | ',
    () {
      test(
        'Must check a task',
        () async {
          when(() => repository.update(any())).thenAnswer((_) async => []);
          const task = Task(id: 'Id', description: 'Description');
          cubit.addTasks([task]);
          expect((cubit.state as GettedTasksBoardState).tasks.length, 1);
          expect((cubit.state as GettedTasksBoardState).tasks.first.checked,
              false);

          expect(
            cubit.stream,
            emitsInOrder([
              isA<GettedTasksBoardState>(),
            ]),
          );

          await cubit.checkTask(task);
          final state = cubit.state as GettedTasksBoardState;
          expect((cubit.state as GettedTasksBoardState).tasks.length, 1);
          expect(state.tasks.first.checked, true);
        },
      );

      test(
        'Must Return a Failure State when failing',
        () async {
          when(() => repository.update(any())).thenThrow(
            Exception('Error'),
          );

          const task = Task(id: 'Id', description: 'Description');
          cubit.addTasks([task]);
          expect((cubit.state as GettedTasksBoardState).tasks.length, 1);

          expect(
            cubit.stream,
            emitsInOrder([
              isA<FailureBoardState>(),
            ]),
          );

          await cubit.checkTask(task);
        },
      );
    },
  );
}
