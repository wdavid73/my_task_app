part of 'task_form_cubit.dart';

class TaskFormState extends Equatable {
  final String? id;
  final TextInput title;
  final String description;
  final List<String> tags;
  final Date date;
  final bool isValid;
  final bool isPosting;

  const TaskFormState({
    this.id,
    this.title = const TextInput.pure(),
    this.description = '',
    this.date = const Date.pure(),
    this.tags = const [],
    this.isPosting = false,
    this.isValid = false,
  });

  @override
  List<Object> get props => [
    title,
    description,
    date,
    tags,
    isPosting,
    isValid,
  ];

  TaskFormState copyWith({
    String? id,
    TextInput? title,
    String? description,
    Date? date,
    bool? isValid,
    bool? isPosting,
    List<String>? tags,
  }) => TaskFormState(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    date: date ?? this.date,
    tags: tags ?? this.tags,
    isValid: isValid ?? this.isValid,
    isPosting: isPosting ?? this.isPosting,
  );
}
