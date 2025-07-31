import 'package:auto_route/auto_route.dart';
import 'package:nodelabs_case_study/view/add_profile_picture/add_profile_picture.dart';
import 'package:nodelabs_case_study/view/home/home_view.dart';
import 'package:nodelabs_case_study/view/login/login_view.dart';
import 'package:nodelabs_case_study/view/movie_scroll_view/movie_scroll_view.dart';
import 'package:nodelabs_case_study/view/profile_details/profile_details_view.dart';
import 'package:nodelabs_case_study/view/register/register_view.dart';
import 'package:nodelabs_case_study/view/splash/splash_view.dart';

part 'route_manager.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
final class RouteManager extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
          type: const RouteType.cupertino(),
        ),
        AutoRoute(
          page: HomeRoute.page,
          type: const RouteType.cupertino(),
        ),
        AutoRoute(
          page: LoginRoute.page,
          type: const RouteType.cupertino(),
        ),
        AutoRoute(
          page: RegisterRoute.page,
          type: const RouteType.cupertino(),
        ),
        AutoRoute(
          page: AddProfilePictureRoute.page,
          type: const RouteType.cupertino(),
        ),
        AutoRoute(
          page: MovieScrollRoute.page,
          type: const RouteType.cupertino(),
        ),
        AutoRoute(
          page: ProfileDetailsRoute.page,
          type: const RouteType.cupertino(),
        ),
      ];
}
