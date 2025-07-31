final class HomeViewState {
  const HomeViewState({required this.currentPage});

  final int currentPage;

  HomeViewState copyWith({int? currentPage}) {
    return HomeViewState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
