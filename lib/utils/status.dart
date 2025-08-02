enum TaskTags {
  work,
  study,
  personal,
  home,
  health,
  finance,
  shopping,
  project,
  freelance,
  urgent,
}

extension TaskStatusExtension on TaskTags {
  String get key {
    switch (this) {
      case TaskTags.work:
        return 'work';
      case TaskTags.study:
        return 'study';
      case TaskTags.personal:
        return 'personal';
      case TaskTags.home:
        return 'home';
      case TaskTags.health:
        return 'health';
      case TaskTags.finance:
        return 'finance';
      case TaskTags.shopping:
        return 'shopping';
      case TaskTags.freelance:
        return 'freelance';
      case TaskTags.urgent:
        return 'urgent';
      case TaskTags.project:
        return 'project';
    }
  }

  static TaskTags? fromLabel(String label) {
    return TaskTags.values.firstWhere(
      (status) => status.key == label,
      orElse: () => TaskTags.personal,
    );
  }

  // This method assumes you will have your localized strings
  // defined using something like AppLocalizations.of(context).highPriority
  /*String localized(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case TaskStatus.highPriority:
        return l10n.highPriority;
      case TaskStatus.mediumPriority:
        return l10n.mediumPriority;
      case TaskStatus.lowPriority:
        return l10n.lowPriority;
      case TaskStatus.inProgress:
        return l10n.inProgress;
      case TaskStatus.pending:
        return l10n.pending;
      case TaskStatus.completed:
        return l10n.completed;
      case TaskStatus.postponed:
        return l10n.postponed;
    }
  }*/
}
