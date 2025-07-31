import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodelabs_case_study/product/constant/color.dart';
import 'package:nodelabs_case_study/product/language/locale_keys.g.dart';
import 'package:nodelabs_case_study/product/navigation/route_manager.dart';
import 'package:nodelabs_case_study/view/profile_details/profile_details_view_mixin.dart';
import 'package:nodelabs_case_study/view_model/favorite_movies/favorite_movies_view_model.dart';
import 'package:nodelabs_case_study/view_model/user_credentials/user_credential_state.dart';
import 'package:nodelabs_case_study/view_model/user_credentials/user_credential_view_model.dart';

@RoutePage()
class ProfileDetailsView extends StatefulWidget {
  const ProfileDetailsView({super.key});

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView>
    with ProfileDetailsViewMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              LocaleKeys.pages_profile_title.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            actions: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: BorderRadius.circular(53),
                ),
                child: GestureDetector(
                  onTap: () => showLimitedOfferSheet(context),
                  child: Row(
                    children: [
                      Image.asset('assets/images/gem.png'),
                      const SizedBox(width: 8),
                      Text(
                        LocaleKeys.pages_profile_limited_offer_text.tr(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  BlocBuilder<UserCredentialViewModel, UserCredentialState>(
                    builder: (context, userCredentialState) {
                      if (userCredentialState.photoUrl == null ||
                          userCredentialState.photoUrl!.isEmpty) {
                        return CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey[700],
                          ),
                        );
                      }
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              userCredentialState.photoUrl!,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userCredentialState.name ?? 'Unknown User',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  '''ID: ${userCredentialState.id ?? 'Unknown'}''',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () =>
                        context.router.push(const AddProfilePictureRoute()),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        LocaleKeys.pages_profile_add_photo.tr(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                LocaleKeys.pages_profile_favorite_movies.tr(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: BlocBuilder<FavoriteMoviesViewModel,
                      FavoriteMoviesViewState>(
                    builder: (context, state) {
                      if (state.movies.isEmpty && state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: List.generate(
                          state.movies.length,
                          (index) => LayoutBuilder(
                            builder: (context, constraints) {
                              final movie = state.movies[index];

                              const totalSpacing = 2 * 12;
                              final cardWidth =
                                  (constraints.maxWidth - totalSpacing) / 2;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: cardWidth,
                                    height: 250,
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        movie.poster ??
                                            'https://picsum.photos/400/800',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              'https://picsum.photos/seed/$index/400/800',
                                              fit: BoxFit.fill,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title ?? 'Unknown Title',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          movie.country ?? 'Unknown Country',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Colors.grey,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
