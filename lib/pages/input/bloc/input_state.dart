class InputState {
  final String? task;
  final DateTime? dateTime;
  final String? duration;
  final String? list;
  InputState({
    this.task = '',
    DateTime? dateTime,
    this.duration = 'No recurrence',
    this.list = 'Default',
  }) : dateTime = dateTime ?? DateTime.now();

  InputState copywith({
    String? task,
    DateTime? dateTime,
    String? duration,
    String? list,
  }) {
    return InputState(
      task: task ?? this.task,
      dateTime: dateTime ?? this.dateTime,
      duration: duration ?? this.duration,
      list: list ?? this.list,
    );
  }
}
