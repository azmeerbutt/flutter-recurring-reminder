import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reccuring_reminder/pages/input/bloc/input_event.dart';
import 'package:flutter_reccuring_reminder/pages/input/bloc/input_state.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  InputBloc() : super(InputState()) {
    on<TaskEvent>(_taskEvent);
    on<DateAndTimeEvent>(_dateTimeEvent);
    on<RecurrenceEvent>(_recurrenceEvent);
    on<ListEvent>(_listEvent);
  }

  void _taskEvent(TaskEvent event, Emitter<InputState> emit) {
    emit(state.copywith(task: event.task));
  }

  void _dateTimeEvent(DateAndTimeEvent event, Emitter<InputState> emit) {
    emit(state.copywith(dateTime: event.dateTime));
  }

  void _recurrenceEvent(RecurrenceEvent event, Emitter<InputState> emit) {
    emit(state.copywith(duration: event.duration));
  }

  void _listEvent(ListEvent event, Emitter<InputState> emit) {
    emit(state.copywith(list: event.list));
  }
}
