import 'package:nodelabs_case_study/product/base/base_cubit.dart';
import 'package:nodelabs_case_study/view_model/home/home_view_state.dart';

class HomeViewModel extends BaseCubit<HomeViewState> {
  HomeViewModel()
      : super(
          const HomeViewState(currentPage: 0),
        );

  void changeCurrentPage(int newPage) {
    emit(state.copyWith(currentPage: newPage));
  }
}
