import 'package:flutter/material.dart';
import 'package:my_tasks_app/config/theme/utils/font_extension_theme.dart';
import 'package:my_tasks_app/ui/widgets/widgets.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 0,
                top: 8,
                bottom: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Titulo', style: context.textTheme.bodyLarge),
                          Text('Subtitulo', style: context.textTheme.bodySmall),
                        ],
                      ),
                      CustomButton(
                        onPressed: () {},
                        buttonType: CustomButtonType.icon,
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  const Chip(label: Text('Pendiente')),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
