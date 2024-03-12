abstract class InputEvent {
  const InputEvent();
}

class TaskEvent extends InputEvent {
  final String? task;
  const TaskEvent({required this.task});
}

class DateAndTimeEvent extends InputEvent {
  final DateTime? dateTime;
  const DateAndTimeEvent({required this.dateTime});
}

class RecurrenceEvent extends InputEvent {
  final String? duration;
  const RecurrenceEvent({required this.duration});
}

class ListEvent extends InputEvent {
  final String? list;
  const ListEvent({required this.list});
}
