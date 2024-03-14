abstract class HomeEvent {
  const HomeEvent();
}

class DoneTaskEvent extends HomeEvent {
  final bool done;
  const DoneTaskEvent({required this.done});
}
