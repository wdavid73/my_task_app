import 'package:flutter/material.dart';
import 'package:my_tasks_app/config/theme/theme.dart';
import 'package:my_tasks_app/data/models/task_model.dart';
import 'package:my_tasks_app/domain/entities/task_entity.dart';

class CustomPopupMenu extends StatelessWidget {
  final void Function(String type) onTap;
  final TaskModel task;
  final List<PopupMenuEntry>? extraOptions;

  const CustomPopupMenu({
    super.key,
    required this.onTap,
    this.extraOptions,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert_rounded, color: ColorTheme.primaryColor),
      popUpAnimationStyle: const AnimationStyle(
        curve: Easing.standardDecelerate,
        duration: Duration(milliseconds: 300),
      ),
      itemBuilder: (context) => <PopupMenuEntry>[
        if (task.status == TaskStatus.pending)
          PopupMenuItem(
            onTap: () => onTap('promote_to_complete'),
            padding: EdgeInsets.zero,
            child: const CustomMenuItem(icon: Icons.check, title: 'Completar'),
          ),

        PopupMenuItem(
          onTap: () => onTap('delete'),
          padding: EdgeInsets.zero,
          child: const CustomMenuItem(icon: Icons.delete, title: 'Eliminar'),
        ),
      ],
    );
  }
}

class CustomMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const CustomMenuItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: context.dp(2.3),
        color: ColorTheme.primaryColor,
      ),
      title: Text(
        title,
        style: context.textTheme.titleMedium?.copyWith(
          color: ColorTheme.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
