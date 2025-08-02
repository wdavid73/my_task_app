enum TaskStatus {
  highPriority,
  mediumPriority,
  lowPriority,
  inProgress,
  pending,
  completed,
  postponed,
}

extension TaskStatusExtension on TaskStatus {
  String get key {
    switch (this) {
      case TaskStatus.highPriority:
        return 'highPriority';
      case TaskStatus.mediumPriority:
        return 'mediumPriority';
      case TaskStatus.lowPriority:
        return 'lowPriority';
      case TaskStatus.inProgress:
        return 'inProgress';
      case TaskStatus.pending:
        return 'pending';
      case TaskStatus.completed:
        return 'completed';
      case TaskStatus.postponed:
        return 'postponed';
    }
  }

  static TaskStatus? fromLabel(String label) {
    return TaskStatus.values.firstWhere(
      (status) => status.key == label,
      orElse: () => TaskStatus.pending,
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
