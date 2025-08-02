import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_tasks_app/application/blocs/tasks/tasks_bloc.dart';
import 'package:my_tasks_app/application/helpers/stream_helper.dart';
import 'package:my_tasks_app/data/models/task_model.dart';
import 'package:my_tasks_app/ui/shared/inputs/inputs.dart';

part 'task_form_state.dart';

@injectable
class TaskFormCubit extends Cubit<TaskFormState> {
  final TaskBloc bloc;
  TaskFormCubit(this.bloc) : super(const TaskFormState());

  void onSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    emit(state.copyWith(isPosting: true));

    final Map<String, dynamic> data = {
      'title': state.title.value,
      'description': state.description,
      'date': state.date.value,
      'tags': state.tags,
    };

    bloc.createTasks(TaskModel.fromJson(data));

    await waitForState(
      stream: bloc.stream,
      condition: (state) =>
          state.createStatus == CreateStatus.error ||
          state.createStatus == CreateStatus.success,
    );

    emit(state.copyWith(isPosting: true));
  }

  void titleChanged(String value) {
    final title = TextInput.dirty(value: value);

    emit(state.copyWith(title: title, isValid: Formz.validate([title])));
  }

  void descriptionChanged(String value) {
    emit(
      state.copyWith(
        description: value,
        isValid: Formz.validate([state.title]),
      ),
    );
  }

  void dateChanged(DateTime value) {
    final date = Date.dirty(value: value);

    emit(
      state.copyWith(date: date, isValid: Formz.validate([date, state.title])),
    );
  }

  void tagsChanged(List<String> newTags) {
    emit(state.copyWith(tags: newTags));
  }

  void setFormField(TaskModel? task) {
    if (task == null) {
      emit(
        state.copyWith(
          id: 'new',
          title: const TextInput.pure(),
          description: '',
          date: const Date.pure(),
          tags: [],
        ),
      );
    }
  }

  void _touchEveryField() {
    final title = TextInput.dirty(value: state.title.value);
    final date = Date.dirty(value: state.date.value);

    emit(
      state.copyWith(
        title: title,
        date: date,
        isValid: Formz.validate([title, date]),
      ),
    );
  }
}
