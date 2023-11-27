import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String description;
  final bool checked;

  Task({
    required this.id,
    required this.description,
    required this.checked,
  });

  @override
  List<Object?> get props => [id, description, checked];
}
