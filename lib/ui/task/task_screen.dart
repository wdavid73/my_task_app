import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_tasks_app/application/blocs/tasks/tasks_bloc.dart';
import 'package:my_tasks_app/application/cubits/task_form_cubit/task_form_cubit.dart';
import 'package:my_tasks_app/config/theme/utils/font_extension_theme.dart';
import 'package:my_tasks_app/core/di/injection.dart';
import 'package:my_tasks_app/ui/shared/styles/app_spacing.dart';
import 'package:my_tasks_app/ui/widgets/custom_date_picker_field.dart';
import 'package:my_tasks_app/ui/widgets/custom_multi_select_field.dart';

import 'package:my_tasks_app/ui/widgets/widgets.dart';
import 'package:my_tasks_app/utils/status.dart';

class TaskScreen extends StatelessWidget {
  final String taskIndex;
  const TaskScreen({super.key, required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    final taskForm = getIt.get<TaskFormCubit>();
    final taskBloc = getIt.get<TaskBloc>();

    return AdaptiveScaffold(
      appBar: AppBar(title: const Text('Tarea')),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<TaskFormCubit>.value(value: taskForm),
              BlocProvider.value(value: taskBloc),
            ],
            child: const _Form(),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  @override
  void initState() {
    super.initState();
    context.read<TaskFormCubit>().setFormField(null);
  }

  void _listener(BuildContext context, TaskState state) {
    if (state.createStatus == CreateStatus.success) {
      if (context.canPop()) {
        context.pop();
      }
    }

    if (state.createStatus == CreateStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TaskFormCubit>();
    final state = context.watch<TaskFormCubit>().state;

    return BlocListener<TaskBloc, TaskState>(
      listener: _listener,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          Text('Crear Tarea', style: context.textTheme.titleLarge),
          Text(
            'Completa los campos para definir una nueva tarea. Podes agregar un título, una descripción, establecer prioridades, asignar fecha y más.',
            style: context.textTheme.bodyLarge,
          ),
          AppSpacing.md,
          CustomTextFormField(
            onChanged: cubit.titleChanged,
            label: 'Titulo',
            hint: 'Titulo de la tarea',
            errorMessage: state.title.errorMessage,
          ),
          CustomDatePickerField(
            hintText: 'Fecha',
            onChanged: cubit.dateChanged,
            errorMessage: state.date.errorMessage,
          ),
          CustomTextFormField(
            onChanged: cubit.descriptionChanged,
            label: 'Descripción',
            hint: 'Descripción de la tarea',
            maxLines: 3,
          ),
          CustomMultiSelectField(
            hintText: 'Selecciona estados',
            label: 'Estados de la tarea',
            items: TaskTags.values.map((e) => e.key).toList(),
            selectedItems: state.tags,
            onSelectedItemsChanged: (items) => cubit.tagsChanged(items),
            displayTextBuilder: (items) => items?.join(', ') ?? '',
          ),

          const Spacer(),
          CustomButton(
            onPressed: state.isPosting ? null : () => cubit.onSubmit(),
            isLoading: state.isPosting,
            label: 'Guardar Tarea',
          ),
        ],
      ),
    );
  }
}
