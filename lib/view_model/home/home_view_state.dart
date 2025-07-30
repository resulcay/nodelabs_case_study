final class HomeViewState {
  const HomeViewState({
    required this.isLoading,
    required this.isEmpty,
  });

  final bool isLoading;
  final bool isEmpty;

  HomeViewState copyWith({bool? isLoading, bool? isEmpty}) {
    return HomeViewState(
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }
}
