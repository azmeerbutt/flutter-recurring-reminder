class HomeState {
  final bool done;
  const HomeState({this.done = false});

  HomeState copywith({required bool done}) {
    return HomeState(done: done);
  }
}
