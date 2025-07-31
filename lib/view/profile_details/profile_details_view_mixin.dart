import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodelabs_case_study/product/global/global_declaration.dart';
import 'package:nodelabs_case_study/view/profile_details/profile_details_view.dart';
import 'package:nodelabs_case_study/view_model/favorite_movies/favorite_movies_view_model.dart';

mixin ProfileDetailsViewMixin on State<ProfileDetailsView> {
  @override
  void initState() {
    _loadCredentials();
    context.read<FavoriteMoviesViewModel>().fetchFavoriteMovies();
    super.initState();
  }

  Future<void> _loadCredentials() async {
    await userCredentialViewModel.loadCredentials();
  }
}
