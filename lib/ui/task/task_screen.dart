import 'package:flutter/material.dart';
import 'package:my_tasks_app/config/theme/utils/font_extension_theme.dart';
import 'package:my_tasks_app/ui/shared/styles/app_spacing.dart';
import 'package:my_tasks_app/ui/widgets/custom_multi_select_field.dart';

import 'package:my_tasks_app/ui/widgets/widgets.dart';
import 'package:my_tasks_app/utils/status.dart';

class TaskScreen extends StatelessWidget {
  final String taskId;
  const TaskScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AppBar(title: const Text('Tarea')),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            Text('Crear Tarea', style: context.textTheme.titleLarge),
            Text(
              'Completa los campos para definir una nueva tarea. Podes agregar un título, una descripción, establecer prioridades, asignar estados y más.',
              style: context.textTheme.bodyLarge,
            ),
            AppSpacing.md,
            CustomTextFormField(
              onChanged: (value) {},
              label: 'Titulo',
              hint: 'Titulo de la tarea',
            ),
            CustomTextFormField(
              onChanged: (value) {},
              label: 'Descripción',
              hint: 'Descripción de la tarea',
            ),
            CustomMultiSelectField(
              hintText: 'Selecciona estados',
              label: 'Estados de la tarea',
              items: TaskStatus.values.map((e) => e.key).toList(),
              selectedItems: [],
              onSelectedItemsChanged: (items) {},
              displayTextBuilder: (items) => items?.join(', ') ?? '',
            ),
            const Spacer(),
            CustomButton(onPressed: () {}, label: 'Guardar Tarea'),
          ],
        ),
      ),
    );
  }
}
